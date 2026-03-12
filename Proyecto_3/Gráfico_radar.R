# El código siguiente, que crea un dataframe y quita las filas duplicadas, siempre se ejecuta y actúa como un preámbulo del script: 

# dataset <- data.frame(undefined, undefined.1, undefined.2, undefined.3, undefined.4, undefined.5, undefined.6)
# dataset <- unique(dataset)

# Pegue o escriba aquí el código de script:
library(fmsb)


nombres_jugadoras <- dataset[, 1]
datos_numericos <- dataset[, -1] 


colnames(datos_numericos) <- c("Defensa", "Regate", "Ritmo", "Pase", "Físico", "Tiro")


num_jugadoras <- nrow(datos_numericos)


max_val <- 100 
min_val <- 0
df_final <- rbind(rep(max_val, ncol(datos_numericos)), 
                  rep(min_val, ncol(datos_numericos)), 
                  datos_numericos)


col_lineas_base <- c(
  rgb(0.0, 1.0, 1.0, 0.9),  
  rgb(1.0, 0.2, 0.6, 0.9),  
  rgb(1.0, 0.8, 0.0, 0.9),  
  rgb(0.2, 0.8, 0.2, 0.9), 
  rgb(0.6, 0.2, 1.0, 0.9)  
)

col_rellenos_base <- c(
  rgb(0.0, 1.0, 1.0, 0.2),  
  rgb(1.0, 0.2, 0.6, 0.2),  
  rgb(1.0, 0.8, 0.0, 0.2),  
  rgb(0.2, 0.8, 0.2, 0.2),  
  rgb(0.6, 0.2, 1.0, 0.2)   
)


col_lineas <- col_lineas_base[1:num_jugadoras]
col_rellenos <- col_rellenos_base[1:num_jugadoras]


par(bg = "transparent", col = "white", mar = c(4, 0, 0, 0), font = 2) 


radarchart(df_final,
           axistype = 1,
           
           
           pcol = col_lineas,    
           pfcol = col_rellenos, 
           plwd = 3,              
           plty = 1,             
           pity = 16,             
           
           
           cglcol = "grey50",       
           cglty = 1,             
           cglwd = 1.1,           
           
         
           axislabcol = "#FFFFFF",  
           caxislabels = seq(0, 100, 25), 
           vlcex = 1.3,
           vlabels = colnames(datos_numericos)
)


legend(x = "bottom", 
       legend = nombres_jugadoras, 
       
       ncol = 3, 
       bty = "n", 
       pch = 20, 
       col = col_lineas, 
       text.col = "white", 
       cex = 1.1, 
       pt.cex = 2, 
       xpd = TRUE,
       inset = c(0, -0.07))
