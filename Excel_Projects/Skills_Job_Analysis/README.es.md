🌎 Read this in: [English](README.md) | [Español](README.es.md)

# Proyecto 2 – Análisis

## Introducción

Este análisis tiene como objetivo mostrar las habilidades más importantes y mejor pagadas en el mercado laboral para ingenieros, científicos y analistas de datos en 2023. Con ello, las personas que buscan empleo cuentan con información clave sobre qué habilidades aprender.

### Preguntas a Analizar

Para comprender el mercado, se analizaron las siguientes preguntas:

1. **¿Tener más habilidades se traduce en un mejor salario?**
2. **¿Cuál es el salario de los empleos de datos en distintas regiones?**
3. **¿Cuáles son las principales habilidades de los profesionales de datos?**
4. **¿Cuál es el salario de las 10 habilidades principales?**

### Habilidades de Excel Utilizadas

Las siguientes habilidades de Excel fueron utilizadas para el análisis:

- **Tablas dinámicas**
- **Gráficos dinámicos**
- **DAX (Data Analysis Expressions)**
- **Power Query**
- **Power Pivot**

### Conjunto de Datos de Empleos en Datos

El conjunto de datos utilizado para este proyecto fue obtenido del curso de Excel de Luke Barousse y contiene información real del mercado laboral de ciencia de datos correspondiente a 2023.

Incluye información detallada sobre:

- **👨‍💼 Puestos de trabajo**
- **💰 Salarios**
- **📍 Ubicaciones**
- **🛠️ Habilidades**

## 1️⃣ ¿Tener más habilidades se traduce en un mejor salario?

### Habilidad: Power Query (ETL)

#### A) Extracción

- Primero utilicé Power Query para extraer los datos originales (`data_salary_all.xlsx`) y crear dos consultas:
    - Una con toda la información de empleos en datos.
    - Otra con el listado de habilidades asociadas a cada ID de empleo.

#### B) Transformación

- Posteriormente transformé cada consulta cambiando tipos de columnas, eliminando columnas innecesarias y limpiando texto para remover caracteres específicos.
    - data_jobs_all  

        ![2_Power_Query1.jpg](/0_Resources/Images/Excel_projects/2_Power_Query1.jpg)

    - data_job_skills  

        ![2_Power_Query2.jpg](/0_Resources/Images/Excel_projects/2_Power_Query2.jpg)

#### C) Carga

- Finalmente, cargué ambas consultas transformadas, estableciendo la base para el análisis posterior.
    - data_jobs_all  

        ![2_Power_Query3.jpg](/0_Resources/Images/Excel_projects/2_Power_Query3.jpg)

    - data_job_skills  

        ![2_Power_Query4.jpg](/0_Resources/Images/Excel_projects/2_Power_Query4.jpg)

### 📊 Análisis

#### Hallazgos

- Existe una **correlación positiva** entre el número de habilidades solicitadas en las vacantes y el salario mediano, especialmente en roles como Senior Data Engineer y Data Scientist.
- Puestos que requieren **menos habilidades**, como Business Analyst, tienden a ofrecer **salarios más bajos**, lo que sugiere que conjuntos de habilidades más especializados tienen mayor valor de mercado.
- Los **roles de ingeniería** suelen requerir más habilidades, aunque esto no siempre se traduce en salarios más altos.

    ![2_Project_Analysis_Chart1.png](/0_Resources/Images/Excel_projects/2_Project_Analysis_Chart1.png)

#### ¿Entonces qué?

- Esta tendencia resalta la importancia de adquirir múltiples habilidades relevantes, especialmente para quienes buscan acceder a roles mejor remunerados.

## 2️⃣ ¿Cuál es el salario de los empleos en datos en distintas regiones?

### Habilidades: Tablas Dinámicas y DAX

#### Tabla dinámica

- Creé una tabla dinámica utilizando el modelo de datos de Power Pivot.
- Moví `job_title_short` al area de filas y `salary_year_avg` al area de valores.
- Agregué una medida nueva para calcular mediana del salario para los trabajos de Estados Unidos.
    ```
    =CALCULATE(
        MEDIAN(data_jobs_all[salary_year_avg]),
        data_jobs_all[job_country] = "United States")
    ```

#### DAX

- To calculate the median year salary I used DAX.

    ```
    Median Salary := MEDIAN(data_jobs_all[salary_year_avg])
    ```

### 📊 Analysis

#### Hallazgos

- Roles como **Senior Data Engineer** y **Data Scientist** presentan salarios medianos más altos tanto en Estados Unidos como a nivel internacional, lo que demuestra la alta demanda global de perfiles avanzados en datos.
- La **brecha salarial** entre empleos en Estados Unidos y fuera de él es particularmente notable en puestos tecnológicos, posiblemente debido a la concentración de industrias tecnológicas en ese país.
    ![2_Project_Analysis_Chart2.png](/0_Resources/Images/Excel_projects/2_Project_Analysis_Chart2.png)

#### ¿Entonces qué?

- Estos insights salariales son clave para la planeación profesional y las negociaciones salariales, ayudando a profesionales y empresas a alinearse con estándares de mercado considerando las variaciones geográficas.

## 3️⃣ ¿Cuáles son las principales habilidades de los profesionales de datos?

### Habilidad: Power Pivot

#### Power Pivot

- Se creó un modelo de datos integrando las tablas `data_jobs_all` y `data_jobs_skills` en un solo modelo.
- Dado que los datos ya habían sido limpiados con Power Query, Power Pivot permitió establecer la relación entre ambas tablas.

#### Modelo de Datos

- Se creó una relación entre las dos tablas utilizando la columna `job_id`.

    ![2_Project_Analysis_Model.png](/0_Resources/Images/Excel_projects/2_Project_Analysis_Model.png)

### 📊 Análisis

#### Hallazgos

- **SQL** y **Python** dominan como las principales habilidades en los empleos relacionados con datos, reflejando su papel fundamental en el procesamiento y análisis de información.
- **Tecnologías emergentes** como AWS y Azure también muestran una presencia relevante, lo que evidencia la transición de la industria hacia servicios en la nube y tecnologías de big data.

    ![2_Project_Analysis_Chart3.png](/0_Resources/Images/Excel_projects/2_Project_Analysis_Chart3.png)

#### ¿Entonces qué?

- Comprender las habilidades más demandadas en la industria ayuda a los profesionales a mantenerse competitivos y orienta programas de formación hacia las tecnologías con mayor impacto.

## 4️⃣ ¿Cuál es el salario de las 10 principales habilidades?

### Habilidad: Gráficos Avanzados (Gráfico Dinámico)

#### Gráfico Dinámico

- Se creó un gráfico dinámico combinado para representar el salario mediano y la probabilidad de una habilidad (%).
    - **Eje primario:** Salario mediano (columnas agrupadas)
    - **Eje secundario:** Probabilidad de la habilidad o relación habilidades/vacantes (línea con marcadores)

### 📊 Análisis

#### Hallazgos

- Los **salarios medianos más altos** están asociados con habilidades como Python, Oracle y SQL, lo que evidencia su relevancia en roles tecnológicos bien remunerados.
- Habilidades como **PowerPoint** y **Word** presentan los salarios medianos y probabilidades más bajas, indicando menor especialización y demanda en sectores de alto salario.
- Aunque **Excel** no es la habilidad mejor pagada, resulta fundamental por su alta probabilidad de aparición en las vacantes.

    ![2_Project_Analysis_Chart4.png](/0_Resources/Images/Excel_projects/2_Project_Analysis_Chart4.png)

### ¿Entonces qué?

- Este análisis destaca la importancia de invertir tiempo en aprender habilidades de alto valor como Python y SQL, claramente vinculadas a mejores salarios, especialmente para quienes buscan maximizar su ingreso en la industria tecnológica.

## Conclusión

Este proyecto revela información valiosa sobre salarios y habilidades en el mercado laboral de datos a nivel global. Permite explorar la relación entre puestos, ubicaciones y habilidades clave utilizando principalmente Power Query y tablas y gráficos dinámicos. Los resultados muestran una correlación entre contar con múltiples habilidades y obtener salarios más altos, la tendencia de los data engineers a requerir más habilidades y la importancia de Python, SQL, Excel y tecnologías en la nube en 2023.