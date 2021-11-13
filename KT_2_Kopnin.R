#установка пакетов
install.packages("vroom")
install.packages("readxl")
install.packages("dplyr")

#подключение пакетов
library("vroom")
library("readxl")
library("dplyr")
library(tidyverse)

# 1.устанавливаем рабочую директорию и парсим файлы данных
setwd("/Users/antonkopnin/Desktop/Учёба/Шлеев/КТ_Шлеев")

#импорт данных
PZ<- vroom(file = "RU_Electricity_Market_PZ_dayahead_price_volume.csv") #Ценовой объем рынка электроэнергии PZ ЕАС на сутки вперед
UES_dayahead<- vroom(file = "RU_Electricity_Market_UES_dayahead_price.csv") #Рынок электроэнергии ЕЭС Цена на сутки вперед
UES_intraday<- vroom(file = "RU_Electricity_Market_UES_intraday_price.csv") #Рынок электроэнергии ЕЭС внутридневная цена

#название столбцов
head(PZ)
names(UES_intraday)

#авторегрессия
set.seed(20)
y <- arima.sim(PZ,n = nrow(PZ))
plot(y)


#график
ggplot(data = PZ)+
  geom_point(alpha = 1/3, mapping = aes(x= timestep, y = price_eur, color =consumption_eur ))

ggplot(data = PZ)+
  geom_point(alpha = 1/3, mapping = aes(x= consumption_sib, y = price_sib))


ggplot(data = PZ) +
  geom_point(mapping = aes(x = timestep, y = price_eur, color = consumption_eur))+
  geom_smooth(mapping = aes(x= timestep, y = price_sib))
