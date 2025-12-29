SELECT
    job_posted_date,
    name
FROM
    job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_health_insurance = TRUE AND
     EXTRACT(QUARTER FROM job_posted_date) = 2;