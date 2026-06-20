## 👤🕐 Time and Attendance Management Project
This project aims at creating a basic SQL Database for Time and Attendance Management (TAM) in a Holding Company

### 📋 Data Sources & Disclosures

The sample data used to populate the **Employees** Master Data table is sourced from the publicly available dataset:

> **Employee Data** by Kaggle
> [https://www.kaggle.com/datasets/zahidmughal2343/employee-data](https://www.kaggle.com/datasets/zahidmughal2343/employee-data)

Additional attributes are assigned randomly.<br> 
This data is used **solely for demonstration and testing purposes**.<br> 
All credits for the sample dataset go to the original author on Kaggle.



.
├── SUPPORT FILES/
│   ├── AI_Prompt.docx                          # Prompt used to generate sample badge swipe data
│   ├── BadgeSwipes_SampleData_GitHub.xlsx      # AI-generated sample badge swipe data
│   ├── Attendances_SampleData_GitHub.xlsx      # Sample attendance records (other causali + durations, derived from ordinary work hours)
│   └── MasterData_GitHub.xlsx                  # Reference master data (companies, departments, causali, users)
│
└── DATABASE SQL SCRIPT/
    ├── TAM_Database_Creation.sql               # DDL: creates tables, keys, and constraints
    ├── TAM_Database_INSERT_MasterData.sql      # Populates master data tables
    └── TAM_Database_INSERT_TransactionaData.sql # Populates transactional tables with sample attendance data
