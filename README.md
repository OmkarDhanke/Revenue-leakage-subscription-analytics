# 📉 Revenue Leakage & Subscription Integrity Analysis

![Status](https://img.shields.io/badge/Status-Day%2010%20of%2015%20(In%20Progress)-yellow) ![Tech](https://img.shields.io/badge/Stack-Python%20%7C%20SQL%20%7C%20PowerBI-blue) ![Domain](https://img.shields.io/badge/Domain-SaaS%20Billing-orange)

### 🚀 Project Overview
**"Money doesn't just disappear... or does it?"**
This project simulates a real-world SaaS billing engine ("CloudFlow Analytics") to identify, quantify, and resolve revenue leakage.

I engineered a **"Chaos Matrix"** using Python to inject realistic operational failures—**Ghost Subscribers** (missing invoices), **Zombie Accounts** (unpaid access), and **Leaky Buckets** (partial payments)—into a dataset of 11,000+ records. I am currently using SQL and Python to hunt down these errors and visualize the financial impact.

---

### 🗺️ Current Progress: Day 10 of 15
The project is divided into three 5-day sprints. I have completed the **Engineering** and **Analysis** phases and am moving into **Dashboarding & Final Presentation**.

#### 🟢 Phase 1: Engineering & Design (Complete)
* **Day 1:** Business Logic & Leakage Scenarios (Ghosts, Zombies).
* **Day 2:** Relational Database Schema Design (5 Tables).
* **Day 3:** Data Simulation Logic ("Chaos Matrix" Design).
* **Day 4:** Python Data Generation (11,000+ Records).
* **Day 5:** Database Provisioning & ETL (MySQL).

#### 🟢 Phase 2: Forensic Analysis (Complete)
* **Day 6:** Data Quality Assurance & Validation.
* **Day 7:** Revenue Waterfall Analysis (Proved $1,200+ leakage/month).
* **Day 8:** Root Cause Identification (Created "Hit List" of leaking IDs).
* **Day 9:** Executive Reporting (Trend & Segmentation Analysis).
* **Day 10:** Exploratory Visualization (Python/Seaborn Charts).

---

### 📊 Key Business Findings (So Far)
The SQL forensic analysis (Day 9) revealed:

* **Primary Driver:** **90.31%** of leakage comes from **"Zombie Accounts"** (Invoices generated but strictly unpaid).
* **High-Risk Segment:** The **Enterprise Plan** accounts for **~$13,000** in lost revenue (vs only ~$800 for Basic plans).
* **Volatility:** Leakage spiked drastically in March 2024, suggesting a specific batch-processing failure.

---

### 📂 Repository Structure

| Folder | Contents |
| :--- | :--- |
| **`python/`** | 🐍 Data generation scripts & Jupyter Notebooks. |
| **`sql/`** | 🔍 Numbered SQL scripts (01-07) representing the analysis workflow. |
| **`data/`** | 💾 `raw/` source files and `derived/` exports for dashboarding. |
| **`docs/`** | 📄 Daily logs, Business Logic, and the Visual Gallery. |
| **`visualizations/`** | 📈 Static charts exported from Python (Phase 2 output). |
| **`dashboard/`** | 📊 *(Coming Soon)* Power BI `.pbix` files (Phase 3 output). |

---
