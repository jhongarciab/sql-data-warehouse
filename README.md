# Data Warehouse and Analytics Project

## 📊 Project Overview

This project implements an end-to-end **Data Warehouse and Analytics solution** using PostgreSQL.
The goal is to integrate raw ERP and CRM data into a structured analytical environment following a **medallion architecture: Bronze → Silver → Gold** architecture.

The project focuses on:
- Data ingestion from multiple sources
- Data cleansing and standardization
- Business-ready analytical models
- SQL-based ETL orchestration using stored procedures

## 📂 Repository Structure
```
data-warehouse-project/
│
├── datasets/                           # Raw datasets used for the project (ERP and CRM data)
│
├── docs/                               # Project documentation and architecture details
│   ├── data_integration.png.           # File shows the project's architecture
│   ├── data_catalog.md                 # Catalog of datasets, including field descriptions and metadata
│   ├── data_flow.png                   # File for the data flow diagram
│   ├── data_model.png                  # File for data models (star schema)
│   ├── naming-conventions.md           # Consistent naming guidelines for tables, columns, and files
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│
├── tests/                              # Test scripts and quality files
│
├── README.md                           # Project overview and instructions
├── LICENSE                             # License information for the repository
├── .gitignore                          # Files and directories to be ignored by Git
```
---