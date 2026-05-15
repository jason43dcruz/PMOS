# Skill: Create Excel Model (.xlsx)

Use this skill whenever the user asks for a financial model, opportunity sizing, or working spreadsheet in Excel format.

## When to use
- User asks for a model they can "tweak" or share
- Financial sizing with multiple input assumptions
- Waterfall / bridge analysis
- Anything with levers, scenarios, or sensitivity analysis

## Stack
- **Library:** `openpyxl` (pre-installed via `pip install openpyxl --break-system-packages`)
- **Output:** Real `.xlsx` file with formulas, multiple sheets, colour formatting
- **Pattern:** Write Python to a temp file (`tmp_rovodev_build_model.py`), run it, delete it

## Workbook Structure (default pattern)

Always create 3 sheets minimum:

### Sheet 1: Assumptions
- All **inputs in yellow** (`FFF2CC`) — user changes these
- **Sourced/locked data in grey** (`F2F2F2`) — clearly labelled with source
- Each assumption has a note column explaining source or "Assumption — unvalidated"
- Section headers in mid-blue (`2F75B6`)

### Sheet 2: Model
- All cells are **formulas referencing Assumptions sheet** — never hardcode values
- Calculations broken into clearly labelled sections (one per lever/stream)
- Totals in green (`E2EFDA`)
- Warning rows in orange (`FCE4D6`) for cells with low confidence or known issues
- Include a **SUMMARY block** at the bottom with all lever totals

### Sheet 3: Waterfall Summary
- Read-only one-pager pulling from Model sheet
- Shows the full ARR/value build from baseline → each lever → total
- Includes Confidence column (HIGH / MEDIUM / LOW / NONE)
- Includes Commentary column
- Ends with a "Key assumptions to validate" section

## Style Constants (copy-paste these)
```python
BLUE       = "1F4E79"   # title / main headers
MID_BLUE   = "2F75B6"   # section headers / column headers
LIGHT_BLUE = "BDD7EE"   # total rows / highlight
YELLOW     = "FFF2CC"   # editable inputs
GREEN      = "E2EFDA"   # output totals
GREY       = "F2F2F2"   # locked/sourced data
ORANGE     = "FCE4D6"   # warnings / TBD / low confidence
WHITE      = "FFFFFF"

# Number formats
M    = '#,##0'           # integers / counts
PCT  = '0.0%'            # percentages
DOL  = '"$"#,##0'        # dollars rounded
DOL1 = '"$"#,##0.0'      # dollars 1dp (for $M figures)
DOL2 = '"$"#,##0.00'     # dollars 2dp (for $/seat/month etc)
```

## Helper Functions (copy-paste these)
```python
from openpyxl.styles import Font, PatternFill, Alignment, Border, Side

def hdr(ws, r, c, v, bg=BLUE, fg=WHITE, bold=True, sz=10, wrap=False, ha="center"):
    cell = ws.cell(row=r, column=c, value=v)
    cell.font = Font(bold=bold, color=fg, size=sz)
    cell.fill = PatternFill("solid", fgColor=bg)
    cell.alignment = Alignment(horizontal=ha, vertical="center", wrap_text=wrap)
    return cell

def inp(ws, r, c, v, fmt=None, bg=YELLOW):
    """Yellow editable input cell"""
    cell = ws.cell(row=r, column=c, value=v)
    cell.fill = PatternFill("solid", fgColor=bg)
    cell.alignment = Alignment(horizontal="right", vertical="center")
    if fmt: cell.number_format = fmt
    return cell

def fml(ws, r, c, formula, fmt=None, bg=WHITE, bold=False):
    """Formula cell"""
    cell = ws.cell(row=r, column=c, value=formula)
    cell.alignment = Alignment(horizontal="right", vertical="center")
    if fmt: cell.number_format = fmt
    if bg != WHITE: cell.fill = PatternFill("solid", fgColor=bg)
    if bold: cell.font = Font(bold=True, size=10)
    return cell

def lbl(ws, r, c, v, bold=False, bg=WHITE, ind=0, ha="left"):
    """Label / text cell"""
    cell = ws.cell(row=r, column=c, value=v)
    cell.font = Font(bold=bold, size=10)
    cell.alignment = Alignment(horizontal=ha, vertical="center", indent=ind)
    if bg != WHITE: cell.fill = PatternFill("solid", fgColor=bg)
    return cell

def sec(ws, r, c, v, span=7):
    """Section header — spans multiple columns"""
    cell = ws.cell(row=r, column=c, value=v)
    cell.font = Font(bold=True, color=WHITE, size=10)
    cell.fill = PatternFill("solid", fgColor=MID_BLUE)
    cell.alignment = Alignment(horizontal="left", vertical="center", indent=1)
    ws.merge_cells(start_row=r, start_column=c, end_row=r, end_column=c+span-1)
    return cell

def thin_border(ws, r, cols):
    """Add thin bottom border to a row"""
    thin = Side(style="thin", color="BFBFBF")
    for c in cols:
        ws.cell(row=r, column=c).border = Border(bottom=thin)
```

## Key Rules
1. **Never hardcode a number in the Model sheet.** Every cell references Assumptions via Excel formulas (e.g. `=Assumptions!B5`). This is the #1 rule — if someone changes an assumption, the model updates automatically.
2. **Assumptions sheet layout:** Value in one cell, explanation/source in the neighbouring cell. Not merged, not buried in a note — visible side by side.
3. **Always label the source** of every input — "Sourced: [doc]" or "Assumption — unvalidated".
4. **Use formulas, not Python math.** The Excel should work standalone. Don't compute in Python and paste results — write Excel formulas that compute in the spreadsheet. Use named ranges where practical.
5. **Don't fabricate intermediate assumptions.** If the grounded data gives you a dollar amount ($8.4M/yr new ARR), use that directly. Don't convert it into a growth rate delta (e.g. +4ppt) unless the growth rate itself is the grounded input.
6. **Waterfall ≠ Model.** The Waterfall is a summary view for presentation. The Model is the calculation engine. They should not duplicate content — the Waterfall should reference Model totals.
7. **Write the script to a temp file** (`tmp_rovodev_build_model.py`) and delete it after running.
8. **Save output to** `projects/<relevant-folder>/` — never to the workspace root.
9. **Validate after saving** — reload with openpyxl and spot-check 3 key formula cells.
10. **Flag low-confidence numbers** in orange with an italic warning note in the cell below.
11. **Use `cat >> file << 'PYEOF'`** to build the script in chunks via bash — avoids JSON escaping issues with `create_file` for large scripts.

## Execution Pattern
```bash
# Write script in chunks
cat > tmp_rovodev_build_model.py << 'PYEOF'
# ... sheet 1 code ...
PYEOF

cat >> tmp_rovodev_build_model.py << 'PYEOF'
# ... sheet 2 code ...
PYEOF

cat >> tmp_rovodev_build_model.py << 'PYEOF'
# ... sheet 3 + save ...
PYEOF

# Run
python3 tmp_rovodev_build_model.py

# Validate
python3 -c "
import openpyxl
wb = openpyxl.load_workbook('projects/path/file.xlsx')
print('Sheets:', wb.sheetnames)
# spot check key cells
"

# Clean up
rm tmp_rovodev_build_model.py
```

## Reference Implementation
See: `projects/edition-strategy/edition-strategy-arr-model.xlsx` (Apr 2026)
- 3 sheets: Assumptions / Model / Waterfall Summary
- Three revenue levers: Mix Shift, Pricing, UBP
- All inputs sourced from Databricks + internal Confluence docs
