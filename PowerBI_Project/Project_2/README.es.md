🌎 Read this in: [English](README.md) | [Español](README.es.md)

# Proyecto 2 – Dashboard

![Data Dashboard Page](/0_Resources/Images/PowerBI_projects/Project2_Dashboard1.JPG)

## Introducción

El dashboard del primer proyecto permite un análisis muy rico del mercado laboral para científicos, ingenieros y analistas de datos en 2024. No obstante, el exceso de información puede ser contraproducente, pues se desvía la atención de los puntos más importantes. Por esta razón, creé un dashboard más limpio y conciso siguiendo la [Guía de visualización de datos del gobierno de Catalunya](https://atenciociutadana.gencat.cat/web/.content/manuals/visualitzacio_dades/guia_visualitzacio_es.pdf). Además, decidí ampliar el data set incluyendo información de 2023 y 2024.


### Dashboard File
El dashboard final se puede encontrar aquí: [`Dashboard_2.0.pbix`](Dashboard_2.0.pbix).


## Metodología

La metodología utilizada está dividida en tres pasos, la estrategia para presentar la información, el manejo de los datos y el diseño.

### Estrategia

Esta primera parte consiste delimitar el análisis, reconocer el tipo de audiencia que se tiene y aclarar el objetivo informativo:

- **Delimitación:** La temática es el mercado laboral de trabajos sobre datos en 2023 y 2024. Ahora, hay muchas aproximaciones posibles (exploratorios, analíticos y explicativos). Por eso es importante plantear algunas preguntas (qué, cómo, cuándo, dónde, por qué) que delimiten la investigación, en este caso son:

    - ¿Qué se requiere para un trabajo de analista, ingeniero o científico de datos?

    - ¿Qué cualidades tienen estas ofertas (salario, trabajo remoto, etc.)?

    - ¿Cuándo se publican las ofertas?

    - ¿Para quiénes están dirigidas las ofertas?

- **¿Cuál es la audiencia objetivo?:** Analistas, ingenieros o científicos de datos que buscan tener un panorama sobre el mercado laboral. Tiempo breve (1 minuto máximo) para consultar la visualización.

- **El objetivo principal** es otorgar información relevante (salarios, habilidades demandadas, tendencias de las publicaciones de empleo) para  analistas, ingenieros o científicos de datos junior que buscan trabajo en el área de datos.

- Para cumplir este objetivo, se han elegido los siguientes **indicadores:** 
    - El número de empleos 
    - La mediana del salario anual promedio
    - El promedio de habilidades demandadas por cada rol 
    - Las habilidades más demandadas 
    - Las tendencias de publicaciones de empleo
    - El porcentaje de trabajos remotos  
    - El porcentaje de ofertas que mencionan un título.
    
    
Con esta estrategia se puede lograr un dashboard simple, con información concisa,relevante y sin ruido visual.

## Manejo de los datos

En este caso, se cuenta con data sets separados para los años 2023 y 2024. Cada uno cuenta con cuatro tablas y tiene sus identificadores propios. Esto significa que no se puede hacer una simple unión de las tablas porque los identificadores se repetirían. Por lo tanto, se tuvo que hacer limpieza y un nuevo modelado en Power Query

### Power Query

**1. Cargar y preparar las tablas** 

Primero se cargaron las tablas y se les dió una pequeña limpieza. Se crearon nuevas columnas "*X*_id_global"
cuyo contenido eran los indentificadores originales para poder unir las tablas.

![Power Query Applied Steps 1](/0_Resources/Images/PowerBI_projects/Project2_Power_Query1.JPG)
*La tabla principal del data set 2023*

**2. Crear nuevos indicadores** 

No obstante, esta estrategia no sirve para todos los identificadores. Por ejemplo, "skill_id" tiene el propósito de representar habilidades de la siguiente manera: 

| Skills_id     | skill_name        |
|---------------|------------------:|
| 1             |               sql |
| 2             |            Python |
| 3             |                 R |

Cómo las skills_id no coinciden en ambos años, pero el nombre de las habilidades se mantiene, se debe crear otro identificador ("skill_key") para evitar mezclar o perder información. Esto requirió una serie de cuidadosos merge para obtener las tablas finales. Lamentablemente, por como funciona merge en Power Query, se deben mantener tablas residuales que ralentizan el procesamiento de datos (aunque no la visualización), algo que con SQL se podría evitar.

![Power Query Applied Steps2](/0_Resources/Images/PowerBI_projects/Project2_Power_Query3.JPG)


![Power Query Tables](/0_Resources/Images/PowerBI_projects/Project2_Power_Query2.JPG)
*"job_postings_fact" quedó con 1,266,581 filas totales.*

### Measures & DAX

Ya por último, se creó una serie de de *measures* utilizando DAX para ayudar a representar varios de los indicadores por utilizar en el dashboard.

![Measures](/0_Resources/Images/PowerBI_projects/Project2_Dashboard2.JPG)

![Data Model](/0_Resources/Images/PowerBI_projects/Project2_Dashboard3.JPG) *El modelado final*



## Diseño

Por último se diseño el dashboard teniendo en cuenta:
- Las mejores visualizaciones para representar cada indicador (line chart, bar chart, donut chart).
- La importancia de los indicadores y cómo solemos mirar información (de izquierda a derecha y de arriba a abajo).
- Sencillez gráfica y colores adecuados.

![Data Dashboard GIF](0_Resources/Images/PowerBI_projects/Project2_Dashboard.gif)  
  
---
 
## Conclusión
 
Gracias a un replanteamiento estratégico sobre la visualización de datos, se generó un dashboard revisado que permite obtener información relevante y de manera sencilla sobre el mercado laboral de datos en 2023 y 2024, incluyendo indicadores claves como los salarios, las habilidades más demandadas, las tendencias de publicación de empleo y el porcentaje de trabajos remotos. Así, se evita el ruido de métricas menos importantes que podían impedir los objetivos de información en el primer dashboard.

Para esto, se profundizó en las habilidades de:
- Estrategia de visualización de datos
- Power Query
- Measures & DAX
- Diseño