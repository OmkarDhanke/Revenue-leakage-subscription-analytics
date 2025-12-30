# 9: Dashboard Design & Layout Strategy

## 1. Executive Summary (The "Top Row")
*Goal: Instant status check. These are single-number cards.*

* **KPI 1: Total Revenue at Risk**
    * **Value:** $18,348
    * **Color:** Red (Alert)
* **KPI 2: Leakage Rate (%)**
    * **Calculation:** `SUM(Leakage) / SUM(Invoiced Amount)`
    * **Target:** < 1.0% (We are currently failing this).
* **KPI 3: Zombie Account Count**
    * **Value:** 209
    * **Context:** "Accounts active but unpaid."

## 2. The Narrative (The "Middle Layer")
*Goal: Explain the "Why" and "Where".*

* **Chart A: Monthly Leakage Trend (Line Chart)**
    * **X-Axis:** `month_year`
    * **Y-Axis:** `leakage_amount`
    * **Insight:** Highlight the March 2024 spike.
* **Chart B: Risk by Plan (Bar Chart)**
    * **X-Axis:** `plan_name`
    * **Y-Axis:** `leakage_amount`
    * **Insight:** Show Enterprise vs. Basic risk comparison.
* **Chart C: Root Cause Breakdown (Donut Chart)**
    * **Legend:** `status_label` (Zombie vs Partial vs Ghost)
    * **Values:** `leakage_amount`
    * **Insight:** Visually prove "Zombie" dominance.

## 3. The Action List (The "Bottom Layer")
*Goal: Give the user something to do.*

* **Table: The "Hit List"**
    * **Columns:** `customer_id`, `region`, `plan_name`, `leakage_amount`, `status_label`.
    * **Sort:** Descending by `leakage_amount`.
    * **Interaction:** Clicking a slice in the Donut Chart filters this list.

## 4. Visual Style Guide
* **Theme:** "Financial Alert"
* **Background:** Light Gray / White
* **Primary Color:** Navy Blue (Safe/Normal)
* **Alert Color:** Burnt Orange / Red (Leakage)