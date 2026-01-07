🌎 Read this in: [English](README.md) | [Español](README.es.md)

# Introduction
This project consists of an analysis of the data job market in 2023 for data analysts offers in Mexico, it includes top-paying jobs, in-demand skills and optimal skills to learn. Its objective is to give detailed insights into the state of the job market such that data analysts in Mexico can make informed decisions about their professional careers. 

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs in Mexico?
2. What skills are required for these top-paying jobs in Mexico?
3. What skills are most in demand for data analysts in Mexico?
4. Which skills are associated with higher salaries in Mexico?
5. What are the most optimal skills to learn in Mexico?

# Tools
For my deep dive into the data analyst job market, I used several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed to investigate specific aspects of the data analyst job market, particularly about salaries and skills. So, before every analysis it is good practice to evaluate the usefulness of the data set. For this reason, I checked on the salary and skills data of job postings in Mexico:

For salaries:
```sql
SELECT
    salary_rate,
    COUNT(*)
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location LIKE '%Mexico%'
GROUP BY salary_rate
```
For skills:

```sql
SELECT
    COUNT(DISTINCT jobs.job_id) AS total_jobs,
    COUNT(DISTINCT skills_job.job_id) AS jobs_with_skills,
    COUNT(DISTINCT jobs.job_id) - COUNT(DISTINCT skills_job.job_id) AS jobs_without_skills
FROM job_postings_fact AS jobs
LEFT JOIN skills_job_dim AS skills_job
    ON skills_job.job_id = jobs.job_id
WHERE
    jobs.job_title_short = 'Data Analyst'
    AND jobs.job_location LIKE '%Mexico%';
```
- **Salaries data:** Out of 2736 job postings for Data Analysts in Mexico, only 39 (1.4%) posted a salary offering, all of them rated yearly.
- **Skills data:** Out of 2736 job postings for Data Analysts in Mexico, 2292 (83%) posted skills.
- **Conclusion:** Almost none of the retrieved job posting for Data Analysts in Mexico contain an offered salary, so any analysis using this metric must be taken with a grain of salt. On the other hand, skills data is much richer. Nonetheless, for the sake of the project I will be using both metrics.


 Let's begin with the posed questions:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title_short,
    job_location,
    job_posted_date,
    salary_year_avg,
    company_dim.name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location LIKE '%Mexico%' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top 10 data analyst jobs in 2023:
- **Salary cap:** Although the most paying job offered $165,000 yearly, 7 of the top salaries in Mexico offered closed to or exactly $111,175 yearly, signaling a cap for Data Analysts salaries.
- **CDMX's concentration:** 6 of the best paying jobs are in CDMX while no other city repeats itself, making CDMX the best location for high profile Data Analysts in Mexico. 
- **Job postings dates:** Out of the 10 best payings offers, 6 were posted in the first trimester of the year and the most late posting was in July. This means that the best opportunities are announced early in the year and they taper off towards the end.

### 2. Skills for Top Paying Jobs
To understand what skills are required for this top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
WITH
  top_paying_jobs AS (
    SELECT
      job_id,
      job_title_short,
      job_location,
      job_posted_date,
      salary_year_avg,
      company_dim.name AS company_name
    FROM
      job_postings_fact
      LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
      job_title_short = 'Data Analyst'
      AND job_location LIKE '%Mexico%'
      AND salary_year_avg IS NOT NULL
    ORDER BY
      salary_year_avg DESC
    LIMIT
      10
  )
SELECT
  skills_dim.skills,
  COUNT(*)
FROM
  top_paying_jobs
  INNER JOIN skills_job_dim ON skills_job_dim.job_id = top_paying_jobs.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY 
  skills
ORDER BY COUNT(*) DESC
LIMIT 10;
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023 in Mexico:
- **SQL** is leading with a count of 7.
- **Python** follows closely with a count of 5.
- **Conclusion**: SQL and Python are the most important skills for high paying jobs. While **looker**, **R** and **Excel** have a count of 3, most of the other skills are job-specific.

### 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT
  skills_dim.skills,
  COUNT(skills_job_dim.job_id) AS demand_count
FROM
  job_postings_fact
  INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
  job_title_short = 'Data Analyst' AND
  job_location LIKE '%Mexico%'  
GROUP BY
  skills_dim.skills
ORDER BY
  demand_count DESC
LIMIT 5;
```
Here's the breakdown of the most demanded skills for data analysts in 2023 in Mexico:

- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.
- **Global skills**: If we remove the the location condition, the same skills appear in equal order, meaning they were the most demanded skills globally for data analysts in 2023, with Mexico as no exception.

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 1184         |
| Excel    | 1120         |
| Python   | 769          |
| Tableau  | 609          |
| Power BI | 594          |

*Table of the top 5 most demanded skills in data analyst job postings in Mexico*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
SELECT
  skills_dim.skills,
  ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS salary_avg
FROM
  job_postings_fact
  INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
  job_title_short = 'Data Analyst' AND
  job_location LIKE '%Mexico%' AND
  salary_year_avg IS NOT NULL
GROUP BY
  skills_dim.skills
ORDER BY
  salary_avg DESC
LIMIT
  10;
```
Here's a breakdown of the results for top paying skills for Data Analysts:
- **High demand for programming skills:** The top three most paid skills are program languages (scala, spark and go) with R also making it to the top 10 and beating Python over 1 place. 
- **High demand for Big Data & Cloud storage:** Top salaries are commanded by analysts skilled in big data technologies (bigquery, redshift, kafka, aws), which, along with the programming languages reflects the industry's high valuation of data processing and cloud technologies.
- **SQL** Interesting, SQL makes the list, signaling its importance across all of the paying spectrum.

| Skills        | Average Salary ($) |
|---------------|-------------------:|
| scala         |            147,500 |
| spark         |            129,338 |
| go            |            111,202 |
| bigquery      |            111,175 |
| redshift      |            111,175 |
| github        |            111,175 |
| kafka         |            111,175 |
| aws           |            111,175 |
| sql           |            103,801 |
| r             |            103,601 |

*Table of the average salary for the top 10 paying skills for data analysts. It can be seen the repetition of multiple average salaries, this is caused by the small sample size of posted salaries in Mexico*

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT
  skills_dim.skills,
  COUNT(skills_job_dim.job_id) AS demand_count,
  ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS salary_avg
FROM
  job_postings_fact
  INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
  job_title_short = 'Data Analyst' AND
  job_location LIKE '%Mexico%' AND
  salary_year_avg IS NOT NULL
GROUP BY
  skills_dim.skills
ORDER BY
  demand_count DESC,
  salary_avg DESC
LIMIT 10;
```
| Skills     | Demand Count | Average Salary ($) |
|------------|--------------|-------------------:|
| excel      | 18           |             78,588 |
| tableau    | 14           |             76,691 |
| power bi   | 12           |             80,933 |
| sql        | 11           |            103,801 |
| python     | 8            |            102,591 |
| sheets     | 8            |             62,758 |
| looker     | 5            |             95,181 |
| r          | 4            |            103.601 |
| aws        | 3            |            111,175 |
| express    | 3            |             54,509 |

*Table of the most optimal skills for data analyst sorted by salary*

Here's a breakdown of the most optimal skills for Data Analysts in 2023 in Mexico: 
- **Disparity in demand and pay:** The most demanded skills such as excel, tableau and PowerBI don't come with specially high salaries, the only exception to the rule could be SQL.
- **Programming languages:** Python and R show some of the highest pays and good demand. Although, no other programming language is featured in the table.
- **Business Intelligence and Visualization Tools:** Tableau, Looker, and PowerBI feature in the table with good demand and similar pay range, signaling the importance of visualizations technologies.

# What I Learned

Throughout this project I developed some SQL abilities.

- **Complex Query Crafting:** Joined multiples tables maintaining order, build temp tables using WITH and created complex queries for answering the posed questions.
- **Data Aggregation:** Got comfortable with GROUP BY and turned aggregate functions like COUNT() and AVG() into recurrent tools.
- **Applied Critical thinking:** Before every analysis is important to know the qualities of the data at work and the scope of the analyisis. That is why I verified the amount of posted salaries and skills within the data set.

# Conclusions

### Insights
From the analysis, several general insights emerged:

1. **Highest salaries:**  This data set shows that little job offers in Mexico for Data Analysts post the salary, making it difficult to obtain quality salary insights. Nonetheless, the analysis shows an aproximate salary cap of $115,000 USD and a CDMX bias for high paying jobs.

2. **Skills for Top-Paying Jobs**: It seems that high-paying data analyst jobs in Mexico require strong SQL, Python and data visualizations skills.

3. **Most In-Demand Skills**: SQL was the most demanded skill in the data analyst job market followed by Excel and Python in Mexico and the world, thus making them essential for job seekers.

4. **Skills with Higher Salaries**: According to this data set, specific programin skills and big data/cloud technologies were very well paid in Mexico in 2023. But the lack of posted salaries makes this insight questionable.

5. **Optimal Skills for Job Market Value**: What is clear is that SQL leads in demand across all the salary spectrum, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value. Other skills such as Excel, tableau or PowerBI cannot be ignored, but Python seems to be well-demanded and well-paid.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the mexican data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.