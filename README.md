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

---

## 💻 How to Run This Project Locally

Follow these steps to set up the project environment, ingest the data, and reproduce the analysis:

### Prerequisites

* **PostgreSQL Database:** A running PostgreSQL instance (specific version 18.1) is required.
* **Python:** Version **3.13** (or compatible version, specific python version used 3.13.5).
* **Kaggle Dataset:** Access to the "E-commerce events history in electronics store" dataset (You will need to download the CSV file).

---

### 1. Environment Setup

Create and activate a dedicated Python virtual environment to manage dependencies:

```bash
# Create the virtual environment (if you have multiple versions of python with py launcher)
py -3.13 -m venv venv_funnel

# Activate the environment (Linux/macOS)
source venv_funnel/bin/activate

# Activate the environment (Windows)
.\venv_funnel\Scripts\activate
```

### 2. Install Dependancies
Install all necessary libraries, including the database connector (`psycopg2`) and the data science tools:
```bash
pip install pandas==2.3.3 sqlalchemy==2.0.44 psycopg2-binary==7.9.11 matplotlib==3.10.7 seaborn==0.13.2 scipy==1.16.3
```

### 3. Database Configuration
Before running the analysis, you must configure your database connection:

- **Create Database:** Create an empty database in PostgreSQL named `Funnel Analysis` (or the name you used).

- **Update Notebook:** Open the Jupyter Notebook (Ecommerce_Funnel_Analysis.ipynb) and update the Database Connection Details cell with your correct credentials (`db_user`, `db_pass`, `db_host`, etc.).

### 4. Execute Analysis
Run the Jupyter Notebook sequentially from start to finish. The notebook performs the following key actions:

1. **Ingestion:** Connects to PostgreSQL and ingests the raw event data into the `raw_user_events` table.

2. **SQL Feature Engineering:** Runs the two primary SQL queries (`creating funnel_events` and `funnel_user_counts`).

3. **Deeper Dive SQL:** Runs the secondary CTE query to create the `brand_vc_performance` table.

4. **Visualization:** Generates all final charts and the project's actionable recommendations.

---
