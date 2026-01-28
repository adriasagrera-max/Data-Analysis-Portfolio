
Clientes <- Var_Discreta_Adq_Bicicleta 

#### Análisis exploratorio ####

str(Clientes)

summary(clientes)

colSums(is.na(Clientes))

clientes_variables_numericas <- Clientes[sapply(Clientes,is.numeric)]


# Creamos y graficamos una matriz de correlación

correlaciones <- cor(clientes_variables_numericas, use ="complete.obs" , method= "pearson")

print(correlaciones)

library(ggplot2)
library(reshape2)

melted_cor <- melt(correlaciones)

ggplot(melted_cor, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(
    low = "blue", high = "red", mid = "white",
    midpoint = 0, limit = c(-1, 1)
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    plot.title = element_text(hjust = 0.5, face = "bold")
  ) +
  labs(
    title = "Matriz de correlación",
    fill = "Correlación"
  )


# Gráfico número 1

library(ggplot2)
library(dplyr)
library(scales)

df_age <- Clientes %>%
  filter(!is.na(Age), !is.na(TotalAmount)) %>%
  mutate(AgeGroup = cut(
    Age,
    breaks = seq(0, 120, by = 10),
    right = FALSE,
    include.lowest = TRUE
  )) %>%
  group_by(AgeGroup) %>%
  summarise(
    TotalAmount = mean(TotalAmount, na.rm = TRUE),
    .groups = "drop"
  )

ggplot(df_age, aes(x = AgeGroup, y = TotalAmount)) +
  geom_col() +
  theme_minimal() +
  labs(
    title = "Importe medio por rango de edad",
    x = "Rango de edad",
    y = "Importe medio (€)"
  ) +
  scale_y_continuous(
    labels = label_number(
      suffix = " €",
      big.mark = ".",
      decimal.mark = ","
    )
  )


# Gráfico número 2

df_country <- Clientes %>%
  filter(!is.na(Country), !is.na(TotalAmount)) %>%
  mutate(
    Country = case_when(
      Country %in% c("Northwest", "Southwest", "Northeast", "Southeast", "Central") ~ "USA",
      TRUE ~ Country
    )
  ) %>%
  group_by(Country) %>%
  summarise(
    TotalAmount = mean(TotalAmount, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(TotalAmount)) %>%
  mutate(Country = factor(Country, levels = Country))


ggplot(df_country, aes(x = Country, y = TotalAmount)) +
  geom_col(fill = "#2c7fb8") +
  theme_minimal() +
  labs(
    title = "Importe medio por país",
    x = "País",
    y = "Importe medio (€)"
  ) +
  scale_y_continuous(
    labels = label_number(
      suffix = " €",
      big.mark = ".",
      decimal.mark = ","
    )
  ) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(face = "bold")
  )


# Gráfico número 3

df_country_count <- Clientes %>%
  filter(!is.na(Country)) %>%
  mutate(
    Country = case_when(
      Country %in% c("Northwest", "Southwest", "Northeast", "Central", "Southeast") ~ "USA",
      TRUE ~ Country
    )
  ) %>%
  group_by(Country) %>%
  summarise(
    NumClientes = n(),
    .groups = "drop"
  ) %>%
  arrange(desc(NumClientes)) %>%
  mutate(Country = factor(Country, levels = Country))


ggplot(df_country_count, aes(x = Country, y = NumClientes)) +
  geom_col(fill = "#2ca25f") +
  theme_minimal() +
  labs(
    title = "Número de clientes por país",
    x = "País",
    y = "Número de clientes"
  ) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(face = "bold")
  )


# Gráfico número 4

library(ggridges)

# Reagrupar regiones de USA
Clientes_plot <- Clientes %>%
  mutate(
    Country = case_when(
      Country %in% c("Northwest", "Southeast", "Northeast", "Central", "Southwest") ~ "USA",
      TRUE ~ Country
    )
  )

ggplot(Clientes_plot, aes(x = Age, y = Country, fill = Country)) +
  geom_density_ridges(alpha = 0.7) +
  theme_minimal() +
  labs(
    title = "Distribución número de clientes por edad y país",
    x = "Edad",
    y = "País"
  ) +
  scale_x_continuous(labels = scales::label_number(big.mark = ".", decimal.mark = ",")) +
  theme(
    plot.title = element_text(face = "bold"),
    legend.position = "none"  # ocultar leyenda si quieres
  )

# Gráfico número 5

      # Reagrupar regiones de USA
Clientes_plot <- Clientes %>%
  mutate(
    Country = case_when(
      Country %in% c("Northwest", "Southeast", "Northeast", "Central") ~ "USA",
      TRUE ~ Country
    )
  )

ggplot(Clientes_plot, aes(x = Country, y = Age, fill = Country)) +
  geom_boxplot(alpha = 0.7, outlier.color = "red", outlier.shape = 16) +
  theme_minimal() +
  labs(
    title = "Distribución de la edad de los clientes por país/región",
    x = "País/Región",
    y = "Edad"
  ) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(face = "bold"),
    legend.position = "none"
  )

# Gráfico número 6

entrenamiento %>%
  mutate(BikePurchase = factor(BikePurchase, levels = c(0, 1), labels = c("No Compró", "Compró")),
         YearlyIncome = as.factor(YearlyIncome)) %>%
  
  ggplot(aes(x = YearlyIncome, fill = BikePurchase)) +
  geom_bar(position = "fill") + 
  scale_y_continuous(labels = scales::percent) +
  scale_fill_manual(values = c("No Compró" = "#C62828", "Compró" = "#2E7D32")) +
  labs(
    title = "Proporción de Compras por Rango de Ingresos",
    x = "Rango de Ingresos Anuales",
    y = "Porcentaje (Base 100)",
    fill = "Resultado"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 20, hjust = 1)) 

# Gráfico número 7

library(scales)
library(forcats) 

entrenamiento %>%
  mutate(
    AgeGroup = cut(Age, 
                   breaks = seq(floor(min(Age, na.rm=T)/5)*5, 
                                ceiling(max(Age, na.rm=T)/5)*5 + 5, 
                                by = 5), 
                   right = FALSE),
    AgeGroup = fct_rev(AgeGroup),
    BikePurchase = factor(BikePurchase, levels = c(0, 1), labels = c("No Compró", "Compró"))
  ) %>%
  filter(!is.na(AgeGroup)) %>%
  

  ggplot(aes(y = AgeGroup, fill = BikePurchase)) +
  geom_bar(position = "fill", color = "white", linewidth = 0.2) + 
  scale_x_continuous(labels = percent) +
  scale_fill_manual(values = c("No Compró" = "#C62828", "Compró" = "#2E7D32")) +
  labs(
    title = "Proporción de Compras por Rango de Edad",
    x = "Porcentaje de Clientes",
    y = "Rango de Edad",
    fill = "Resultado"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    legend.position = "bottom"
  )

#### Modelo regresión logística ####

library(caTools)

# dividimos conjunto de datos en dos subconjuntos: entrenamiento 80%, validacion 20%
division <- sample.split(Clientes$BikePurchase, SplitRatio = 0.8)
print(division)

entrenamiento <- subset(Clientes, division == TRUE)
validacion <- subset(Clientes, division == FALSE)

# comparamos si todos los subconjuntos estan balanceados de igual forma
prop.table(table(Clientes$BikePurchase))
prop.table(table(entrenamiento$BikePurchase))
prop.table(table(validacion$BikePurchase))

    # todos tienen porcentajes similares

regresionlogistica_ent1 <- glm(BikePurchase ~ 
                                 TotalAmount + 
                                 as.factor(Country) + 
                                 Age + 
                                 as.factor(Gender) + 
                                 as.factor(MaritalStatus) + 
                                 as.factor(YearlyIncome) + 
                                 as.factor(TotalChildren) + 
                                 as.factor(Education) + 
                                 as.factor(Occupation) + 
                                 as.factor(HomeOwnerFlag) + 
                                 as.factor(NumberCarsOwned), 
                               data = entrenamiento, 
                               family = "binomial")

summary(regresionlogistica_ent1)


# volvemos a crear un modelo sin las variables TotalAmount, Gender y HomeOwnerFlag

regresionlogistica_ent2 <- glm(BikePurchase ~ 
                                
                                 as.factor(Country) + 
                                 Age + 
                                
                                 as.factor(MaritalStatus) + 
                                 as.factor(YearlyIncome) + 
                                 as.factor(TotalChildren) + 
                                 as.factor(Education) + 
                                 as.factor(Occupation) + 
                                 
                                 as.factor(NumberCarsOwned), 
                               data = entrenamiento, 
                               family = "binomial")

summary(regresionlogistica_ent2)

# analizamos posibles problemas de multicolinealidad

library(car)

vif(regresionlogistica_ent2)

# analizamos la bondad del ajuste 

install.packages("ResourceSelection")
library(ResourceSelection)

hoslem.test(entrenamiento$BikePurchase, fitted(regresionlogistica_ent2))

#analizamos la distáncia de Hook

plot(regresionlogistica_ent2, which = 4) 

#vemos como funciona el modelo con los nuevos datos

library(caret)

# realizamos predicción
prediccion_validacion <- predict(regresionlogistica_ent2, newdata = validacion, type = "response")
prediccion_validacion_cod <- ifelse(prediccion_validacion > 0.5, 1, 0)

# realizamos la matriz de confusión
cm <- confusionMatrix(as.factor(validacion$BikePurchase), as.factor(prediccion_validacion_cod))

# Convertir la matriz a formato largo
cm_df <- as.data.frame(cm$table)
colnames(cm_df) <- c("Predicted", "Actual", "Count")

# Gráfico 
ggplot(cm_df, aes(x = Actual, y = Predicted, fill = Count)) +
  geom_tile(color = "white") +
  geom_text(aes(label = Count), color = "black", size = 6) +
  scale_fill_gradient(low = "white", high = "#2c7fb8") +
  theme_minimal() +
  labs(
    title = "Matriz de confusión",
    x = "Valor Real",
    y = "Predicción"
  ) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text = element_text(size = 12)
  )

#calculamos el accuracy base 

prop.table(table(entrenamiento$BikePurchase))


#### Modelo Árbol de decision ####

library(rpart)
library(rpart.plot)

modeloarbol <- rpart(as.factor(BikePurchase) ~
                       as.factor(Country) +
                       Age +
                       as.factor(MaritalStatus) +
                       as.factor(YearlyIncome) +
                       as.factor(TotalChildren) +
                       as.factor(Education) +
                       as.factor(Occupation) +
                       as.factor(HomeOwnerFlag) +
                       as.factor(NumberCarsOwned),
                     data = entrenamiento, method = "class")


rpart.plot(modeloarbol)
summary(modeloarbol)

# realizamos prediccion datos entrenamiento
prediccionarbol <- predict(modeloarbol, type = "class")
View(prediccionarbol)
print(prediccionarbol)


prediccion_prob <- predict(modeloarbol, newdata = validacion, type = "prob")


prediccion_validacion_cod <- ifelse(prediccion_prob[,2] > 0.5, 1, 0)


confusionMatrix(as.factor(prediccion_validacion_cod), 
                      as.factor(validacion$BikePurchase))


cm_df <- as.data.frame(cm$table)
colnames(cm_df) <- c("Prediction", "Reference", "Count")


library(ggplot2)
ggplot(cm_df, aes(x = Reference, y = Prediction, fill = Count)) +
  geom_tile(color = "white") +
  geom_text(aes(label = Count), color = "black", size = 6) +
  scale_fill_gradient(low = "white", high = "#2c7fb8") +
  theme_minimal() +
  labs(
    title = "Matriz de Confusión: Árbol de Decisión",
    subtitle = paste("Accuracy:", round(cm$overall['Accuracy'], 4)),
    x = "Valor Real",
    y = "Predicción"
  ) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    axis.text = element_text(size = 12)
  )

# Calculamos el Accuracy Base 
prop.table(table(entrenamiento$BikePurchase))









#### Clusterización K-means ####

library(ggplot2)
library(factoextra)

unique(Clientes$Education)

Clientes <- Clientes %>%
  mutate(Education_Num = case_match(Education,
                                    "Partial High School" ~ 1,
                                    "High School"         ~ 2,
                                    "Partial College"     ~ 3,
                                    "Bachelors"           ~ 4,
                                    "Graduate Degree"     ~ 5,
                                    .default = NA 
  ))

unique(Clientes$Occupation)

Clientes <- Clientes %>%
  mutate(Occupation_Num = case_match(Occupation,
                                     "Manual"         ~ 1,
                                     "Skilled Manual" ~ 2,
                                     "Clerical"       ~ 3,
                                     "Professional"   ~ 4,
                                     "Management"     ~ 5,
                                     .default = NA
  ))

unique(Clientes$YearlyIncome)

Clientes <- Clientes %>%
  mutate(YearlyIncome_Num = case_match(YearlyIncome,
                                       "0-25000"             ~ 1,
                                       "25001-50000"         ~ 2,
                                       "50001-75000"         ~ 3,
                                       "75001-100000"        ~ 4,
                                       "greater than 100000" ~ 5,
                                       .default = NA
  ))





clientes_variables_numericas <- Clientes[,c(1,2,11,15,18,19,20,21,22)]

clientes_num_norm <- scale(clientes_variables_numericas)

set.seed(123) 
muestra_codo <- clientes_num_norm[sample(1:nrow(clientes_num_norm), 4000), ]

fviz_nbclust(muestra_codo, kmeans, method = "wss")

resultado_km <- kmeans(clientes_num_norm, 5)

Clientes$Cluster <- as.factor(resultado_km$cluster)

resultado_km

#grafico

library(ggplot2)
library(scales) 

ggplot(Clientes, aes(x = Cluster)) +
  
  geom_bar(fill = "#2E7D32", color = "white", linewidth = 0.2) +
  
  
  geom_text(stat = 'count', 
            aes(label = after_stat(paste0(round(count/sum(count)*100, 1), "%"))), 
            vjust = -0.5, 
            size = 3.5) +
  
  labs(
    title = "Peso Relativo de cada Cluster",
    subtitle = paste("Base total= 18.484 clientes"),
    x = "Clúster",
    y = "Número de clientes"
  ) +
  
  
  theme_minimal() +
  theme(
    legend.position = "none", 
    plot.title = element_text(face = "bold", size = 14),
    panel.grid.major.x = element_blank() 
  )

#grafico número 1

ggplot(Clientes, aes(x = Cluster, y = TotalAmount)) +
  geom_boxplot(fill = "#2E7D32", color = "#1B5E20", alpha = 0.7, outlier.colour = "red", outlier.shape = 1) +
  coord_cartesian(ylim = c(0, 12000))+
  labs(
    title = "Distribución de Gasto (TotalAmount) por Cluster",
    subtitle = "Comparativa de dispersión y medianas de gasto",
    x = "Segmento (Cluster)",
    y = "Monto Total de Gasto"
  ) +
  
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    panel.grid.minor = element_blank()
  )

#gráfico número 2

library(dplyr)
library(ggplot2)

resumen_compra <- Clientes %>%
  group_by(Cluster) %>%
  summarise(Porcentaje = mean(BikePurchase) * 100)


ggplot(resumen_compra, aes(x = Cluster, y = Porcentaje)) +
  geom_bar(stat = "identity", fill = "#2E7D32", color = "white") +
  geom_text(aes(label = paste0(round(Porcentaje, 1), "%")), 
            vjust = -0.5, fontface = "bold") +
  coord_cartesian(ylim = c(0, 110)) +
  labs(
    title = "Tasa de Conversión (Compra) por Cluster",
    subtitle = "Porcentaje de clientes que adquirieron una bicicleta en cada segmento",
    x = "Segmento (Cluster)",
    y = "Porcentaje de Compra (%)"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold", size = 14))

# resumen estadístico de la variable TotalAmount

resumen_completo <- Clientes %>%
  group_by(Cluster) %>%
  summarize(
    Cantidad = n(),
    Media = mean(TotalAmount, na.rm = TRUE),
    Mediana = median(TotalAmount, na.rm = TRUE),
    Desv_Est = sd(TotalAmount, na.rm = TRUE)
  )

print(resumen_completo)
