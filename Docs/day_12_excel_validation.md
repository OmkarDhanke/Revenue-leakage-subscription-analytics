# 12.0 Excel Validation & Business Logic Check

## 1. Executive Summary
Before importing data into Power BI, we performed a "Sanity Check" to ensure no data was lost during the export process. We compared the CSV totals against our previous SQL findings.

**Verdict:** The data is 100% accurate. The total revenue leakage matches our Day 9 SQL report exactly.

## 2. Validation Checks

### Check 1: Total Revenue Verification
* **Objective:** Ensure the sum of leakage in the CSV matches the SQL aggregate.
* **SQL Finding (Day 9):** ~$18,348
* **CSV Calculation:**
    * Sum of `leakage_amount`: **$18,348.15**
* **Result:** ✅ **MATCH**

### Check 2: The "Negative Value" Audit
* **Objective:** Ensure no "Leakage Amount" is negative (which would imply we owe the fraudster money).
* **Logic:** `COUNTIF(leakage_amount < 0)`
* **Result:** **0** rows found. (✅ PASSED)

### Check 3: Time Horizon Consistency
* **Objective:** Ensure the dataset covers the full expected fiscal period.
* **Expected Range:** Jan 2024 – Dec 2024.
* **Actual Range:**
    * Min Date: **2024-01-01**
    * Max Date: **2024-12-01**
* **Result:** ✅ **PASSED** (Full 12-month coverage confirmed).

## 3. Data Profile (The "Shape" of the Data)
We verified the row count to ensure we are visualizing the correct volume of transactions.

* **Total Rows:** 11,251
* **Columns Verified:**
    * `record_date` (Date)
    * `region` (String)
    * `plan_name` (String)
    * `leakage_amount` (Float)
    * `status_label` (String - "Clean" vs "Partial" vs "Zombie")
