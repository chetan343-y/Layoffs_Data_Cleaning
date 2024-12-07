# Layoff Data Cleaning and Analysis

This repository contains SQL scripts for cleaning and analyzing layoff data. The project focuses on ensuring data quality through cleaning, standardization, and exploratory data analysis (EDA) to uncover meaningful insights.

---

## **Project Overview**

The project involves:
- Removing duplicates and cleaning data inconsistencies.
- Standardizing fields for uniformity.
- Handling missing and null values.
- Analyzing trends and patterns in layoffs using SQL queries.

---

## **Features**

### **Data Cleaning**
1. **Duplicate Removal**:
   - Identified duplicates using `ROW_NUMBER()` and deleted redundant rows.
2. **Standardization**:
   - Trimmed whitespaces and formatted inconsistent values.
   - Standardized `industry` names and removed trailing characters in `country` names.
   - Converted `date` field from string to `DATE` type.
3. **Handling Null/Blank Values**:
   - Replaced blank `industry` values with matching company records.
   - Deleted rows with missing key fields like `total_laid_off` and `percentage_laid_off`.

### **Exploratory Data Analysis**
1. **General Aggregations**:
   - Identified maximum layoffs, total layoffs by company, industry, country, and date.
2. **Trend Analysis**:
   - Monthly and yearly layoff trends.
   - Calculated rolling totals by month.
3. **Top Performers**:
   - Ranked companies by layoffs for each year using `DENSE_RANK()`.
4. **Date Ranges**:
   - Determined the earliest and latest layoff events.

---

## **Technologies Used**
- SQL (MySQL)
- Database operations and management

---

## **Scripts**

### **1. Data Cleaning**
- Creates a staging table (`layoffs_staging`) for data transformation.
- Cleans duplicates and formats columns.
- Handles missing values and standardizes fields.

### **2. Data Standardization**
- Trims whitespaces and corrects inconsistent entries.
- Updates `industry`, `country`, and `date` fields for consistency.

### **3. Exploratory Data Analysis**
- Queries for insights, trends, and rankings.
- Aggregates data by different dimensions: company, industry, country, and date.

