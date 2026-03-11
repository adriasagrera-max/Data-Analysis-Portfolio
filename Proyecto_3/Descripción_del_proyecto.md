# ⚽ Scouting Dashboard: FCBARCELONA scouting
<p align="center">
<img width="1275" height="714" alt="image" src="https://github.com/user-attachments/assets/6221f2c2-f6cf-452f-acfe-902b5a0847d1" />
</p>

<p align="center">
<img width="1274" height="713" alt="image" src="https://github.com/user-attachments/assets/7cd95a5d-3535-4a23-a551-4fb64aad5c91" />
</p>

<p align="center">
  <img width="705" height="575" alt="Vista previa del Dashboard" src="https://github.com/user-attachments/assets/4281826a-a84c-46c9-9d92-3196bd950b4e" />
</p>

## 📝 Descripción del Proyecto

Este proyecto es una solución integral de análisis de datos (End-to-End) orientada al **scouting deportivo**. Su objetivo principal es evaluar, comparar y destacar perfiles de jugadoras ("En el Radar") para facilitar la toma de decisiones en posibles incorporaciones y análisis de mercado.

El proyecto abarca desde la extracción y limpieza de datos en crudo, hasta la visualización interactiva avanzada, combinando múltiples tecnologías para obtener el mejor rendimiento y diseño posible.

## 🛠️ Tecnologías Utilizadas

* **Python:** Para el proceso de Extracción, Transformación y Carga (ETL). Limpieza de datos atípicos y preparación de datasets.
* **Power Query (M):** Para el modelado final de datos, creación de columnas calculadas y relaciones de tablas dentro del entorno de BI.
* **R (fmsb):** Para la programación de visualizaciones avanzadas personalizadas, específicamente un gráfico de radar dinámico para comparar hasta 5 jugadoras simultáneamente.
* **Power BI:** Como herramienta principal para el diseño del dashboard interactivo y la experiencia de usuario (UX/UI).

## ⚙️ Arquitectura y Proceso

1. **ETL (Python):** Los datos en crudo se procesan mediante un script de Python (`etl_process.py`), donde se manejan valores nulos, se normalizan métricas (0-100) y se exportan listos para el consumo.
2. **Modelado (Power Query):** Dentro de Power BI, se utiliza lenguaje M para afinar el modelo de datos, establecer relaciones de cardinalidad y crear medidas DAX.
3. **Visualización Customizada (R):** Debido a las limitaciones de los gráficos estándar, se integró un script de R directamente en Power BI para renderizar un gráfico de radar paramétrico con transparencias y leyenda dinámica.

## 📂 Estructura del Repositorio

\`\`\`text
scouting-dashboard/
│
├── data/                   # (Ignorado en GitHub si pesa mucho) Datasets limpios
├── etl/                    # Scripts de procesamiento
│   ├── requirements.txt    # Librerías de Python requeridas
│   └── etl_process.py      # Script principal de limpieza de datos
│
├── power_bi/               # Archivos del Dashboard
│   └── scouting_dashboard.pbix
│
├── scripts/                # Código incrustado exportado para fácil lectura
│   ├── power_query_steps.m # Fórmulas clave en lenguaje M
│   └── radar_chart.R       # Código fuente del gráfico de R
│
└── README.md               # Documentación del proyecto
\`\`\`



