🌎 Read this in: [English](README.md) | [Español](README.es.md)

# Proyecto 2 – Dashboard

## Introducción

El dashboard del primer proyecto permite un análisis muy rico del mercado laboral para científicos, ingenieros y analistas de datos en 2024. No obstante, el exceso de información puede ser contraproducente, pues se desvía la atención de los puntos más importantes. Por esta razón, creé un dashbord más limpio y conciso siguiendo la [Guía de visualización de datos del gobierno de Catalunya](https://atenciociutadana.gencat.cat/web/.content/manuals/visualitzacio_dades/guia_visualitzacio_es.pdf). Además, decidí ampliar el dataset incluyendo información de 2023 y 2024.


### Dashboard File
El dashboard final se puede encontrar aquí: [`Dashboard_2.0.pbix`](Dashboard_2.0.pbix).


## Metodología

La metodología utilizada está divididaa en tres pasos, la estrategia para presentar la información, el manejo de los datos y el diseño.

### Estrategia

Esta primera parte consiste delimitar el análisis, reconocer el tipo de audiencia que se tiene y . Para esto se plantearon las siguientes preguntas.

- **¿Cuál es la temática?:** Mercado laboral de trabajos sobre datos en 2023 y 2024

- ¿Qué se requiere para un trabajo de analista de datos?

- ¿Quiénes publican los las ofertas? ¿Para quiénes están dirigidas?

- ¿Dónde se publican las ofertas?

- ¿Cuándo se publican las ofertas?

- ¿Por qué se publican en esas plataformas? ¿Por qué se publican en esas fechas?

- **¿Cuál es la audiencia objetivo?:** Analistas, ingenieros o científicos de datos en busca de empleo, con conocimientos del tema y experiencia en el uso de datos. Tiempo breve (1 minuto máximo) para consultar la visualización.

Analistas de datos en busca de empleo, con conocimientos del tema y experiencia en el uso de datos, consulta mediante computadora.


Objetivo: El objetivo principal es otorgar información relevante para analistas de datos que buscan trabajo en México.
¿Cómo se quiere ayudar al usuario? Se le quiere proporcionar datos sobre salarios, número de puestos, fechas de ofertas,
locaciones de las ofertas y habilidades requeridas para que pueda tomar decisiones informadas sobre su futuro profesional.

Indicadores: median yearly salary (hourly), most demanded skills, job postingg trends, wfh and dregreee mention.




# Data Jobs Dashboard w/ Power BI
 
![Data Jobs Dashboard Page 1](0_Resources/Images/PowerBI_projects/Project1_Dashboard_Overview.gif)  
 

 

 
## Skills Showcased
 
This project required multiple Power Bi features:
 
-   **Data Transformation (ETL) with Power Query:** Cleaned, shaped, and prepared the raw data for analysis by handling blanks, changing data types, and creating new columns.
 
-   **Implicit Measures:** Formulated measures to derive key insights and KPIs like `Median Yearly Salary` and `Job Count`.
 
-   **Core Charts:** Utilized **Column, Bar, Line,** and **Area Charts** to compare job counts and track trends over time.
 
-   **Geospatial Analysis:** Implimentend a map to visualize the global distribution of jobs.
 
-   **KPI Indicators & Tables:** Used **Cards** to display key metrics and **Tables** to provide precise data.
 
-   **Dashboard Design:** Designed an intuitive and visually appealing layout, exploring both common and uncommon chart types to best tell the data story.
-   **Interactive Reporting:**
    -   **Slicers:** To dynamically filter the report by Job Title.
    -   **Buttons & Bookmarks:** To create a seamless navigation experience.
    -   **Drill-Through:** To navigate from a high-level summary to a contextual, detailed view.
---
 
## Dashboard Overview
 
*This report is split into two distinct pages to provide both a high-level summary and a detailed analysis.*
 
### Page 1: High-Level Market View
 
![Data Jobs Dashboard Page 1](0_Resources/Images/PowerBI_projects/Project1_Dashboard_Page1.gif)  
 
This is a mission control for the data job market. It showcases key KPIs like total job count, median salaries, and top job titles to give you a quick understanding of what's happening in the job market at a glance.
 
### Page 2: Job Title Drill Through
 
![Dashboard de Empleos en Datos Página 2](0_Resources/Images/PowerBI_projects/Project1_Dashboard_Page2.gif)    
 
This is the deep-dive page. From the main dashboard, you can drill through to this view to get specific details for a single job title, including salary ranges, work-from-home stats, top hiring platforms, and a global map of job locations.
 
---
 
## Conclusión
 
This dashboard showcases how Power BI can transform raw job posting data into a powerful tool for career analysis. It allows users to slice, filter, and drill through data to make informed decisions about their career paths.