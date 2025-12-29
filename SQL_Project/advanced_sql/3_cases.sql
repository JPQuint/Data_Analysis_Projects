SELECT
    AVG(salary_year_avg),
    COUNT(job_id),
    CASE
        WHEN salary_year_avg < 80000 THEN 'Low'
        WHEN salary_year_avg BETWEEN 80000 AND 120000 THEN 'Aimed'
        WHEN salary_year_avg > 120000 THEN 'High'
        ELSE 'Not listed'
    END AS salary_bucket
FROM job_postings_fact
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location LIKE '%Mexico%'
GROUP BY
    salary_bucket;
