-- ============================================================
-- FEATURE USAGE BY EDITION — SCALEABLE TEMPLATE
-- ============================================================
-- Pattern: agg table as authoritative tenant roster (paid, active, deduped,
--           standalone primary). Raw log_behavioral_event for any feature signal.
--
-- To add a new feature: swap the feature_active CTE filter.
-- Reference: Core Action Mapping page
--   [YOUR_CONFLUENCE_URL]
--
-- KEY FACTS:
--   product_key in entitlement snapshot = 'jira-servicedesk.ondemand' (NOT 'jira-servicedesk')
--   entitlement snapshot latest day: 2026-04-07
--   agg table = "Standalone primary" entitlements only (~20K Premium, ~3K Enterprise, ~54K Standard)
--   join key: log_behavioral_event.tenant_id = agg.tenant_id (both cloudId format)
--
-- VALIDATED: raw query matches agg table pre-computed flag within rounding error (25.7% vs 25.5%)
-- ============================================================

WITH
-- Step 1: Authoritative tenant roster — paid, active, deduped, standalone primary
tenant_roster AS (
  SELECT DISTINCT
    tenant_id,
    entitlement_attributes['entitlement_edition'] AS edition
  FROM production.jsm_analytics.agg_jsm_higher_editions_entitlement_activity_snapshot_daily
  WHERE day = (
    SELECT MAX(day)
    FROM production.jsm_analytics.agg_jsm_higher_editions_entitlement_activity_snapshot_daily
  )
),

-- Step 2: Feature signal from raw events — SWAP THIS CTE FOR ANY FEATURE
-- ============================================================
-- CHANGE MANAGEMENT (current example)
feature_active AS (
  SELECT DISTINCT tenant_id
  FROM production.jsm_user_behavior.log_behavioral_event
  WHERE day >= DATE_FORMAT(DATE_SUB(CURRENT_DATE(), 28), 'yyyy-MM-dd')
    AND product.sub_product = 'serviceDesk'
    AND issue_attributes.itsm_practice LIKE '%change-management%'
    AND event_name IN (
      'issue created (server)',
      'issue updated (server)',
      'issue viewed (client)',
      'comment created (server)',
      'comment updated (server)',
      'comment deleted (server)'
    )
)
-- ============================================================

-- Step 3: Join and aggregate
SELECT
  r.edition,
  COUNT(DISTINCT r.tenant_id)                                                             AS total_tenants,
  COUNT(DISTINCT f.tenant_id)                                                             AS feature_active_tenants,
  ROUND(100.0 * COUNT(DISTINCT f.tenant_id) / NULLIF(COUNT(DISTINCT r.tenant_id), 0), 1) AS pct_active
FROM tenant_roster r
LEFT JOIN feature_active f ON r.tenant_id = f.tenant_id
GROUP BY r.edition
ORDER BY r.edition;


-- ============================================================
-- REFERENCE: feature_active CTE swaps by feature
-- ============================================================

-- INCIDENT MANAGEMENT
--   AND issue_attributes.itsm_practice LIKE '%incident-management%'
--   AND event_name IN ('issue created (server)', 'issue updated (server)',
--                      'issue viewed (client)', 'comment created (server)',
--                      'comment updated (server)', 'comment deleted (server)')

-- PROBLEM MANAGEMENT
--   AND issue_attributes.itsm_practice LIKE '%problem-management%'
--   (same event_name list as above)

-- POST INCIDENT REVIEW
--   AND issue_attributes.itsm_practice LIKE '%post-incident-review%'
--   (same event_name list as above)

-- ASSETS
--   AND event_name IN (
--     'viewed insightFieldScreen',
--     'viewed cmdbObjectSchemaScreen',
--     'viewed cmdbObjectDetailsScreen',
--     'viewed insightSchemaOverviewPage',
--     'viewed singleInsightObjectScreen'
--   )
--   (no itsm_practice filter needed)

-- VIRTUAL AGENT
--   AND (lower(event_name) LIKE '%virtualagent%'
--     OR event_name IN ('virtualAgent created (client)', 'virtualAgentIntent created (client)'))

-- MAJOR INCIDENTS
--   AND event_name = 'majorIncidentLozenge viewed (client)'
--   AND issue_attributes.itsm_practice LIKE '%incident-management%'

-- AUTOMATION ([YOUR PRODUCT] rules)
--   AND event_name = 'ruleExecutor ruleFinished'
--   -- Note: operational event type; filter attributes['projectType'] = 'serviceDesk' if available

-- SMART SUMMARIES
--   AND event_name = 'button clicked'
--   AND attributes['actionSubjectId'] = 'smartSummarizeComments'

-- DEPLOYMENT GATING
--   AND event_name = 'deploymentPipelinesConfiguration saved (client)'

-- HEARTBEAT MONITORING
--   AND event_name = 'heartbeatTurnedOn succeeded (client)'

-- ============================================================
-- VALIDATED RESULTS — Change Management (28d window, Apr 2026)
-- ============================================================
-- Standard:    54,228 tenants |    833 active |  1.5%
-- Premium:     19,991 tenants |  5,089 active | 25.5%
-- Enterprise:   3,148 tenants |    647 active | 20.6%
