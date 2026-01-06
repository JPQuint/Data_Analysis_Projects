/* EN
Question: What are the most optimal skills to learn (aka it's high in demand and a high-paying skills)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles.
- Concentrates on positions in Mexico with specified salaries.
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights into career development in data analysis.
*/

/* ES
Pregunta: ¿Cuáles son las habilidades óptimas para aprender en México (las que más demanda y pagan poseen??
- Identificar habilidades muy demandadas y asociadas con salarios altos en puestos de analistas de datos.
- Enfocado en posiciones en México con salarios publicados.
- ¿Por qué? Para identificar habilidades que otorguen seguridad laboral (alta demanda) y beneficios financieros
(alto salario) y ayudar a analistas de datos en su desarrollo profesional.
*/

SELECT
  skills_dim.skills,
  COUNT(skills_job_dim.job_id) AS demand_count,
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
  demand_count DESC,
  salary_avg DESC
LIMIT
  10;