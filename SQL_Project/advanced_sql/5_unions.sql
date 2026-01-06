/*
- Get the corresponding skill and skill type for each job posting in q1
- include those without skills too
- Look at the skills and the type for each job in the first quarter that has
a salary > $70,000
*/

WITH test AS 
(SELECT
    job_id,
    salary_year_avg
FROM january_jobs

UNION ALL

SELECT
    job_id,
    salary_year_avg
FROM february_jobs

UNION ALL

SELECT
    job_id,
    salary_year_avg
FROM march_jobs
)

SELECT
    sd.skills,
    sd.type,
    test.job_id,
    test.salary_year_avg
FROM skills_dim AS sd
LEFT JOIN skills_job_dim AS sjd ON sjd.skill_id = sd.skill_id
RIGHT JOIN test ON test.job_id = sjd.job_id
WHERE test.salary_year_avg > 70000
;
