## 👤🕐 Time and Attendance Management Project
A SQL Server relational database for managing **Time and Attendance (T&A)** data across a **multi-company Holding structure**. The project models badge swipe events, attendance causes, organizational departments, and consolidates them into a clean, queryable schema designed for reporting and payroll integration.

## Project structure

```
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
```



### 📋 Data Sources & Disclosures

The sample data used to populate the **Employees** Master Data table is sourced from the publicly available dataset:

> **Employee Data** by Kaggle
> [https://www.kaggle.com/datasets/zahidmughal2343/employee-data](https://www.kaggle.com/datasets/zahidmughal2343/employee-data)

Additional attributes are assigned randomly.<br> 
This data is used **solely for demonstration and testing purposes**.<br> 
All credits for the sample dataset go to the original author on Kaggle.


## Sample data

The `SUPPORT FILES` are **synthetic** sample data so that the database can be populated and explored immediately:

- **`BadgeSwipes_SampleData_GitHub.xlsx`** — AI-generated badge swipe events (built using the prompt in `AI_Prompt.docx`), designed to include realistic patterns and edge cases (e.g. missing exits, multiple swipes per day).
- **`Attendances_SampleData_GitHub.xlsx`** — randomly assigns other attendance (leave, sick days, etc.) and their durations on top of ordinary working hours, simulating a more complete real-world attendance mix.
- **`MasterData_GitHub.xlsx`** — the reference values (companies, departments, attendance, employees) used to seed the master tables.

### Setup

Run the scripts **in order**:

```sql
-- 1. Create the database schema (tables, keys, constraints)
:r TAM_Database_Creation.sql

-- 2. Load master data (companies, departments, causali, users)
:r TAM_Database_INSERT_MasterData.sql

-- 3. Load transactional sample data (attendance records)
:r TAM_Database_INSERT_TransactionaData.sql
```

Or simply open each `.sql` file in SSMS and execute it against your target database, in the order listed above — the creation script must run first, followed by master data, followed by transactional data, since later scripts depend on the keys established earlier.
