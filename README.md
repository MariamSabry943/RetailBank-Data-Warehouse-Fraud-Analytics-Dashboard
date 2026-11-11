# RetailBank DWH & Fraud Analytics Portfolio Project

An end-to-end data engineering and business intelligence project built on a **Medallion Architecture (Bronze → Silver → Gold)**, integrated with an executive-level **Power BI** reporting suite to monitor banking transactions, customer behaviors, merchant risks, and fraudulent activities.

---
## 🎨 Dashboard Preview

<p align="center">
  <img src="Screenshots/overview.png" alt="RetailBank Dashboard Preview" width="100%">
</p>

---

## 🏗️ Project Architecture & Workflow

The project follows a rigorous engineering pipeline from raw flat files to a polished analytics interface:

1. **Bronze Layer (Raw Ingestion):**
   * Imported raw CSV files (`Customers`, `Merchants`, `Transactions`) into SQL Server using SSMS Import/Export Wizard.
   * Maintained raw, untyped tables to preserve full source data fidelity.

2. **Silver Layer (Data Quality & Cleansing):**
   * Handled data quality checks for null values, whitespace, and invalid type casts using `TRY_CAST`, `LTRIM/RTRIM`, and `ISNULL`.
   * Identified and resolved duplicate primary keys (`customer_id`, `merchant_id`, `transaction_id`) and orphan records.

3. **Gold Layer (Star Schema Modeling):**
   * Designed conformed dimension tables: `DimCustomer`, `DimMerchant`, and `DimDate`.
   * Built the central fact table: `FactTransactions` with enforced foreign keys, indexes, and referential integrity.

4. **Power BI Reporting Layer:**
   * Developed a 5-page executive dashboard with a sleek corporate theme, top horizontal navigation, left-aligned KPI cards, and a grid-based visualization layout.

---

## 📊 Dashboard Pages & Scope

- **Home (`Home`):** Executive landing hub providing core financial metrics and seamless navigation.
![Home Page](Screenshots/home.png)
  
- **Overview (`Overview`):** High-level summary of total revenue, customer growth, and overall risk exposure.
  ![Overview Page](Screenshots/overview.png)

- **Customers (`Customers`):** Demographic segmentation, loyalty tiers, job distribution, and behavioral patterns.
  ![Customers Page](Screenshots/customers.png)

- **Merchants (`Merchants`):** Merchant risk scoring, spending categories, and top fraud-prone entities.
  ![Merchants Page](Screenshots/merchants.png)

- **Transactions & Fraud (`Transactions`):** Real-time monitoring of payment channels, entry modes, and transaction status breakdown.
  ![Transactions Page](Screenshots/transactions.png)
---

## 🛠️ Tech Stack & Tools

* **Data Engineering & ETL:** SQL Server
* **Data Modeling:** Star Schema, Fact & Dimension Modeling
* **Business Intelligence:** Power BI Desktop, DAX, Power Query
* **UI/UX Design:** Figma & Custom Executive Layout Standards

---

