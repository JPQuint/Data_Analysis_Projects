🌎 Read this in: [English](README.md) | [Español](README.es.md)

# Excel Salary Dashboard

![1_Salaries_Calculator.gif](/0_Resources/Images/Excel_projects/1_Salaries_Calculator.gif)

## Introduction

This data jobs salary dashboard shows information about the global data job market in 2023. Its purpose is to give some context for data job seekers about the market. Although the data is US-centered, it allows users to explore job postings, median salaries and recruitment portals across the globe.

### Dashboard File
My final dashboard is in [Data_Jobs_Dashboard.xlsx](Data_Jobs_Dashboard.xlsx).

### Data Jobs Dataset

The dataset used for this project contains real-world data science job information from 2023. It includes detailed information on:

- **👨‍💼 Job titles**
- **💰 Salaries**
- **📍 Locations**
- **🛠️ Skills**


### Excel Skills Used

The following Excel skills were utilized for analysis:

- **📉 Charts**
- **🧮 Formulas and Functions**


## Dashboard Build

### 📉 Charts

#### 📊 Data Science Job Salaries - Bar Chart

<img src="/0_Resources/Images/Excel_projects/1_Salaries_Dashboard_Chart.JPG" width="850" height="550" alt="Salary Dashboard Chart1">

- **Excel Features:** Utilized bar chart feature with formatted salary values.
- **Design Choice:** Horizontal bar chart for visual comparison of median salaries.
- **Data Organization:** Sorted job titles by descending salary for improved readability.
- **Insights Gained:** This enables quick identification of salary trends, noting that Senior roles and Engineers are higher-paying than Analyst roles.

#### 🗺️ Country Median Salaries - Map Chart

![1_Salary_Dashboard_Country_Map.gif](/0_Resources/Images/Excel_projects/1_Salary_Dashboard_Country_Map.gif)

- **Excel Features:** Utilized Excel's map chart feature to plot median salaries globally.
- **Design Choice:** Color-coded map to visually differentiate salary levels across regions.
- **Data Representation:** Plotted median salary for each country with available data.
- **Insights Gained:** Enables quick grasp of global salary disparities and highlights high/low salary regions.

### 🧮 Formulas and Functions

#### 💰 Median Salary by Job Titles

```
=MEDIAN(
IF(
    (jobs[job_title_short]=A2)*
    (jobs[job_country]=country)*
    (ISNUMBER(SEARCH(type,jobs[job_schedule_type])))*
    (jobs[salary_year_avg]<>0),
    jobs[salary_year_avg]
)
)
```

- 🔍 **Multi-Criteria Filtering:** Checks job title, country, schedule type, and excludes blank salaries.
- 📊 **Array Formula:** Utilizes `MEDIAN()` function with nested `IF()` statement to analyze an array.
- 🎯 **Tailored Insights:** Provides specific salary information for job titles, regions, and schedule types.
- **🔢 Formula Purpose:** This formula populates the table below, returning the median salary based on job title, country, and type specified.

*Background Table:*

![1_Salary_Dashboard_Table1.png](/0_esources/Images/Excel_projects/1_Salary_Dashboard_Table1.png)

📉 Dashboard Implementation

<img src="/0_Resources/Images/Excel_projects/1_Salary_Dashboard_Job_Title.png" width="400" height="500" alt="Salary Dashboard Title">

#### Count of Job Schedule Type

```
=FILTER(J2#,(NOT(ISNUMBER(SEARCH("and",J2#))+ISNUMBER(SEARCH(",",J2#))))*(J2#<>0))
```

- **Unique List Generation:** This Excel formula below employs the `FILTER()` function to exclude entries containing "and" or commas, and omit zero values.
- **Formula Purpose:** This formula populates the table below, which gives us a list of unique job schedule types.

*Background Table:*

![1_Salary_Dashboard_Table2.png](/0_Resources/Images/Excel_projects/1_Salary_Dashboard_Table2.png)

📉 Dashboard Implementation:

<img src="/0_Resources/Images/Excel_projects/1_Salary_Dashboard_Type.png" width="350" height="500" alt="Salary Dashboard Type">

## Conclusion

Some insights extracted from this dashboard are that analysts earn less than scientist or engineers, the median salary of a Data Analyst tends to be around $90,000 yearly and Indeed is a very popular job portal for data-related jobs. Unfortunately, the data set doesn't have sufficient data for making quality insights about the market in Mexico.
