SELECT 
    company_id,
    name AS company_name
FROM
    company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM 
        job_postings_fact
    WHERE
        job_no_degree_mention = true
    ORDER BY
        compani_id
);

/*
Find the companies that have the most job openings.
- Get the total number of job postings per company (job_postings_fact)
- Return the total number of jobs with the company name (comapny_dim)
*/

WITH company_job_count AS (
SELECT
    company_id,
    COUNT(*) AS total_jobs,
    job_location
FROM
    job_postings_fact
GROUP BY
    company_id, job_location
)
SELECT
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
WHERE job_location LIKE '%Mexico%'
ORDER BY
    total_jobs DESC;

/* 
Identify the top 5 skills that are most frequently mention in job postings
*/

WITH skill_job_count AS (
SELECT
    skill_id,
    COUNT(*) AS skill_count
FROM skills_job_dim
GROUP BY skill_id)
SELECT
    skills_dim.skills,
    skill_job_count.skill_count
FROM skills_dim
LEFT JOIN skill_job_count ON skill_job_count.skill_id = skills_dim.skill_id
ORDER BY
    skill_count DESC;


/*
Determine the size category for each company by first indentifying the number of job postings they have
*/

WITH company_job_count AS (
SELECT
    company_id,
    COUNT(*) AS total_jobs
FROM
    job_postings_fact
GROUP BY
    company_id
)

SELECT
COUNT(company_job_count.total_jobs),
    CASE
        WHEN total_jobs < 10 THEN 'Small'
        WHEN total_jobs BETWEEN 10 AND 50 THEN 'Medium'
        WHEN total_jobs > 50 THEN 'Large'
        ELSE 'No_info'
    END AS company_size
FROM job_postings_fact
LEFT JOIN company_job_count ON job_postings_fact.company_id = company_job_count.company_id
GROUP BY
    company_size;