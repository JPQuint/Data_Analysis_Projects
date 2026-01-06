/* EN
Question: What skills are required for top-paying data analyst jobs in Mexico?
- Identify the top 10 highest-paying Data Analyst jobs in Mexico.
- Add the specific skills required for these roles.
- Why? To provide perspective on the most demanded skills in the best-paying jobs in Mexico.
 */
 
/* ES
Pregunta: ¿Qué habilidades son requeridas para los mejores empleos de analista de datos en México?
- Identificar los top 10 empleos mejor pagados para analistas de datos en México.
- Contar las habilidades especificas de estos empleos.
- ¿Por qué? Para proveer una perspectiva de las habilidades requeridas en los empleos mejor pagados en México.
*/


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