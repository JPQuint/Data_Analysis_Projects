🌎 Read this in: [English](README.md) | [Español](README.es.md)

# Project 2 – Dashboard

![Data Dashboard Page](/0_Resources/Images/PowerBI_projects/Project2_Dashboard1.JPG)

## Introduction

The dashboard from the first project enables a very rich analysis of the job market for data scientists, engineers, and analysts in 2024. However, the excess of information can be counterproductive, as it may divert attention from the most important insights. For this reason, I created a cleaner and more concise dashboard following the [Catalonia Government Data Visualization Guide](https://atenciociutadana.gencat.cat/web/.content/manuals/visualitzacio_dades/guia_visualitzacio_es.pdf). Additionally, I decided to expand the dataset by including information from both 2023 and 2024.

### Dashboard File
The final dashboard can be found here: [`Dashboard_2.0.pbix`](Dashboard_2.0.pbix).

## Methodology

The methodology used is divided into three main steps: the strategy for presenting information, data handling, and design.

### Strategy

This first stage consists of defining the scope of the analysis, identifying the target audience and clarifying the objective:

- **Scope Definition:** The topic is the data job market in 2023 and 2024. There are many possible analytical approaches (exploratory, analytical, and explanatory), so it is important to define guiding questions (what, how, when, where) to delimit the analysis. In this case, they are:
  
  - What is required for a data analyst, data engineer, or data scientist role?
  - What characteristics do these job postings have (salary, remote work, etc.)?
  - When are job postings published?
  - Who are these job postings targeted at?

- **Target Audience:** Data analysts, engineers, or scientists who want a quick overview of the job market. The dashboard is designed to be consulted in a short time frame (maximum 1 minute).

- **Main Objective:** To provide relevant information (salaries, in-demand skills, job posting trends) for junior data analysts, engineers, or scientists who are seeking jobs in the data field.

- To achieve this objective, the following **key indicators** were selected:
  - Number of job postings
  - Median annual salary
  - Average number of skills required per role
  - Most in-demand skills
  - Job posting trends over time
  - Percentage of remote jobs
  - Percentage of postings that mention a degree

With this strategy, it is possible to build a simple dashboard with concise, relevant information and minimal visual noise.

## Data Handling

In this project, I retrieved separate datasets for the years 2023 and 2024. Each dataset contains four tables and has its own identifiers. This means that a simple union of the tables is not possible, as identifiers would be duplicated. Therefore, data cleaning and a new data model had to be created using Power Query.

### Power Query

**1. Load and Prepare Tables**

First, the tables were loaded and lightly cleaned. New columns called "*X*_id_global" were created, containing the original identifiers, in order to enable proper table relationships.

![Power Query Applied Steps 1](/0_Resources/Images/PowerBI_projects/Project2_Power_Query1.JPG)  
*Main table of the 2023 dataset*

**2. Create New Identifiers**

However, this strategy does not work for all identifiers. For example, `skill_id` represents skills as follows:

| skill_id | skill_name |
|---------:|------------|
| 1        | sql        |
| 2        | Python     |
| 3        | R          |

Since `skill_id` values do not match between years, but skill names remain consistent, a new identifier (`skill_key`) must be created to avoid mixing or losing information. This required a series of careful merges to obtain the final tables. Unfortunately, due to how merges work in Power Query, residual tables must be kept, which slow down data processing (though not visualization). This is something that could be avoided using SQL.

![Power Query Applied Steps 2](/0_Resources/Images/PowerBI_projects/Project2_Power_Query3.JPG)

![Power Query Tables](/0_Resources/Images/PowerBI_projects/Project2_Power_Query2.JPG)  
*The `job_postings_fact` table ended up with a total of 1,266,581 rows.*

### Measures & DAX

Finally, a series of measures were created using DAX to help represent several of the indicators used in the dashboard.

![Measures](/0_Resources/Images/PowerBI_projects/Project2_Dashboard2.JPG)

![Data Model](/0_Resources/Images/PowerBI_projects/Project2_Dashboard3.JPG) *The final data model*

## Design

Lastly, the dashboard was designed taking into account:
- The most appropriate visualizations for each indicator (line charts, bar charts, donut charts).
- The relative importance of indicators and how users typically scan information (left to right, top to bottom).
- Visual simplicity and appropriate color usage.

![Data Dashboard GIF](0_Resources/Images/PowerBI_projects/Project2_Dashboard.gif)

---

## Conclusion

Thanks to a strategic redesign of the data visualization approach, a revised dashboard was created that provides clear and relevant insights into the data job market for 2023 and 2024. It highlights key indicators such as salaries, most in-demand skills, job posting trends, and the percentage of remote jobs. This approach reduces the visual noise caused by less relevant metrics that hindered the informational goals of the first dashboard.

To achieve this, the project required deeper development of skills in:
- Data visualization strategy
- Power Query
- Measures & DAX
- Dashboard design
