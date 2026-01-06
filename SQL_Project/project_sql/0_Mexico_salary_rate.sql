/* EN
Question: Is it viable an analyisis of Mexico's "Data Analyst" salaries with this data set?
- Count how many postings of "Data Analyst" in Mexico the data set contains.
- Identify the most common salary rate posted (hourly, monthly, yearly, etc.).
- Assess if the data set is suitable for doing an Analysis of salaries 
- Why? To not make a flawed analyisis that leads to wrong conclusions.
*/

/* ES
Pregunta: ¿Es viable hacer un análisis de los salarios de "Analista de datos" en México con este data set?
- Contar cuántas ofertas de empleo para "Analista de datos" en México incluye el data set.
- Identificar la tasa salarial anunciada más común (por hora, por semana, por año, etc.)
- Determinar si el data set sirve para un análisis de los salarios.
- ¿Por qué? Para evitar un análisis que lleve a conclusiones incorrectas.
*/

SELECT
    salary_rate,
    COUNT(*)
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location LIKE '%Mexico%'
GROUP BY salary_rate

