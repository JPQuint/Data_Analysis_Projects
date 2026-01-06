/* EN
Question: What are the most in-demand skills for data analysts in Mexico?
- Inner join, jobs, skills and skills_job tables similar to query 2
- Identify the top 5 in-demand skills for data analyst in Mexico.
- Why? To retrieve the top 5 skills with the highest demand in the job market
and to help job seekers build a better profile.
*/

/* ES
Pregunta: ¿Cuáles son las habilidades más demandadas para analistas de datos en México?
- Inner join la tabla de trabajos con la de skillks y skills_job.
- Identificar las top 5 habilidades más demandadas para analistas de datos en México. 
- ¿Por qué? Para recolectar las habilidades más demandadas en en México y ayudar
a los analistas de datos para fortalecer su perfil. 
*/

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
LIMIT
  5;