/* EN
Question: What are the top skills based on salary for Data Analyst in Mexico?
- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries.
- Why? To reveal how different skills impact salary levels for Data Analysts.
*/

/* ES
Pregunta: ¿Cuáles son las mejores habilidades basado en el salario para analistas de datos en México?
- Observar el salario promedio asociado con cada habilidad en las posiciones de análisis de datos.
- Enfocado a ofertas que publican el salario.
- ¿Por qué? Para revelar cómo distintas habilidades impactan en el salario de los analistas de datos.
*/

SELECT
  skills_dim.skills,
  ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS salary_avg
FROM
  job_postings_fact
  INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
  job_title_short = 'Data Analyst' AND
  job_location LIKE '%Mexico%' AND
  salary_year_avg IS NOT NULL
GROUP BY
  skills_dim.skills
ORDER BY
  salary_avg DESC
LIMIT
  10;
