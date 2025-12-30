# 📉 Revenue Leakage & Subscription Integrity Analysis (WIP)

**Current Status:** 🚧 Active Development (Currently at Day 12 of 15)

This repository documents a 15-day project to build, break, and analyze a subscription billing system. If you are looking through this project, follow the path below to understand the logic in the correct order.

---

### 🗺️ How to Navigate This Project

This project is structured chronologically. To follow the "story," go through the files in this order:

#### Phase 1: The Plan & Design (Completed)
Before looking at code, read the documentation to understand *what* we are building and *why*.
1.  **Start with the Business Logic:**
    * 📄 Read `docs/day_01_business_logic.md` to see the leakage scenarios (Ghosts, Zombies, Leaky Buckets).
2.  **See the Blueprint:**
    * 📄 Read `docs/day_02_data_design.md` to see the 5-table schema and ER Diagram.
    

[Image of Entity Relationship Diagram for subscription billing system]

3.  **Understand the "Chaos":**
    * 📄 Read `docs/day_03_data_simulation_logic.md` to see how we planned to break the data intentionally.

#### Phase 2: The Build & Forensics (Completed)
Once you know the plan, look at how we created the synthetic data and hunted down errors.
4.  **The Engine:**
    * 🐍 Check `python/data_generator.py`. This is the Python script that created the data.
5.  **The Investigation (SQL):**
    * 🔍 Run `sql/05_forensic_leakage_identification.sql`. This is the core analysis that identified specific "Zombie" and "Ghost" users.
    * 📄 Read `docs/day_09_executive_summary.md` to see the final financial impact report ($18k+ lost).

#### Phase 3: Dashboarding & Visualization (Active Phase)
Now, we are translating raw data into visual insights.
6.  **The Statistical Deep Dive:**
    * 📊 Check `docs/day_10_visual_gallery.md` to see the Python charts proving the "Enterprise Plan" is the biggest risk.
7.  **The "Handshake" Audit (Day 12):**
    * 📄 **Read `docs/day_12_validation_log.md`.** (Start Here for today's update).
    * This document proves that our SQL data matches our Excel export perfectly ($18,348.15), certifying it for dashboarding.

---

### 📂 Quick Folder Reference

| Folder | What's Inside? |
| :--- | :--- |
| **`sql/`** | Numbered SQL scripts (01-08) to run in MySQL Workbench. |
| **`python/`** | Data generation scripts & Jupyter Notebooks. |
| **`data/`** | `raw/` source files and `derived/` exports for dashboarding. |
| **`docs/`** | The daily logs and explanations. This is the "Journal" of the project. |
| **`visualizations/`** | Static charts exported from Python. |

---

### 📝 Project Timeline & Progress
* **✅ Day 1-5:** Planning, Data Generation, DB Setup.
* **✅ Day 6-9:** Forensic Analysis (Proved $18k leakage).
* **✅ Day 10-11:** Python Visualization & Risk Analysis.
* **✅ Day 12:** Excel Validation & Data Certification.
* **🔜 Day 13-15:** Interactive Dashboarding (Power BI) & Final Presentation.