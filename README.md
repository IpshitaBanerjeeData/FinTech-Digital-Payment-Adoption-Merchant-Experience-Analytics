# 🚀 End-to-End FinTech Payment Adoption & Merchant Experience Analytics

An end-to-end data analytics project evaluating **$23.56M in Total Payment Volume (TPV)**, checkout failure bottlenecks, and the unit economic impact of cashback incentives across **5,000 transactions** and **97 distinct merchant partners**[cite: 2, 3].

---

## 🛠️ Tech Stack & Architecture
* **Data Ingestion & Cleaning:** Python (Pandas, NumPy) via Google Colab.
* **Database & Query Validation:** MySQL Workbench (CTEs, aggregate metrics, and auditing).
* **Visualization & Executive Dashboard:** Power BI Desktop (DAX measures, custom conditional formatting, and dual-axis combo charts).

---

## 📊 Executive Dashboard Preview

### Page 1: Payment Adoption & Checkout Experience
* **Focus:** Diagnosing checkout friction, payment rail success rates, and hourly failure patterns.
* **Key Visuals:** KPI card banner, payment method success rate bar chart (highlighting underperforming rails below 95%), device-by-hour failure heatmap, and monthly TPV & success rate trend line.

### Page 2: Merchant Partner Health & Incentive ROI
* **Focus:** Identifying high-volume merchant risk and measuring the profitability of cashback vs. repeat adoption.
* **Key Visuals:** Merchant volume vs. success rate scatter plot (with 90% benchmark reference lines), product-category payment method breakdown, and incentive tier net revenue impact.

---

## 🔑 Key Findings & Business Insights

1. **Checkout Reliability ($1.23M at Risk):** 
   * Maintained an overall **95.10% Payment Success Rate** across $23.56M in TPV, but uncovered **$1.23M in failed volume at risk**[cite: 3].
   * Debit cards lead reliability at **96.67%**, whereas Credit Cards and Wallet Balances lag behind at **94.05%–94.06%**[cite: 3].
2. **Incentive Unit Economics ($121.53K Revenue Erosion):** 
   * Discovered that blanket high-cashback incentive tiers drove net revenue negative to **-$121.53K** due to cashback payouts exceeding fee revenue[cite: 2].
   * Yielded less than a 1 percentage point lift in repeat adoption (`~11.1%` vs `~11.8%`), proving the need for targeted, tiered cashback caps rather than universal subsidies.
3. **Merchant Concentration:** 
   * Isolated high-volume merchant partners in the bottom-right quadrant of the scatter matrix experiencing below-target success rates, enabling targeted gateway interventions.

---

## 📁 Repository Structure
```text
├── data/
│   └── cleaned_wallet_transactions.csv
├── notebooks/
│   └── fintech_data_cleaning.ipynb
├── sql/
│   └── payment_kpis_analysis.sql
├── dashboard/
│   ├── fintech_dashboard.pbix
│   ├── page1_checkout_experience.png
│   └── page2_merchant_incentive_roi.png
└── README.md
