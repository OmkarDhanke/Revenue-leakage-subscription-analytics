# Project Journal: CloudFlow Revenue Leakage Analysis

## Day 1: Business Thinking & Data Design
**Focus:** Defined the business context for "CloudFlow" (B2B SaaS) and mapped the revenue leakage scenarios.

* **Key Achievements:**
    * Mapped the "Order-to-Cash" operational workflow to identify failure points.
    * Defined 3 critical leakage scenarios:
        1.  **The Ghost Subscriber:** Active users with missing invoices.
        2.  **The Zombie Account:** Non-paying users who were not suspended.
        3.  **The Leaky Bucket:** Partial payments incorrectly marked as settled.
* **Scope Decision:** Confirmed focus is strictly on operational billing failures, not marketing churn.

👉 **[Read the Detailed Day 1 Report](Docs/01_business_logic.md)**

## Day 2: Data Architecture & Schema Design
**Focus:** Designed the Relational Database schema to support the leakage analysis.

* **Key Output:** Defined the 5-table schema:
    * **Reference:** `customers`, `plans`.
    * **Transactional:** `subscriptions`, `invoices`, `payments`.
* **Validation:** Conducted a "Mental Walkthrough" to ensure the schema supports SQL queries for Ghost, Zombie, and Leaky Bucket scenarios.
* **Design Choice:** Utilized `DECIMAL` data types for financial accuracy.

👉 **[Read the Detailed Data Design Doc](Docs/02_data_design.md)**

## Day 3: Simulation Strategy & Chaos Matrix
**Focus:** Designed the Python logic to generate synthetic data with "Intentional Flaws."

* **The "Chaos Matrix" (Defined Error Rates):**
    1.  **Ghost Subscribers:** 1.5% probability (Missing Invoices).
    2.  **Zombie Accounts:** 2.0% probability (Unpaid + Active). Added **Grace Period Logic** (Net-14 + 30 days) to distinguish zombies from late payers.
    3.  **Leaky Bucket:** 3.0% probability. Defined that settlement status will be **derived** via SQL, not hardcoded.
* **Realism Factor:** Included "Normal Noise" (8-10% churn, 10% late payments) to prevent false positives.
* **Constraint:** Set dataset scope to 1,000 customers over a 12-month period (2024).

👉 **[Read the Detailed Simulation Logic](Docs/03_simulation_logic.md)**

## Day 4: Python Data Simulation
**Focus:** Engineered the synthetic dataset using Python (Pandas) to mimic a "broken" billing engine.

* **Key Output:** Generated 5 CSV files containing ~11,000 billing records.
* **Chaos Implemented:**
    * Injected **1.5% Ghost Subscribers** (Active users missing invoices).
    * Injected **2.0% Zombie Accounts** (Active users who never paid).
    * Injected **3.0% Partial Payments** (Subtle revenue erosion).
* **Technical Check:** Enforced `np.random.seed(42)` to ensure the data is reproducible for anyone who clones the repo.

👉 **[Read the Detailed Python Logic](Docs/04_data_generation.md)**

## Day 5: Database Provisioning & Data Loading
**Focus:** Created the MySQL schema and imported the synthetic data to prepare for SQL analysis.

* **Key Actions:**
    * Executed DDL scripts to build the 5-table relational schema.
    * Imported CSVs following strict Parent-Child order (Customers -> Invoices -> Payments).
* **Validation:** Verified row counts confirmed the presence of the "Zombie" anomaly (Invoices > Payments).

👉 **[Read the Database Setup Log](Docs/05_database_setup.md)**

## Day 6: Data Quality Assurance
**Focus:** Validated database integrity and confirmed the presence of revenue anomalies.

* **Technical Checks:** Passed (0 duplicates, 0 orphans, 0 time-travel errors).
* **Sanity Check:** Confirmed `Total Invoiced > Total Collected`, validating that the dataset contains unpaid "Zombie" accounts.
* **Anomaly Confirmation:** Successfully detected specific counts of Partial Payments and Unpaid Invoices using SQL.

👉 **[Read the Data Quality Report](Docs/06_data_quality.md)**

## Day 7: Revenue Waterfall Analysis
**Focus:** Quantified the financial impact of the billing errors using SQL.

* **Key Findings:**
    * **Collection Gap:** Identified a consistent monthly variance (approx. 98% recovery rate), resulting in **$1,247.95** lost in September alone.
    * **Generation Gap:** The spot check showed a variance of -$80.00, indicating that while Ghost Subscribers exist, their financial impact was temporarily masked by new customer acquisition in September.

👉 **[Read the Preliminary Insights](insights/01_preliminary_findings.md)**

## Day 8: Identify & Classify Leakage
**Focus:** Identified the specific `invoice_ids` and `sub_ids` responsible for revenue loss.

* **Action:** Executed `05_forensic_classification.sql`.
* **Key Output:** Created the `leakage_report` table.
    * This "Hit List" consolidates Zombies, Ghosts, and Partial Payments into a single view.
    * Standardized the schema so all leakage types have a `leakage_amount` and `leakage_category`.

👉 **[Read the Forensic Analysis Doc](insights/02_root_cause_report.md)**

## Day 9: Trends & Aggregations (Business Intelligence)
**Focus:** Aggregated the granular forensic data into high-level business Insights using SQL.

* **Key Insights:**
    * **Highest Loss Month:** March 2024 ($2,424.20).
    * **Primary Driver:** "Unpaid Invoices" account for **90.31%** of all lost revenue ($16,570).
    * **High Risk Segment:** The **Enterprise Plan** is the biggest bleeder, losing $13k compared to 800 for Basic plans.

👉 **[Read the Executive Summary](insights/03_executive_summary.md)**

## Day 10: Final Dashboard & Visualization
**Focus:** Created "Boardroom-Ready" visualizations to communicate the findings effectively.

* **Action:**
    1.  Executed `sql/07_data_export.sql` to flatten the relational data into an analytical dataset.
    2.  Used Python (Pandas/Seaborn) in `notebooks/01_revenue_leakage_analysis.ipynb` to generate charts.
* **Deliverables:**
    * Generated 3 key charts: **Monthly Trend**, **Category Breakdown**, and **Risk by Plan**.
    * Stored visualizations in the `visualizations/` folder.
* **Project Status:** **COMPLETE**. The pipeline from Data Generation -> SQL Analysis -> Visualization is fully functional.

👉 **[View the Visual Gallery](Docs/07_visual_gallery.md)**

## Day 11: Statistical Forensics
**Focus:** Applied statistical analysis (Mean vs. Median, Pareto) to determine the "Risk Shape" of the data.

* **Action:** Used Python (Pandas) in `notebooks/02_statistical_forensics.ipynb` to analyze the `leakage_data_export.csv`.
* **Key Findings:**
    * **The Whale Effect:** Mean loss ($33) is 4x the Median ($9), proving the issue is driven by high-value outliers.
    * **Pareto Principle:** Confirmed that the **Enterprise Plan** accounts for **70.8%** of total leakage.
    * **Kill Zone:** Identified **North America / Enterprise** as the highest-risk segment.

👉 **[Read the Statistical Report](insights/04_statistical_findings.md)**

## Day 12: Excel Validation & Business Checks
**Focus:** Audited the final CSV dataset to ensure 100% accuracy before Dashboard ingestion.

* **Action:** Performed 3 critical checks on `dashboard_master.csv`:
    1.  **Revenue Sum:** Confirmed total leakage is **$18,348.15**, matching Day 9 SQL queries.
    2.  **Logic Check:** Verified zero negative values in the leakage column.
    3.  **Completeness:** Confirmed data spans the full 2024 fiscal year (Jan-Dec).
* **Outcome:** The dataset is certified "Clean" and ready for Power BI/Tableau.

👉 **[Read the Validation Report](Docs/08_excel_validation.md)**

## Day 13: Dashboard Design & Implementation
**Focus:** Transformed the validated CSV data into an interactive Executive Dashboard.

* **Status:** ✅ In Progress (Design Complete)
* **Action:**
    * Defined the "F-Pattern" layout in `Docs/09_dashboard_design.md`.
    * Imported `dashboard_master.csv` into Power BI.
    * Created 3 Key Measures: Total Leakage ($18k), Leakage Rate, and Zombie Count.
* **Key Visuals:**
    * **Trend Line:** Visualized the March anomaly.
    * **Risk Bar:** Highlighted Enterprise as the primary risk factor.
    * **Hit List:** Created a detailed table for the Collections team to download.

👉 **[View Design Doc](Docs/09_dashboard_design.md)**
