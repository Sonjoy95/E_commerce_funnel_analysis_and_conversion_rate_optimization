# 🚀 E-commerce Funnel Analysis & Conversion Rate Optimization (CRO)

A data science case study focused on diagnosing high user abandonment within an e-commerce sales funnel and providing targeted, data-driven recommendations to boost conversion efficiency.

---

## 🎯 Project Overview

### 📉 Project Problem

The e-commerce platform experienced an overall sales conversion rate significantly below industry benchmarks. This indicated a **critical user experience issue** causing high abandonment and resulting in **substantial missed revenue opportunities**. The exact point of failure within the multi-stage customer journey was initially unknown.

### ✨ Solution Goal

The primary goal was to **diagnose the specific bottleneck stage** in the customer journey and use a segmented analysis (by brand) to provide **actionable A/B test recommendations** that would measurably increase the conversion rate at the identified drop-off point.

---

## 🛠️ Technical Stack & Data

| Tool | Purpose |
| :--- | :--- |
| **PostgreSQL** | Used for efficient data ingestion and complex **feature engineering** (e.g., Sequential Event Tracking, Window Functions, and CTEs). |
| **Python** | Used for initial data cleaning, final rate calculation, advanced visualization (`seaborn`), and interpretation. |
| **Libraries** | `pandas`, `sqlalchemy`, `psycopg2-binary`, `matplotlib`, `seaborn`, `scipy` |
| **Dataset** | E-commerce Events History (Kaggle) |

---

## ❓ Key Questions Addressed

1.  What is the overall **stage-to-stage conversion rate** for each step in the sales funnel?
2.  Which specific stage represents the **single greatest source of user abandonment (the bottleneck)**?
3.  Is the conversion issue systemic, or is the poor performance **localized to specific brands**?
4.  What **actionable A/B test recommendations** can be made based on the top-performing segment data?

---

## ⚙️ Methodology & Analysis

The project followed a robust data pipeline:

### 1. Data Engineering (SQL)
* The raw event log was imported into PostgreSQL.
* **Window Functions (`ROW_NUMBER()`):** Used to establish the precise chronological sequence of user actions (`view`, `cart`, `purchase`) within each `user_session`.
* **Final Funnel Table:** Two tables were created: `funnel_events` (for sequenced actions) and `funnel_user_counts` (for aggregated user counts at each stage).

### 2. Initial Diagnosis (Python Visualization)
* The `funnel_user_counts` table was loaded into Python.
* The initial visualization calculated and plotted the conversion rate between stages: View $\rightarrow$ Cart $\rightarrow$ Purchase.

### 3. Deeper Analysis: Segmenting the Bottleneck (SQL & Python)
* **Hypothesis:** The bottleneck is localized by product line/brand.
* A second, complex SQL query using **Common Table Expressions (CTEs)** was run to calculate the **View $\rightarrow$ Cart Conversion Rate** for every brand that met a minimum view threshold.
* The results were visualized in a comparative plot, isolating the **Top 10** and **Bottom 10** performing brands against the overall site average.

---

## 📈 Key Findings & Actionable Recommendations

### 1. Critical Bottleneck Identified

The analysis revealed that the greatest point of user loss occurs between **View Product and Add to Cart (V $\rightarrow$ C)**, with an overall site conversion rate of **9.00%**.

### 2. Root Cause Localized

The comparative plot demonstrated that the low conversion is **not a systemic site error**, but a **localized content problem**. Conversion rates varied wildly, from an effective **29.54% (Brand: sapphire)** to a catastrophic **0.64% (Brand: hammer)**.

### 3. Final Recommendation (Specific and Data-Driven)

The project recommends halting generic optimization efforts and launching a targeted initiative focused on two key areas:

* **Blueprint Study:** Audit product pages for **Top Performers** (e.g., `sapphire`, `msi`) to extract successful design elements (e.g., media quality, review prominence).
* **A/B Test Focus:** Create a new page template based on the Blueprint Study and immediately deploy an **A/B Test** on the product pages of the **Bottom 10 Brands** (e.g., `hammer`, `lexmark`).

**Goal:** The A/B test aims to achieve a statistically significant increase in the V $\rightarrow$ C conversion rate for the bottom-performing segments, driving the site's overall conversion rate closer to industry benchmarks.
