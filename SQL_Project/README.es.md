🌎 Read this in: [English](README.md) | [Español](README.es.md)

# Introducción

Este proyecto consiste en un análisis del mercado laboral de analistas de datos en México durante 2023. Incluye el estudio de los empleos mejor pagados, las habilidades más demandadas y las habilidades óptimas para aprender. Su objetivo es ofrecer una visión detallada del estado del mercado laboral, de modo que los analistas de datos en México puedan tomar decisiones informadas sobre su desarrollo profesional.

🔍 ¿Consultas SQL? Revísalas aquí: [carpeta project_sql](/project_sql/)

🔍 ¿La base da datos? [carpeta project_sql](/project_sql/)

### Las preguntas que busqué responder mediante mis consultas SQL fueron:

1. ¿Cuáles son los empleos mejor pagados para analistas de datos en México?
2. ¿Qué habilidades se requieren para estos empleos mejor pagados en México?
3. ¿Cuáles son las habilidades más demandadas para los analistas de datos en México?
4. ¿Qué habilidades están asociadas con salarios más altos en México?
5. ¿Cuáles son las habilidades más óptimas para aprender en México?

# Herramientas

Para este análisis profundo del mercado laboral de analistas de datos utilicé varias herramientas clave:

- **SQL:** La base del análisis, que permitió consultar la base de datos y extraer hallazgos relevantes.
- **PostgreSQL:** El sistema de gestión de bases de datos elegido, ideal para manejar los datos de vacantes laborales.
- **Visual Studio Code:** Mi entorno principal para la gestión de la base de datos y la ejecución de consultas SQL.
- **Git y GitHub:** Esenciales para el control de versiones y la publicación de los scripts SQL y del análisis.

# Análisis

Cada consulta de este proyecto tuvo como objetivo investigar aspectos específicos del mercado laboral de analistas de datos, particularmente en lo referente a salarios y habilidades. Antes de cada análisis, es una buena práctica evaluar la utilidad del conjunto de datos. Por esta razón, revisé la disponibilidad de información salarial y de habilidades en las vacantes publicadas en México.

Para salarios:

```sql
SELECT
    salary_rate,
    COUNT(*)
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location LIKE '%Mexico%'
GROUP BY salary_rate
```
Para habilidades:
``` sql
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
```
 de los 10 empleos mejor pagados para analistas de datos en 2023:

- **Salarios similares:** Aunque el empleo mejor pagado ofreció $165,000 USD anuales, 7 de los salarios más altos se concentran alrededor de $111,175 USD, lo que sugiere un techo salarial para el rol.
- **Sesgo hacia CDMX:** 6 de los empleos mejor pagados se ubican en la CDMX; ninguna otra ciudad se repite, posicionando a la capital como el principal mercado para analistas de datos de alto perfil.
- **Fechas de publicación:** De las 10 vacantes mejor pagadas, 6 se publicaron en el primer trimestre del año y la más tardía en julio, lo que sugiere que las mejores oportunidades aparecen temprano y disminuyen hacia el cierre del año.

### 2. Habilidades para los empleos mejor pagados
Para entender qué habilidades requieren estos empleos mejor remunerados, uní las vacantes con los datos de habilidades, lo que permite identificar qué valoran los empleadores en roles de alta compensación.
```sql
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
```

Principales habilidades demandadas en los 10 empleos mejor pagados:

- **SQL** lidera con 7 apariciones.
- **Python** le sigue con 5.
- **Conclusión:** SQL y Python son las habilidades más importantes para acceder a empleos bien pagados. Aunque Looker, R y Excel aparecen con 3 menciones cada una, el resto de habilidades son más específicas de cada puesto.

### 3. Habilidades más demandadas para analistas de datos
Esta consulta permitió identificar las habilidades solicitadas con mayor frecuencia en las vacantes, señalando áreas de alta demanda.
```sql
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
LIMIT 5;
```

Desglose de las habilidades más demandadas en 2023 en México:

- **SQL** y **Excel** siguen siendo fundamentales, destacando la necesidad de habilidades sólidas en procesamiento de datos y hojas de cálculo.
- **Lenguajes de programación** y **herramientas de visualización** como **Python**, **Tableau** y **Power** BI son esenciales, reflejando la creciente importancia del análisis visual y la comunicación de datos.
- **Habilidades globales**: Al eliminar el filtro de ubicación, aparecen las mismas habilidades en el mismo orden, lo que indica que estas competencias fueron las más demandadas a nivel global en 2023, sin que México sea la excepción.

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 1184         |
| Excel    | 1120         |
| Python   | 769          |
| Tableau  | 609          |
| Power BI | 594          |

*Tabla de demanda de las 5 habilidades más solicitadas en vacantes de analista de datos en México*

### 4. Habilidades según salario

Explorar el salario promedio asociado a distintas habilidades permitió identificar cuáles son las mejor pagadas.
```sql
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
```
Resultados principales de las habilidades mejor pagadas:

- **Alta remuneración de lenguajes de programación:** Las tres habilidades mejor pagadas son lenguajes de programación (Scala, Spark y Go), con R también dentro del top 10, incluso por encima de Python.
- **Big Data y Cloud:** Tecnologías como BigQuery, Redshift, Kafka y AWS lideran los salarios, reflejando la alta valoración del procesamiento de datos a gran escala y la nube.
- **SQL:** Destaca nuevamente, apareciendo en prácticamente todo el espectro salarial.

| Skills        | Average Salary ($) |
|---------------|-------------------:|
| scala         |            147,500 |
| spark         |            129,338 |
| go            |            111,202 |
| bigquery      |            111,175 |
| redshift      |            111,175 |
| github        |            111,175 |
| kafka         |            111,175 |
| aws           |            111,175 |
| sql           |            103,801 |
| r             |            103,601 |

*Tabla del salario promedio de las 10 habilidades mejor pagadas para analistas de datos. La repetición de salarios se debe al tamaño reducido de la muestra con salario publicado en México.*

### 5. Habilidades más óptimas para aprender

Combinando demanda y salario, esta consulta identifica las habilidades que ofrecen el mejor balance entre empleabilidad y remuneración.
```sql
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
LIMIT 10;
```

| Skills     | Demand Count | Average Salary ($) |
|------------|--------------|-------------------:|
| excel      | 18           |             78,588 |
| tableau    | 14           |             76,691 |
| power bi   | 12           |             80,933 |
| sql        | 11           |            103,801 |
| python     | 8            |            102,591 |
| sheets     | 8            |             62,758 |
| looker     | 5            |             95,181 |
| r          | 4            |            103.601 |
| aws        | 3            |            111,175 |
| express    | 3            |             54,509 |

*Tabla de las habilidades más óptimas para analistas de datos, ordenadas por salario*

Conclusiones clave sobre las habilidades óptimas en México en 2023:

- **Desfase entre demanda y salario:** Habilidades muy demandadas como Excel, Tableau y Power BI no necesariamente ofrecen los salarios más altos, aunque SQL parece ser la excepción.
- **Lenguajes de programación:** Python y R combinan buena demanda con salarios altos, aunque no aparecen otros lenguajes en el top óptimo.
- **Herramientas de BI y visualización:** Tableau, Looker y Power BI mantienen rangos salariales similares, confirmando su relevancia.

# Lo que aprendí

A lo largo de este proyecto desarrollé habilidades sólidas en SQL:

- **Construcción de consultas complejas:** Uní múltiples tablas, utilicé CTEs (WITH) y diseñé consultas avanzadas para responder preguntas específicas.
- **Agregación de datos:** Consolidé el uso de GROUP BY y funciones agregadas como COUNT() y AVG().
- **Pensamiento crítico aplicado:** Verifiqué la calidad y alcance de los datos antes de cada análisis, evaluando limitaciones como la escasez de salarios publicados.

# Conclusiones
### Hallazgos

1. **Salarios más altos:** Pocas vacantes en México publican salario, lo que limita la calidad del análisis, aunque se observa un techo salarial y un sesgo hacia la CDMX.

2. **Habilidades para empleos mejor pagados:** SQL, Python y habilidades de visualización avanzada son clave.

3. **Habilidades más demandadas:** SQL, Excel y Python dominan tanto en México como a nivel global.

4. **Habilidades mejor pagadas:** Lenguajes de programación específicos y tecnologías de Big Data y Cloud destacan, aunque el bajo número de salarios publicados limita la certeza.

5. **Habilidades óptimas:** SQL sobresale como la habilidad más transversal y estratégica; Excel, Tableau y Power BI siguen siendo indispensables, mientras que Python combina buena demanda y remuneración.

### Reflexión final

Este proyecto fortaleció mis habilidades en SQL y me permitió obtener una visión clara del mercado laboral de analistas de datos en México. Los resultados sirven como guía para priorizar el desarrollo de habilidades y enfocar la búsqueda laboral. En un entorno competitivo, el aprendizaje continuo y la adaptación a nuevas tendencias son esenciales para maximizar el valor profesional en el campo del análisis de datos.