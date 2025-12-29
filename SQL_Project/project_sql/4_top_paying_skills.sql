/*
Question: What are the top skills based on salary for Data Analyst in Mexico?
- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries. regardless of location.
- Why? It reveals how different skills impact salary levels for Data Analysts and
    helps identify tge mos financially rewarding skills to acquire or improve.
*/

SELECT
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
  sd.skills
ORDER BY
  salary_avg DESC
LIMIT
  25;
