# Consultas a la base de datos Adventure Works 
[
](https://www.google.com/url?sa=t&source=web&rct=j&url=https%3A%2F%2Ftimextender.teachable.com%2Fcourses%2F828772%2Flectures%2F23013318&ved=0CBYQjRxqFwoTCLDy_bKOmpIDFQAAAAAdAAAAABAI&opi=89978449)<img width="3572" height="2213" alt="image" src="https://github.com/user-attachments/assets/634598af-6e87-490a-bd11-cc5c27598e77" />

## Project Overview:
Supongamos que somos analistas de Business Intelligence de la empresa, y se nos solicita la realización de diferentes análisis para la toma de decisiones. Actualmente, los datos se encuentran en la base de datos OLTP (Producción) y nuestro objetivo es Extraer, Transformar y Cargar los datos en las herramientas software de destino, para realizar modelos estadísticos de series temporales, regresión, clasificación, etc…

## Consultas a realizar

1. "Generar un dataset de series temporales (2011-2014) que unifique las ventas globales diarias con el desglose por regiones (EEUU, Europa y Pacífico), utilizando subconsultas vinculadas por fecha para consolidar la información en una sola consulta base."


## Data Dictionary:

| Variable        | Description                                                |
|-----------------|------------------------------------------------------------|
| make            | Machine firm or car manufacturer                           |
| model           | Machine model                                              |
| price USD       | Price in USD (target variable)                             |
| year            | Year of production                                         |
| condition       | Represents the condition at the sale moment                |
| mileage         | Mileage in kilometers                                      |
| fuel type       | Type of fuel (electro, petrol, diesel)                     |
| volume(cm3)     | Volume of the engine in cubic centimeters                  |
| color           | Color of the car                                           |
| transmission    | Type of transmission                                       |
| drive unit      | Drive unit                                                 |
| segment         | Segment of the car                                         |

## Impact:
Through exploratory data analysis, several key insights were discovered. Notably, there was a significant increase in car prices in Belarus after the year 2000. Cars running on petrol with automatic transmission tend to have higher prices compared to diesel cars with manual transmission. Electric cars stand out as notably more expensive than other car types. Furthermore, cars with all-wheel drive exhibit the highest prices among all drive units, and speciality segment cars command the highest prices among all segments, followed by luxury European, American, and Asian car segments.

For the predictive modeling, a decision tree regressor was employed to forecast car prices. This model achieved an impressive accuracy rate of 85.29%. The most influential features in predicting car prices were identified as the year of production and the engine's volume in cubic centimeters.

This project offers valuable insights for both car buyers and sellers in Belarus, helping them make informed decisions in a dynamic automotive market.
