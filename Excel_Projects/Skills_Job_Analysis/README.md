🌎 Read this in: [English](README.md) | [Español](README.es.md)

# Project 2 Analysis

## Introduction

This analysis has the objective of showing the most important and well-paid skills in the data job market in 2023. With this, job seekers have crucial information on what skills to learn.

### Questions to Analyze

To understand the market, the following questions were posed:

1. **Do more skills get you better pay?**
2. **What’s the salary for data jobs in different regions?**
3. **What are the top skills of data professionals?**
4. **What’s the pay for the top 10 skills?**

### Excel Skills Used

The following Excel skills were utilized for analysis:

- **Pivot Tables**
- **Pivot Charts**
- **DAX (Data Analysis Expressions)**
- **Power Query**
- **Power Pivot**

### Data Jobs Dataset

The dataset used for this project was obtained in the Luke Barousse Excel course and contains real-world data science job information from 2023.

It includes detailed information on:

- **👨‍💼 Job titles**
- **💰 Salaries**
- **📍 Locations**
- **🛠️ Skills**

## 1️⃣ Do more skills get you better pay?

### Skill: Power Query (ETL)

#### A) Extract

- I first used Power Query to extract the original data (`data_salary_all.xlsx`) and create two queries:
    - First one with all the data jobs information.
    - The second listing the skills for each job ID.

#### B) Transform

- Then, I transformed each query by changing column types, removing unnecessary columns and cleaning text to eliminate specific characters.
    - data_jobs_all

        ![1_Power_Query1.jpg](/0_Resources/Images/Excel_projects/2_Power_Query1.JPG)

    - data_job_skills

        ![2_Power_Query2.jpg](/0_Resources/Images/Excel_projects/2_Power_Query2.JPG)

#### C) Load

- Finally, I loaded both transformed queries into the workbook, setting the foundation for my subsequent analysis.
    - data_jobs_all

        ![3_Power_Query3.jpg](/0_Resources/Images/Excel_projects/2_Power_Query3.JPG)

    - data_job_skills

        ![4_Power_Query4.jpg](/0_Resources/Images/Excel_projects/2_Power_Query4.JPG)

### 📊 Analysis

#### Insights

- There is a **positive correlation** between the number of skills requested in job postings and the median salary, particularly in roles like Senior Data Engineer and Data Scientist.
- Roles that require **fewer skills**, like Business Analyst, tend to offer **lower salaries**, suggesting that more specialized skill sets command higher market value.
- **Engineer roles** tend to require more skills but they are not always accompanied by higher salaries.

    ![2_Project_Analysis_Chart1.png](/0_Resources/Images/Excel_projects/2_Project_Analysis_Chart1.png)

#### So What?

- This trend emphasizes the value of acquiring multiple relevant skills, particularly for individuals aiming for higher-paying roles.

## 2️⃣ What’s the salary for data jobs in different regions?

### Skills: PivotTables & DAX

#### Pivot Table

- I created a PivotTable using the Data Model I created with Power Pivot.
- I moved the `job_title_short` to the rows area and `salary_year_avg` into the values area.
- Then I added new measure to calculate the median salary for United States jobs.
    ```
    =CALCULATE(
        MEDIAN(data_jobs_all[salary_year_avg]),
        data_jobs_all[job_country] = "United States")
    ```

#### DAX

- To calculate the median year salary I used DAX.

    ```
    Median Salary := MEDIAN(data_jobs_all[salary_year_avg])
    ```


### 📊 Analysis

#### Insights

- Job roles like **Senior Data Engineer** and **Data Scientist** command higher median salaries both in the US and internationally, showcasing the global demand for high-level data expertise.
- The **salary disparity** between US and Non-US roles is particularly notable in high-tech jobs, which might be influenced by the concentration of tech industries in the US.

    ![2_Project_Analysis_Chart2.png](/0_Resources/Images/Excel_projects/2_Project_Analysis_Chart2.png)

#### **So What?**

- These salary insights are important for planning and salary negotiations, helping professionals and companies align their offers with market standards while considering geographical variations.

## 3️⃣ What are the top skills of data professionals?

### Skill: Power Pivot

#### Power Pivot

- I created a data model by integrating the `data_jobs_all` and `data_jobs_skills` tables into one model.
- Since I had already cleaned the data using Power Query; Power Pivot created a relationship between these two tables.

#### 🔗
- I created a relationship between my two tables using the `job_id` column.

    ![2_Project_Analysis_Model.png](/0_Resources/Images/Excel_projects/2_Project_Analysis_Model.png)


### 📊Analysis

####Insights

- **SQL** and **Python** dominate as top skills in data-related jobs, reflecting their foundational role in data processing and analysis.
- **Emerging technologies** like AWS and Azure also show significant presence, underlining the industry's shift towards cloud services and big data technologies.

    ![2_Project_Analysis_Chart3.png](/0_Resources/Images/Excel_projects/2_Project_Analysis_Chart3.png)

#### So What?

- Understanding prevalent skills in the industry not only helps professionals stay competitive but also guides training and educational programs to focus on the most impactful technologies.

## 4️⃣ What’s the pay of the top 10 skills?

### Skill: Advanced Charts (Pivot Chart)

#### PivotChart

- I created a combo PivotChart to plot median salary and skill likelihood (%) from my PivotTable.
    - **Primary Axis:** Median Salary (as a Clustered Column)
    - **Secondary Axis:** Skill Likelihood or Skill Count/Job Count (as a Line with Markers)

### 📊 Analysis

#### nsights

- **Higher median salaries** are associated with skills like Python, Oracle, and SQL, suggesting their critical role in high-paying tech jobs.
- Skills like PowerPoint and Word have the lowest median salaries and likelihood, indicating less specialization and demand in high-salary sectors.
- Although **Excel** may not be the most paid skill, it is crucial for its likelihood.

    ![2_Project_Analysis_Chart4.png](/0_Resources/Images/Excel_projects/2_Project_Analysis_Chart4.png)

### 🤔So What

- This chart highlights the importance of investing time in learning high-value skills like Python and SQL, which are evidently tied to higher paying roles, especially for those looking to maximize their salary in the tech industry.

## Conclusion

This project uncovers valuable insights about the salaries and skills of the data job market globally. It allows users to explore between job titles, locations and essential skills using mainly Power Query and Pivot tables/charts. The results show correlation between multiple skills and higher salaries, the trend of data engineers of requiring more skills and the importance of Python, SQL, Excel and cloud technologies in 2023.
