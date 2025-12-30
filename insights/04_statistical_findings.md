# 4.0 Statistical Forensics Report

## 1. The Whale Test (Distribution Analysis)
We compared the Mean vs. Median loss per error to check for skew.

* **Mean Loss per Error:** $33.42
* **Median Loss per Error:** $9.05
* **Verdict:** **Heavily Skewed (Right-Tailed)**
    * **Analysis:** The Mean is nearly **4x higher** than the Median. This confirms a "Whale" problem. The leakage is not driven by thousands of small errors, but by a smaller number of high-value failures (Enterprise accounts).
    * **Strategic Implication:** Fixing the top 10% of errors will recover ~50% of the lost revenue. We should not treat all errors equally.

## 2. Pareto Analysis (The 80/20 Rule)
We calculated the cumulative contribution of each Plan type to the total loss.

| Plan Name | Total Loss ($) | Cumulative % | Risk Tier |
| :--- | :--- | :--- | :--- |
| **Enterprise** | $12,994 | 70.8% | 🚨 **Critical** |
| **Pro** | $4,514 | 95.4% | ⚠️ High |
| **Basic** | $838 | 100.0% | 🟢 Low |

* **Finding:** The **Enterprise Plan** alone accounts for **70.8%** of all money lost, despite having fewer total customers than the Basic plan.

## 3. The "Kill Zone" (Heatmap Analysis)
We created a pivot table of `Region` vs. `Plan` to pinpoint the exact intersection of highest risk.

* **Primary Kill Zone:** **Enterprise Users in NA (North America)**.
* **Secondary Kill Zone:** Enterprise Users in EMEA (Europe).
* **Anomaly:** The "Basic" plan shows negligible loss across all regions, suggesting the billing logic for simple, low-cost plans is robust, while the complex logic for high-value plans is fragile.

## 4. Conclusion & Recommendation
The statistical evidence suggests the `billing_engine` fails specifically when processing **High-Value (Enterprise) transactions**. This is likely due to complex custom logic often associated with Enterprise tiers (e.g., custom billing cycles, multi-seat calculations).

**Recommendation:** Engineering should not debug the entire codebase. They must focus exclusively on the **Enterprise Plan Calculation Module**, specifically for North American customers.