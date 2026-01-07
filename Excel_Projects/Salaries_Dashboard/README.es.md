🌎 Read this in: [English](README.md) | [Español](README.es.md)

# Dashboard de Salarios en Excel

![1_Salary_Dashboard.png](/Resources/Images/Excel_projects/1_Salaries_Calculator.gif)

## Introducción

Este dashboard de salarios para empleos de datos muestra información sobre el mercado global de empleos en datos en 2023. Su propósito es ofrecer un contexto general para personas que buscan empleo en el área de datos. Aunque los datos están centrados en Estados Unidos, permiten explorar vacantes, salarios medianos y portales de reclutamiento a nivel global.

### Archivo del Dashboard
Mi dashboard final se encuentra en [Data_Jobs_Dashboard.xlsx](Data_Jobs_Dashboard.xlsx).

### Conjunto de Datos de Empleos en Datos

El conjunto de datos utilizado para este proyecto contiene información real de empleos en análisis, ingeniería y ciencia de datos correspondiente a 2023. Incluye información detallada sobre:

- **👨‍💼 Puestos de trabajo**
- **💰 Salarios**
- **📍 Ubicaciones**
- **🛠️ Habilidades**

### Habilidades de Excel Utilizadas

Las siguientes habilidades de Excel fueron utilizadas para el análisis:

- **📉 Gráficos**
- **🧮 Fórmulas y funciones**

## Construcción del Dashboard

### 📉 Gráficos

#### Salarios de Empleos en Ciencia de Datos – Gráfica de Barras

<img src="/Resources/Images/Excel_projects/1_Salaries_Dashboard_Chart.JPG" width="850" height="550" alt="Gráfica de salarios del dashboard">

- **Funciones de Excel:** Uso de gráficos de barras con valores de salario formateados.
- **Decisión de diseño:** Gráfica de barras horizontales para facilitar la comparación visual de la mediana de salarios.
- **Organización de datos:** Puestos ordenados de forma descendente por salario para mejorar la legibilidad.
- **Hallazgos:** Permite identificar rápidamente tendencias salariales, mostrando que los roles Senior y de Ingeniería son mejor pagados que los roles de Analista.

#### 🗺️ Salarios Medianos por País – Mapa

![1_Salary_Dashboard_Chart2.png](/Resources/Images/Excel_projects/1_Salary_Dashboard_Country_Map.gif)

- **Funciones de Excel:** Uso del gráfico de mapa de Excel para representar salarios medianos a nivel global.
- **Decisión de diseño:** Mapa codificado por colores para diferenciar visualmente los niveles salariales entre regiones.
- **Representación de datos:** Salario mediano graficado para cada país con datos disponibles.
- **Hallazgos:** Permite entender rápidamente las disparidades salariales globales e identificar regiones con salarios altos y bajos.

### Fórmulas y Funciones

#### Salario Mediano por Puesto

```
=MEDIAN(
IF(
    (jobs[job_title_short]=A2)*
    (jobs[job_country]=country)*
    (ISNUMBER(SEARCH(type,jobs[job_schedule_type])))*
    (jobs[salary_year_avg]<>0),
    jobs[salary_year_avg]
)
)
```

- **Filtrado multicriterio:** Verifica el puesto, país, tipo de jornada y excluye salarios en blanco.
- **Fórmula matricial:** Utiliza la función `MEDIAN()` con una instrucción `IF()` anidada para analizar un arreglo.
- **Insights personalizados:** Proporciona información salarial específica por puesto, región y tipo de jornada.
- **Propósito de la fórmula:** Esta fórmula alimenta la tabla inferior, devolviendo el salario mediano según el puesto, país y tipo seleccionados.

*Tabla de Fondo:*

![1_Salary_Dashboard_Screenshot1.png](/Resources/Images/Excel_projects/1_Salary_Dashboard_Table1.png) 

📉 Implementación en el Dashboard

<img src="/Resources/Images/Excel_projects/1_Salary_Dashboard_Job_Title.png" width="400" height="500" alt="Título del dashboard de salarios">

#### Conteo por Tipo de Jornada Laboral

```
=FILTER(J2#,(NOT(ISNUMBER(SEARCH("and",J2#))+ISNUMBER(SEARCH(",",J2#))))*(J2#<>0))
```
- **Generación de lista única:** Esta fórmula utiliza la función `FILTER()` para excluir entradas que contienen "and" o comas, además de omitir valores cero.
- **Propósito de la fórmula:** Esta fórmula alimenta la tabla inferior, proporcionando una lista única de tipos de jornada laboral.

*Tabla de Fondo:*

![1_Salary_Dashboard_Type.png](/Resources/Images/Excel_projects/1_Salary_Dashboard_Table2.png)

📉 Implementación en el Dashboard

<img src="/Resources/Images/Excel_projects/1_Salary_Dashboard_Type.png" width="350" height="500" alt="Tipo de jornada en el dashboard">

## Conclusión

Algunos de los principales hallazgos de este dashboard son que los analistas ganan menos que los científicos de datos o ingenieros, que el salario mediano de un Data Analyst tiende a ser de alrededor de $90,000 dólares anuales y que Indeed es un portal de empleo muy popular para trabajos relacionados con datos. Desafortunadamente, el conjunto de datos no cuenta con información suficiente para generar conclusiones de calidad sobre el mercado en México.

