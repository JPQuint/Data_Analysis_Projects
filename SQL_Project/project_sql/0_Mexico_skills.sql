/* EN
Question: Is it viable an analyisis of Mexico's "Data Analyst" salaries with this data set?
- Count how mant job postings have skills attached.
- Assess if the sample has a sufficient size for the analysis.
- Why? To not make a flawed analyisis that leads to wrong conclusions.
*/

/* ES
Pregunta: ¿El data set es útil para un análisis de las habilidades solicitadas para analistas de datos en México?
- Contar cuantas ofertas de trabajo incluyen habilidades en relación con las ofertas totales.
- Determinar si la muestra es adecuada para un análisis.
- ¿Por qué? Para evitar un análisis que lleve a conclusiones incorrectas.
*/

SELECT
    COUNT(DISTINCT jobs.job_id) AS total_jobs,
    COUNT(DISTINCT skills_job.job_id) AS jobs_with_skills,
    COUNT(DISTINCT jobs.job_id) - COUNT(DISTINCT skills_job.job_id) AS jobs_without_skills
FROM job_postings_fact AS jobs
LEFT JOIN skills_job_dim AS skills_job
    ON skills_job.job_id = jobs.job_id
WHERE
    jobs.job_title_short = 'Data Analyst'
    AND jobs.job_location LIKE '%Mexico%';

