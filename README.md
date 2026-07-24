# 🚀 SQL Server Data Warehouse Project

Welcome to the **SQL Server Data Warehouse Project** repository!

This project demonstrates the design and implementation of a modern data warehouse using **SQL Server** and the **Medallion Architecture (Bronze, Silver, Gold)**. It showcases an end-to-end data engineering workflow, including data ingestion, ETL processes, data quality improvements, dimensional data modeling, and analytics-ready datasets.

The project is designed as a portfolio piece to demonstrate practical data engineering skills and industry-standard data warehousing practices.

---

# 📌 Project Overview

The objective of this project is to build a scalable and organized data warehouse that integrates data from multiple business systems into a single source of truth for reporting and analytics.

The solution follows the Medallion Architecture:

- 🥉 **Bronze Layer** – Raw data ingestion from source systems
- 🥈 **Silver Layer** – Data cleansing, standardization, and transformation
- 🥇 **Gold Layer** – Business-ready dimensional model for analytics

---

# 🎯 Project Objectives

- Build a modern data warehouse using SQL Server.
- Design an end-to-end ETL pipeline.
- Implement the Medallion Architecture.
- Improve data quality through cleansing and validation.
- Integrate ERP and CRM data into a unified analytical model.
- Create optimized fact and dimension tables.
- Produce analytics-ready datasets for reporting and business intelligence.

---

# 📂 Data Sources

This project uses data from two business systems:

- **ERP System**
- **CRM System**

Both datasets are provided as CSV files and imported into SQL Server.

---

# 🏗️ Data Warehouse Architecture

```text
ERP CSV          CRM CSV
     │              │
     └──────┬───────┘
            │
       Bronze Layer
      (Raw Data Load)
            │
            ▼
       Silver Layer
(Data Cleaning & Transformation)
            │
            ▼
        Gold Layer
 (Dimensional Data Model)
            │
            ▼
      Analytics & Reporting
```

---

# ⚙️ ETL Process

The ETL pipeline includes:

- Importing raw CSV files
- Data validation
- Removing duplicates
- Handling missing values
- Standardizing formats
- Data transformation
- Business rule implementation
- Loading analytical tables

---

# 📊 Data Model

The Gold layer follows a dimensional modeling approach consisting of:

### Dimension Tables

- DimCustomer
- DimProduct
- DimDate
- DimLocation

### Fact Tables

- FactSales

This structure enables efficient reporting and analytical queries.

---

# 📈 Analytics

The final warehouse supports business analysis such as:

- Sales Performance
- Customer Insights
- Product Performance
- Revenue Analysis
- Monthly Sales Trends
- Regional Sales Analysis
- KPI Reporting

---

# 🛠️ Technologies Used

- SQL Server
- T-SQL
- Medallion Architecture
- ETL
- Dimensional Data Modeling
- Git
- GitHub

---

# 📁 Repository Structure

```
sql-data-warehouse-project
│
├── datasets/
├── docs/
├── scripts/
│   ├── bronze/
│   ├── silver/
│   └── gold/
├── diagrams/
├── images/
├── LICENSE
└── README.md
```

---

# 🎓 Skills Demonstrated

- Data Warehousing
- Data Engineering
- ETL Development
- SQL Programming
- Data Cleansing
- Data Transformation
- Data Modeling
- Analytical Query Development
- Git Version Control

---

# 🚀 Future Improvements

- Automate ETL pipelines
- Add incremental data loading
- Implement data quality monitoring
- Integrate Power BI dashboards
- Deploy to Azure SQL Database

---

# 📜 License

This project is licensed under the MIT License.

---

# 👨‍💻 About Me

Hi, I'm **Sanjai S**, an aspiring **Data Engineer** passionate about building scalable data solutions and transforming raw data into meaningful insights.

I'm continuously improving my skills in:

- SQL
- Data Engineering
- Data Warehousing
- Python
- Power BI
- Cloud Technologies

Feel free to explore the project, provide feedback, or connect with me!
