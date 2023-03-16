library (mgcv)
library(ggplot2)
load('/home/enam_2004/Downloads/datasets_project1.RData')

par(mfrow = c(2,2))

model_poisson <- gam(formula = TB ~ offset(log(Population)) + s(Indigenous) +  s(Illiteracy) +  s(Urbanisation) + s(Density) + s(Poverty) + s(Poor_Sanitation) + s(Unemployment) + s(Timeliness), data = TBdata, family = poisson(link = 'log'))
summary(model_poisson)
model_poisson$aic
par(mfrow = c(2,2))

model_nb <- gam(formula = TB ~ offset(log(Population)) + s(Indigenous) +  s(Illiteracy) + s(Urbanisation) + s(Density) + s(Poverty) + s(Poor_Sanitation) + s(Unemployment) + s(Timeliness), data = TBdata, family = nb(link = 'log'))
summary(model_nb)
model_nb$aic

model_nb <- gam(formula = TB ~ offset(log(Population)) + s(Indigenous) +  s(Illiteracy) + s(Urbanisation) + s(Density) + s(Poverty) + s(Poor_Sanitation) + s(Unemployment) + s(Timeliness) + s(lon, lat), data = TBdata, family = nb(link = 'log'))
summary(model_nb)
model_nb$aic


model_nb_time <- gam(formula = TB ~ offset(log(Population)) + s(Indigenous, by = Year) +  s(Illiteracy, by = Year) + s(Urbanisation, by = Year) + s(Density, by = Year) + s(Poverty, by = Year) + s(Poor_Sanitation, by = Year) + s(Unemployment, by = Year) + s(timeliness, by = Year), data = TBdata, family = nb(link = 'log'))
summary(model_nb)
model_nb$aic

model_nb_time_and_space <- gam(formula = TB ~ offset(log(Population)) + s(Indigenous, by = Year) +  s(Illiteracy, by = Year) + s(Urbanisation, by = Year) + s(Density, by = Year) + s(Poverty, by = Year) + s(Poor_Sanitation, by = Year) + s(Timeliness, by = Year) + s(Unemployment, by = Year) + s(lon,lat, by = Year), data = TBdata, family = nb(link = 'log'))
summary(model_nb_time_and_space)
model_nb_time_and_space$aic

summary(model_nb_time)
model_nb_time$aic
model_nb$aic

