/*
Question: What are the most optimal skills to learn (aka it's high in demand and a high-paying skills)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles.
- Concentrates on positions in Mexico with specified salaries.
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights into career development in data analysis.
*/

SELECT
  sd.skills,
  COUNT(sjd.job_id) AS demand_count,
  ROUND(AVG(tpf.salary_year_avg), 0) AS salary_avg
FROM
  job_postings_fact AS tpf
  INNER JOIN skills_job_dim AS sjd ON sjd.job_id = tpf.job_id
  INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
  job_title_short = 'Data Analyst' AND
  job_location LIKE '%Mexico%' AND
  salary_year_avg IS NOT NULL
GROUP BY
  sd.skills
ORDER BY
  demand_count DESC,
  salary_avg DESC
LIMIT
  10;


WITH skills_demand AS(
SELECT
    sjd.skill_id,
  sd.skills,
  COUNT(sjd.job_id) AS demand_count
FROM
  job_postings_fact AS tpf
  INNER JOIN skills_job_dim AS sjd ON sjd.job_id = tpf.job_id
  INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
  job_title_short = 'Data Analyst' AND
  job_location LIKE '%Mexico%' AND
  salary_year_avg IS NOT NULL
GROUP BY
  sjd.skill_id, sd.skills
), average_salary AS (
SELECT
    sjd.skill_id,
  sd.skills,
  ROUND(AVG(tpf.salary_year_avg), 0) AS salary_avg
FROM
  job_postings_fact AS tpf
  INNER JOIN skills_job_dim AS sjd ON sjd.job_id = tpf.job_id
  INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
  job_title_short = 'Data Analyst' AND
  job_location LIKE '%Mexico%' AND
  salary_year_avg IS NOT NULL
GROUP BY
    sjd.skill_id, sd.skills
)
SELECT
    skills_demand.skill_id,
    skills_demand.demand_count,
    skills_demand.skills,
    average_salary.salary_avg
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY
    demand_count DESC,
    salary_avg DESC
LIMIT 25;