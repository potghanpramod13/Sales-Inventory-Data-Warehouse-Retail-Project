# Sales-Inventory-Data-Warehouse-Retail-Project

# Sales & Inventory Data Warehouse Retail Project

## Purpose

This project builds a **Sales & Inventory Data Warehouse** on **Azure Cloud**, integrating data from diverse sources such as flat files and databases into a centralized system. The data warehouse aims to improve decision-making by providing historical data, consolidated reporting, and enhanced analytics for sales, inventory, and returns.

### Objectives:
- Streamline sales and inventory data pipelines.
- Enable near real-time reporting with **Azure Synapse Analytics**.
- Apply business rules to ensure data quality and consistency.
- Support Business Intelligence (BI) via **Power BI** for data visualization.

---

## Scope

This project includes:

1. **Data Extraction**:
   - Sources: Flat files (e.g., `.csv`, `.txt`) and databases like SQL Server.
   - Target: Azure Data Lake Storage (ADLS).

2. **Data Transformation & Validation**:
   - Tools: **Azure Databricks** and **PySpark notebooks**.
   - Purpose: Ensure quality, enforce business rules, and prepare data.

3. **Data Loading**:
   - Layer: **SalesEDW** hosted on Azure SQL DB.
   - Process: Use **Slowly Changing Dimensions (SCD Type 2)** for historical tracking.

4. **Schema Development**:
   - Creation of **dimension** and **fact tables** for analysis and reporting.

---

## Assumptions & Constraints

### Assumptions:
- **Pre-existing Azure Services**: Includes ADF, ADLS Gen2, Databricks, Synapse, and Azure SQL DB.
- **Incremental Data Processing**: Applied to SQL Server tables based on watermarking.
- **Data Quality**: Minimal errors in source data.
- **Access Control**: Secure access via **Azure AD**.
- **Stakeholder Availability**: Timely inputs for business rule definition.

### Constraints:
1. **Data Volume**: High data volume may strain Azure resources.
2. **Real-time Reporting**: Limited to near real-time due to processing delays.
3. **Service Limits**: Constrained by Azure service quotas and performance.
4. **Data Source Dependency**: Timely availability of source data.

---

## Architecture

![Retail Architecture Diagram](https://github.com/potghanpramod13/Sales-Inventory-Data-Warehouse-Retail-Project/blob/31d32fe0c7a3d1a8d2c567309554df8d34122a5e/Retail%20Architecture%20Diagram.png)

### Components & Functions:
| **Technology**          | **Functionality**                                  |
|--------------------------|---------------------------------------------------|
| **Azure Data Factory**   | Orchestration of ETL pipelines.                   |
| **Azure Data Lake**      | Raw and processed data storage.                   |
| **Databricks**           | Data transformation and validation.               |
| **Azure SQL DB**         | Gold-tier enterprise data storage.                |
| **Azure Key Vault**      | Credential management and security.               |
| **Azure Active Directory** | Access and identity management.                 |

---

## Data Sources

1. **Flat Files**: `.csv`, `.txt` files uploaded to Azure Blob Storage.
2. **SQL Server Database**: Sales and inventory data dumps.

---

## Environment Setup

### Resource Groups:
1. `<ProjectName_DEV>`: Development environment.
2. `<ProjectName_QA>`: Quality assurance.
3. `<ProjectName_PROD>`: Production.

### Services to Create:
- **Azure Data Factory**: Orchestration of pipelines.
- **Databricks**: Data transformation.
- **Key Vault**: Secure secrets.
- **ADLS Gen2**: Raw and processed data storage.
- **Synapse Analytics**: Data integration and analytics.
- **Azure SQL DB**: Gold-tier data storage.

![Dev Environment](https://github.com/user-attachments/assets/aa004a59-5ec9-4738-9a7e-c5a69f23e1db)

---

## Data Pipeline Details

### 1. ADLS Raw Layer:
- File Naming Convention: `TableName_<timestamp>.csv`.
- Folder Structure:
  - **RAW**: Stores original files.
  - **Archive**: Moves successfully loaded files.
  - **Rejects**: Stores validation-failed records.

### 2. Ingestion & Integration Layers:
- **Ingestion**: Raw data is cleansed and loaded.
- **Integration**: Business rules applied for analytics readiness.
- Implement **SCD Type 2** for dimension tables.

### 3. Fact Tables:
- **Transactional Fact Tables**:
  - `TBL_FACT_SALES`
  - `TBL_FACT_INVENTORY`
- Load data by joining with dimension tables.

---

## Key Features

### Slowly Changing Dimensions (SCD Type 2):
- Tracks historical changes with:
  - `BEGIN_EFFECTIVE_DATE`
  - `END_EFFECTIVE_DATE`
  - `VERSION_NUM`

### Watermark Table:
- Maintains last fetched timestamp for incremental data loads.
- Ensures accurate data extraction in subsequent runs.

### Audit Logs:
- Tracks ETL pipeline performance and errors.

---

## Compliance & Security

1. **Data Masking**: Applied to sensitive fields (e.g., cost, price).
2. **Row-Level Security**: Ensures branch-level access restrictions.
3. **Monitoring & Alerts**: Automated alerts for failures or delays.

---

## Execution & Scheduling

- **SQL Source Pipelines**:
  - Full and incremental loads.
  - Master pipeline scheduled daily (9 AM IST).
- **Flat File Pipelines**:
  - Triggered on file arrival or on-demand.

---

## LLD Documents details

1. **Source to ADLS Raw LLD**: Detailed data mappings.
2. **ADLS to Integration Layer**: Transformation rules.
3. **Fact & Dimension Models**: Data model layouts.
4. **Audit Logging Use Case**: Error handling and logging processes.

---
