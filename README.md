
# US Household Income Data Cleaning & EDA (MySQL)

## Project Overview

This project involves cleaning and exploratory data analysis (EDA) of US Household Income data using MySQL. The goal is to identify duplicates, fix inconsistencies, and explore income trends based on state, city, and area type.

##  Data Cleaning Steps

1. **Preview Raw Datasets**: Explored `US_Household_Income` and `US_Household_Income_Statistics` tables.
2. **Count Total Rows**: Verified total records using `COUNT(id)`.
3. **Identify Duplicates**: Detected duplicate `id`s using `GROUP BY` and `HAVING`.
4. **Remove Duplicates**: Used `ROW_NUMBER()` with `DELETE` to keep only the first occurrence.
5. **Fix Inconsistent State Names**: Corrected typos like 'georia' → 'Georgia'.
6. **Fill Nulls**: Updated missing `Place` values using matching logic (e.g., city + county).
7. **Standardize Type Field**: Fixed inconsistencies (e.g., 'Boroughs' → 'Borough').
8. **Detect Anomalies**: Flagged rows with 0 or NULL values in land or water columns.
9. **Summarize Geography**: Explored ALand and AWater distributions by state.

##  EDA Insights

- **Join Operation**: Merged income and stats tables on `id`.
- **Income Distribution**: Analyzed average Mean & Median income by state and area type.
- **Filtered Analysis**: Removed outliers and zero income rows for accurate insights.
- **Top Locations**: Identified cities and states with the highest average income.
- **Grouping by Type**: Evaluated income trends across urban, CDP, Borough, etc.

##  Screenshots

Each screenshot demonstrates one step in the process:

- `Step1_Preview_Data.png`
- `Step2_Identify_Duplicates.png`
- `Step3_Remove_Duplicates.png`
- `Step4_Identify_State_Names _Error.png`
- `Step5_Fix_State_Names.png`
- `Step6_Identify_NULL_Place.png`
- `Step7_Update_Place.png`
- `Step8_Standardize_Naming_Type.png`
- `Step9_Name_Type_Standardized.png`

##  Tools Used

- **MySQL Workbench** for query execution and analysis
- **Screenshots** taken for documentation and transparency
- **Manual corrections** to address inconsistent or missing entries

##  Files Included

- `USHH_Income_Cleaning.sql` – SQL script for data cleaning
- `USHH_Income_EDA_Updated.sql` – SQL script for EDA
- Screenshots demonstrating key stages
- `README.md` – Project overview and documentation

---

> **Author**: Latif Yari  
> **Date**: March 2025  
> **Status**: ✅ Completed & Documented
