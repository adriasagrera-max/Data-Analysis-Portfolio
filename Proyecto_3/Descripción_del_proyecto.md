# ⚽ Scouting Dashboard: FCBARCELONA Femení

<p align="center">
  <strong>Página 1: Filtros y Jugadoras objetivo </strong><br>
  <img width="850" alt="Vista General" src="https://github.com/user-attachments/assets/6221f2c2-f6cf-452f-acfe-902b5a0847d1" />
</p>

<p align="center">
  <strong>Página 2: Atributos destacables y gráfico de radar </strong><br>
  <img width="850" alt="Análisis Detallado" src="https://github.com/user-attachments/assets/7cd95a5d-3535-4a23-a551-4fb64aad5c91" />
</p>

<p align="center">
  <strong>Modelo de estrella</strong><br>
  <img width="470" alt="Vista previa del Dashboard" src="https://github.com/user-attachments/assets/4281826a-a84c-46c9-9d92-3196bd950b4e" />
</p>

## 📝 Descripción del Proyecto

Este proyecto es una solución integral de análisis de datos (End-to-End) diseñada como un caso de uso realista para el área de *scouting* del **FC Barcelona Femení**. Su objetivo principal es evaluar, comparar y destacar perfiles de jugadoras de las principales ligas del mundo para facilitar la toma de decisiones estratégicas en el mercado de fichajes.

Tradicionalmente, los ojeadores y responsables deportivos con perfiles menos técnicos dependían de múltiples consultas al departamento de IT para extraer cruces de datos o aplicar filtros específicos. Esta dinámica generaba cuellos de botella y ralentizaba el análisis de mercado. Con este dashboard, el objetivo es democratizar el acceso al dato. Ahora, cualquier usuario de la secretaría técnica puede interactuar de forma autónoma con la información, aplicar filtros complejos y obtener *insights* visuales en cuestión de segundos, ahorrando un tiempo valiosísimo tanto al área deportiva como al equipo tecnológico.

A nivel técnico, el proyecto cuenta con datos públicos extraídos de Kaggle. Mediante un proceso ETL desarrollado en Python, me encargué de limpiar y estructurar la información bruta hasta consolidar un *dataset* final de alta calidad con aproximadamente 1.600 registros útiles de jugadoras de élite. Posteriormente, estos datos se integraron en Power BI bajo una arquitectura de modelo en estrella. Este diseño centraliza las métricas y distribuye los atributos en tablas dimensionales, garantizando un rendimiento óptimo y escalable.

## 🛠️ Tecnologías Utilizadas

* **Python:** Para el proceso de Extracción, Transformación y Carga (ETL). 
* **Power Query (M):** Para el modelado final de datos, creación de columnas calculadas y relaciones de tablas dentro del entorno de BI.
* **R:** Para la programación de visualizaciones avanzadas personalizadas, específicamente un gráfico de radar dinámico para comparar hasta 5 jugadoras simultáneamente.
* **Power BI:** Como herramienta principal para el diseño del dashboard interactivo y la experiencia de usuario (UX/UI).



## 📂 Recursos
* [Ver Dashboard (pbix)](Dashboard_FCB_scouting.pbix)
* [Ver Script: gráfico radar (R)](Gráfico_radar.R)
* [Ver Script: Proceso ETL (Python)](Proceso_ETL_.ipynb)





