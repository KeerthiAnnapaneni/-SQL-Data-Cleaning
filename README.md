
# SQL Data Cleaning Project - Layoffs Dataset

## 📌 Project Overview



In today's data-driven world, clean data is essential for accurate decision-making. This project demonstrates how to transform raw, inconsistent layoff data into a structured and reliable dataset using SQL. By improving data accuracy, this project enhances insights for layoff trends, industry analysis, and financial forecasting.


## 🚀 Key Highlights

- Skills Demonstrated: SQL, Data Cleaning, Data Standardization, Data Integrity

- SQL Techniques Used: Window Functions, CTEs, Aggregation, String Functions, Data Type Conversions

- Tools Used: MySQL

## 📊 Dataset Description

- Raw Data: LAYOFFS (RAW DATA).csv

- Cleaned Data: LAYOFFS (CLEANED DATA).csv

- SQL Script: SQL PROJECT (DATA CLEANING).sql

The dataset includes information such as company names, locations, industries, total layoffs, layoff percentages, funding, and dates.
## 🔍 Steps in Data Cleaning

### 1️⃣ Removing Duplicates

- Created a staging table layoffs_staging to store raw data.

- Used ROW_NUMBER() with PARTITION BY to detect and remove duplicates.

### 2️⃣ Standardizing Data

- Trimmed extra spaces from company names.

- Normalized industry names (e.g., changing variations of "Crypto" to a standard format).

- Removed unwanted characters from country names.

- Converted date fields from text to proper DATE format using STR_TO_DATE().

### 3️⃣ Handling NULL & Blank Values

- Identified missing values in critical fields.

- Used self-joins to fill missing industry values based on other entries.

- Removed incomplete records where key layoff metrics were missing.

### 4️⃣ Finalizing Cleaned Data

- Removed unnecessary columns (row_num used for duplicate removal).

- Verified the integrity of the cleaned dataset.


## 📈 Results & Insights

- The cleaned dataset is free from duplicates and inconsistencies.

- Industry and country names are standardized, improving analysis accuracy.

- Missing values were appropriately handled, ensuring reliable insights.


## 🎯 Why This Project Stands Out

- Industry-Relevant Data Transformation: Showcases real-world SQL data cleaning techniques applicable to business intelligence and analytics.

- ETL & Data Preparation Expertise: Demonstrates proficiency in SQL-based ETL processes, preparing datasets for decision-making and predictive analysis.

- Strong Problem-Solving & Optimization: Effectively applies SQL concepts to refine and structure raw data, ensuring usability and efficiency.

## 🔗 Connect with me for more projects!