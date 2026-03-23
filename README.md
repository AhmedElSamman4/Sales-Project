# 📊 Sales Analysis & RFM Segmentation Project

## 🔹 Overview

This project analyzes annual sales data using a modern data stack, including Google BigQuery for data warehousing and Power BI for data visualization.

The main objective is to transform raw transactional data into actionable insights and perform customer segmentation using the RFM (Recency, Frequency, Monetary) model.

---

## 🔹 Data Source

* 12 monthly sales datasets (2025)
* Data was stored and processed in Google BigQuery
* All monthly tables were combined into a single unified table

---

## 🔹 Data Engineering Process

1. Data ingestion of 12 monthly tables into BigQuery
2. Data consolidation using `UNION ALL`
3. Data cleaning and transformation using SQL
4. Creation of analytical views for reporting

---

## 🔹 RFM Analysis

RFM = (R, F, M)

* **Recency (R):** Number of days since last purchase
* **Frequency (F):** Number of transactions per customer
* **Monetary (M):** Total amount spent

Customers were scored using SQL window functions (`NTILE`) and segmented into meaningful business groups.

---

## 🔹 Customer Segments

* Champions
* Loyal Customers
* Potential Loyalists
* Promising
* Needs Attention
* At Risk
* Lost Customers

---

## 🔹 Dashboard

![Dashboard](images/dashboard.png)

The Power BI dashboard provides:

* Sales trends over time
* Customer segmentation insights
* Top customers and revenue analysis

---

## 🔹 Technologies Used

* Google BigQuery
* SQL
* Power BI
* Data Modeling

---

## 🔹 Project Structure

```
sales-analysis-project/
│
├── sql/
├── dashboard/
├── data_sample/
├── images/
└── README.md
```

---

## 🔹 Business Value

This project helps businesses:

* Identify high-value customers
* Improve customer retention
* Detect churn risks
* Make data-driven decisions

---

## 🔹 Notes

Due to data size limitations, the full dataset is not included. A sample dataset is provided for demonstration.
