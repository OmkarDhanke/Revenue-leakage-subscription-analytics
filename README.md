# 📉 CloudFlow  
## Revenue Leakage Detection in a Simulated SaaS Billing System

![Status](https://img.shields.io/badge/Status-Completed-success) ![Tools](https://img.shields.io/badge/Tools-SQL%20%7C%20Python%20%7C%20PowerBI-blue) ![Domain](https://img.shields.io/badge/Domain-SaaS%20Billing%20%7C%20FinOps-orange)

**An end-to-end analytical audit simulation that models a SaaS billing environment to detect, classify, and monitor revenue leakage exposure using SQL, Python, and Power BI.**

> ⚠️ **Important Note**  
> All data used in this project is **synthetically generated** to simulate realistic SaaS billing failure scenarios.  
> Financial figures represent **simulated revenue leakage exposure**, not real monetary recovery.

---

## 📖 Executive Summary

**The Context** Subscription-based SaaS businesses frequently experience revenue leakage due to mismatches between subscriptions, invoices, and payments. While these issues are common, they are often difficult to detect without structured reconciliation logic and clear monitoring visibility.

**The Objective** The goal of this project was to design and validate analytical controls capable of identifying *where* and *why* revenue leakage occurs within a billing system — not to recover real revenue, but to **test detection logic against known failure patterns**.

**The Outcome** The analysis surfaced **$18,348.15 in simulated revenue leakage exposure** for Fiscal Year 2024 and identified the dominant operational and system-level drivers of leakage. The project concludes with an executive-level monitoring dashboard designed to support prioritization and operational follow-up.

---

## 💰 Revenue Leakage Classification

Revenue leakage was classified into three deterministic categories based on reconciliation gaps between billing system components.

| Leakage Category | Count | Simulated Exposure ($) | % of Total | Definition |
|------------------|-------|------------------------|------------|------------|
| **Zombie Accounts** | 209 | 16,570.00 | 90.31% | Invoice exists → Payment missing → Service active |
| **Partial Payments** | 327 | 1,368.15 | 7.46% | Invoice amount ≠ Payment amount |
| **Ghost Subscribers** | 13 | 410.00 | 2.23% | Subscription active → Invoice missing |

**Key Insight** While system errors ("Ghost Subscribers") were present, the analysis shows that **operational non-collection from known customers** was the primary driver of revenue leakage exposure.

---

## 📊 Revenue Integrity Dashboard

An executive-level monitoring dashboard was designed to provide clear visibility into billing health and leakage risk.

![Dashboard Demo](visualizations/dashboard_demo.gif)

**Dashboard Capabilities**
- Total leakage exposure over time  
- Leakage composition by category  
- High-risk plans and regions  
- Monthly volatility trends  

Filtering by **Plan Type** and **Region** enables targeted investigation and prioritization.

> **Example Insight:** A volatility spike in March 2024 aligns with a simulated batch update, suggesting regression risk during system changes.

---

## 🛠 Methodology & Technical Design

The project was structured as a **three-layer analytical pipeline**, emphasizing traceability, interpretability, and business relevance.

### 1️⃣ SQL Reconciliation Layer (Detection Logic)

SQL was used to reconcile invoices, subscriptions, and payments and isolate billing inconsistencies.

**Techniques Used**
- `LEFT JOIN` exclusion logic to identify missing relationships  
- `UNION ALL` to consolidate leakage types into a single reporting table  
- Invoice aging logic to distinguish delayed payments from true non-payment  

```sql
-- Example: Identifying unpaid active invoices
SELECT 
    i.invoice_id,
    i.customer_id,
    i.invoice_amount,
    i.invoice_date
FROM invoices i
LEFT JOIN payments p 
    ON i.invoice_id = p.invoice_id
WHERE p.payment_id IS NULL
  AND i.invoice_status = 'Open';
```
In a real production system, this logic would be combined with invoice aging thresholds and retry logic to reduce false positives.

### 2️⃣ Python Analytics Layer (Risk Profiling)
Python (Pandas, NumPy) was used to analyze the distribution and concentration of leakage exposure.

**Analyses Performed**
- **Skew Analysis:** Mean vs. median comparison revealed a 4× skew, indicating that high-value accounts (“whales”) drove most of the risk.
- **Segment Risk Mapping:** Region × Plan heatmaps identified North America (East) Enterprise accounts as the highest exposure segment.

### 3️⃣ Visualization Layer (Power BI)
Power BI was used to translate forensic findings into actionable monitoring views.

**Key Features**
- KPIs for total exposure and detection coverage
- Trend analysis for leakage volatility
- Drill-down filtering by Region and Plan
- Export-ready views to support operational follow-up

*Note: Metrics focus on visibility and detection, not confirmed revenue recovery.*

---

## 🔍 Deep Dive Insights

### 1️⃣ Enterprise Plan Vulnerability (Pareto Analysis)
The Enterprise plan represents a minority of users but a majority of the financial risk.

- **Enterprise Exposure:** $12,994 (70.8%)
- **Basic Exposure:** $838 (<5%)

**Root Cause:** The disproportionate risk suggests that **custom billing logic** for Enterprise accounts—specifically regarding **multi-seat calculations**—is a primary failure point compared to the standard logic used for Basic plans.

### 2️⃣ March 2024 Volatility & Regression Risk
Trend analysis revealed a leakage spike in **March 2024 ($2,424 exposure)**, which was approximately **double the average** of surrounding months.

**Interpretation:** This spike correlates with a simulated Q1 Batch Update. This pattern suggests a **regression bug** was introduced during the update and likely only partially patched, leading to continued but lower leakage in subsequent months.

### 3️⃣ Operational Process Gap (The "Auto-Suspend" Failure)
Since **90.31%** of leakage is driven by "Zombie Accounts" (Invoices generated but unpaid), the issue is primarily **process-driven**, not a code error.

- **Control Gap:** The system currently lacks an **Auto-Suspend feature** for invoices aged > 45 days.
- **Recommendation:** Implementing automated service suspension for aging invoices would immediately mitigate 90% of the forward-looking risk.

---
* **Author:** **Omkar Dhanke**    
* **Connect with me:** [![LinkedIn](https://img.shields.io/badge/LinkedIn-%230077B5.svg?logo=linkedin&logoColor=white)](https://www.linkedin.com/in/omkar-dhanke)
