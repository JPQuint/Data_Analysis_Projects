/* EN
Question: What are the top-paying Data Analyst jobs in Mexico?
- Identify the top 10 highest-paying Data Analyst roles that are available in Mexico.
- Focuses on job postings with specified salaries (remove nulls).
- Why? To offer insights into employment opportunities for Data Analysts.
*/

/* ES
Pregunta: ¿Cuáles son los empleos de analista de datos mejor pagados en México?
- Identificar los top 10 empleos mejor pagados para analistas de datos en México.
- Concentrado en ofertas de trabajo que publican el salario (remueve nullss).
- ¿Por qué? Para ofrecer información sobre oportunidades de empleo para analistas de datos.
*/

SELECT
    job_id,
    job_title_short,
    job_title,
    job_location,
    job_posted_date,
    salary_year_avg,
    company_dim.name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location LIKE '%Mexico%' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;