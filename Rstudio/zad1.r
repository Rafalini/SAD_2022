require(magrittr)
require(tidyverse)
require(zoo)
require(tibble)
library(dplyr)
library (reshape2)


# make titles in plots centered
theme_update(plot.title = element_text(hjust = 0.5))

## a)
df <- read.csv('k_d_07_2021.csv')
filtered <- subset(df, Nazwa_stacji=='OLECKO' | Nazwa_stacji=='BRENNA' | Nazwa_stacji=='BORUCINO', select = c(Nazwa_stacji, Maksymalna_temperatura_dobowa, Minimalna_temperatura_dobowa))
write.csv(filtered, 'filtered.csv', row.names = TRUE)
filtered <- read.csv('filtered.csv')
#1
filtered %>% select(Nazwa_stacji,Maksymalna_temperatura_dobowa) %>% group_by(Nazwa_stacji) %>% summarize(t_max = mean(Maksymalna_temperatura_dobowa)) %>% arrange(desc(t_max))
#2
filtered %>% select(Nazwa_stacji,Maksymalna_temperatura_dobowa,Minimalna_temperatura_dobowa) %>% group_by(Nazwa_stacji) %>% summarize(t_diff = mean(Maksymalna_temperatura_dobowa-Minimalna_temperatura_dobowa)) %>% arrange(t_diff)
#3
filtered %>% select(Nazwa_stacji,Maksymalna_temperatura_dobowa) %>% group_by(Nazwa_stacji) %>% summarize(t_diff_avg = mean(abs(diff(Maksymalna_temperatura_dobowa)))) %>% arrange(desc(t_diff_avg))

boxplot(filtered$Maksymalna_temperatura_dobowa ~ filtered$Nazwa_stacji, data = filtered, col = c("#FFE0B2", "#F57C00", "#FFA726"),  xlab = "Miejscowość", ylab = "temperatura [stopnie celcjusza]")
## b)

legionowo <- df[df$Nazwa_stacji=='LEGIONOWO', ]
x <- 1:(nrow(legionowo)-1)
y <- diff(legionowo$Maksymalna_temperatura_dobowa)

hist(y, col="green", breaks=30, xlim=c(-12,12), main = "Histogram różnic temperatur", xlab='wielkość różnicy', ylab='ilość dni z daną różnicą')
curve(dnorm(x, mean = 0, sd = 3)*30, col='blue', lwd=2, add = TRUE)

#kryterium jakości
length(y[abs(y)<2])/length(y)


