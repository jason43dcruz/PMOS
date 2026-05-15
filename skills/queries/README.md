# Queries

SQL queries for tracking key metrics across projects. Run via Socrates (Databricks).

## Service Collection Uplift

**Query:** `servco-uplift-kr.sql`  
**Related Goal:** [ATLAS-117783 - Service Collection Uplift](https://home.atlassian.com/o/2346a038-3c8c-498b-a79b-e7847859868d/s/a436116f-02ce-4520-8fbb-7301462a1674/goal/ATLAS-117783/about)  
**Priority:** P0  
**Target:** Feb 1–Jun 30, 2026  
**What it measures:** % of JSM organizations with all licenses uplifted to Service Collection, split by Paid vs. Free orgs  
**Baseline:** Dec 31, 2025  
**How to run:** Paste into Databricks SQL editor or run via `databricks sql < servco-uplift-kr.sql`

## Feature Usage by Edition (Template)

**Query:** `feature-usage-by-edition-template.sql`  
**Related Goal:** Edition strategy  
**What it measures:** Feature activation % by edition (28d window). Scalable template — swap the `feature_active` CTE for any JSM feature. Includes reference swaps for Change Management, Incident Management, Problem Management, Assets, Virtual Agent, Automation, Smart Summaries, Deployment Gating, Heartbeat Monitoring, and more.  
**Validated:** Change Management results match agg table pre-computed flags within rounding error (25.7% vs 25.5%).  
**How to run:** Paste into Databricks SQL editor. Edit the `feature_active` CTE to target a different feature.

## Standard → Premium Readiness Signals

**Query:** `standard-premium-readiness-signals.sql`  
**Related Goal:** Edition strategy  
**What it measures:** Identifies Standard-edition tenants showing Premium-grade usage patterns. Scores each tenant on 5 signals: Assets (100+ objects), Incidents (10+ created), Alerts (500+ created), Change Management (5+ changes), Multiple service desks (5+ projects).  
**Last run:** 2026-04-13  
**Key finding:** 56% zero signals (Standard is home), 35.5% one signal (watch), 8.5% two+ signals (Premium-ready). ~$75M annual upgrade opportunity across 3,782 tenants.  
**How to run:** Paste into Databricks SQL editor.
