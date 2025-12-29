/*
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill
*/
-- skill is in skills_dim, skills_id is in skill_job_dim, job_location = 'Anywhere' for remote jobs.

WITH remote_job_skills AS (
SELECT
    skill_id,
    COUNT(*) AS skill_count
FROM
    skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS jpf ON skills_to_job.job_id = jpf.job_id
WHERE 
    jpf.job_work_from_home = true AND
    job_title_short = 'Data Analyst'
GROUP BY
    skill_id
)

SELECT
    sd.skill_id,
    sd.skills AS skill_name,
    remote_job_skills.skill_count
FROM skills_dim AS sd
INNER JOIN remote_job_skills ON remote_job_skills.skill_id = sd.skill_id
ORDER BY skill_count DESC
LIMIT 5;