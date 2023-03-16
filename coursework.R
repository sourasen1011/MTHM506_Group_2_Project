# LIBRARIES
library(mgcv)
library(MASS)
library(tidyverse)
library(ggplot2)
library(psych)

# DATA
load('datasets_project.RData')
TBdata
# VISUALIZE CORRELATION
pairs.panels(TBdata[,c(1,2,3,4,5,6,7,8,10)])

# Individual relations with TB
ggplot(TBdata, aes(x = Illiteracy , y = log(TB))) + 
  geom_point()

ggplot(TBdata, aes(x = Indigenous , y = log(TB))) + 
  geom_point()

ggplot(TBdata, aes(x = Urbanisation , y = TB)) + 
  geom_point()

ggplot(TBdata, aes(x = Density , y = TB)) + 
  geom_point()

ggplot(TBdata, aes(x = Poor_Sanitation , y = TB)) + 
  geom_point()

ggplot(TBdata, aes(x = Poverty , y = log(TB))) + 
  geom_point()

ggplot(TBdata, aes(x = Poverty , y = log(TB))) + 
  geom_point()




######## MODELLING ########
# model1 <- gam.nb(TB ~ s(Indigenous) + s(Illiteracy) + s(Density), data = TBdata)
model1 <- glm.nb(TB ~ Indigenous + Illiteracy + Density, data = TBdata)
summary(model1)
plot(model1)

#EDA
summary(TBdata)

plot(TBdata$Indigenous , TBdata$TB)
plot(TBdata$Illiteracy , TBdata$TB)

# NEGBINOM
model2 <- gam(TB ~  offset(log(Population)) + Indigenous + Illiteracy + Urbanisation + Density + Poverty + Poor_Sanitation + Unemployment + Timeliness + Year + Region + lon + lat , data= TBdata , family = 'nb'(link = 'log'))

# incidence_rate = population*rate.10000 

#2x2 plot for the residuals
par(mfrow=c(2,2))
# Runing gam.check on our original model
gam.check(model2,pch=20)
par(mfrow=c(1,1))

qqnorm(resid(model2))

######PREDICT#############
df <- data.frame(Pop = TBdata$Population , TB = TBdata$TB)
preds <- predict(model2 , newdata = TBdata , type = 'response' , se.fit = TRUE)
df$preds <- preds$fit
df$lower <- preds$fit - 1.96*preds$se.fit
df$upper <- preds$fit + 1.96*preds$se.fit

p <- ggplot(df , aes(x = Pop , y = TB))+
  geom_point(alpha=0.5)+
  geom_smooth(aes(y = preds) , se = TRUE)

p


# NEGBINOM
model2.1 <- gam(TB ~  Population + Indigenous + Illiteracy + Urbanisation + Density + Poverty + Poor_Sanitation + Unemployment + Timeliness + Year + Region + lon + lat , data= TBdata , family = 'nb'(link='inverse'))

# 2x2 plot for the residuals
par(mfrow=c(2,2))
# Runing gam.check on our original model
gam.check(model2.1,pch=20)


#####PREDICT############
df <- data.frame(Pop = TBdata$Population , TB = TBdata$TB)
preds <- predict(model2.1 , newdata = TBdata , type = 'response' , se.fit = TRUE)
df$preds <- preds$fit
df$lower <- preds$fit - 1.96*preds$se.fit
df$upper <- preds$fit + 1.96*preds$se.fit

ggplot(df , aes(x = Pop , y = TB))+
  geom_point(alpha=0.5)+
  geom_smooth(aes(y = preds) , se = TRUE)


# GAUSSIAN
model3 <- gam(TB ~  offset(log(Population)) + Indigenous + Illiteracy + Urbanisation + Density + Poverty + Poor_Sanitation + Unemployment + Timeliness + Year + Region + lon + lat , data= TBdata , family = 'gaussian'(link='log'))

# 2x2 plot for the residuals
par(mfrow=c(2,2))
# Runing gam.check on our original model
gam.check(model3,pch=20)


#####PREDICT############
df <- data.frame(Pop = TBdata$Population , TB = TBdata$TB)
preds <- predict(model3 , newdata = TBdata , type = 'response' , se.fit = TRUE)
df$preds <- preds$fit
df$lower <- preds$fit - 1.96*preds$se.fit
df$upper <- preds$fit + 1.96*preds$se.fit

ggplot(df , aes(x = Pop , y = TB))+
  geom_point(alpha=0.5)+
  geom_smooth(aes(y = preds) , se = TRUE)

# POISSON - Overdispersion noted
model4 <- gam(TB ~  offset(log(Population)) + Indigenous + Illiteracy + Urbanisation + Density + Poverty + Poor_Sanitation + Unemployment + Timeliness + Year + Region + lon + lat , data= TBdata , family = 'poisson'(link='log'))


# 2x2 plot for the residuals
par(mfrow=c(2,2))
# Runing gam.check on our original model
gam.check(model4,pch=20)

#####PREDICT############
df <- data.frame(Pop = TBdata$Population , TB = TBdata$TB)
preds <- predict(model4 , newdata = TBdata , type = 'response' , se.fit = TRUE)
df$preds <- preds$fit
df$lower <- preds$fit - 1.96*preds$se.fit
df$upper <- preds$fit + 1.96*preds$se.fit

ggplot(df , aes(x = Pop , y = TB))+
  geom_point(alpha=0.5)+
  geom_smooth(aes(y = preds) , se = TRUE)

# 
# # BERNOULLI - Using rate
# TBdata <- mutate(TBdata, TBrate = TB/Population)
# 
# model5 <- gam(TBrate ~  offset(log(Population)) + Indigenous + Illiteracy + Urbanisation + Density + Poverty + Poor_Sanitation + Unemployment + Timeliness + Year + Region + lon + lat , data = TBdata , family = 'betar')
# 
# 
# ####PREDICT############
# df <- data.frame(Pop = TBdata$Population , TB = TBdata$TB)
# preds <- predict(model5 , newdata = TBdata , type = 'response' , se.fit = TRUE)
# df$preds <- preds$fit
# df$lower <- preds$fit - 1.96*preds$se.fit
# df$upper <- preds$fit + 1.96*preds$se.fit
# 
# ggplot(df , aes(x = Pop , y = TB))+
#   geom_point(alpha=0.5)+
#   geom_smooth(aes(y = preds) , se = TRUE)

# TRY WITH GLMA
model6_glm <- glm(TBrate ~  offset(log(Population)) + Indigenous + Illiteracy + Urbanisation + Density + Poverty + Poor_Sanitation + Unemployment + Timeliness + Year + Region + lon + lat , data = TBdata , family = binomial(link= 'logit'))

# 2x2 plot for the residuals
par(mfrow=c(2,2))
# Runing gam.check on our original model
gam.check(model5,pch=20)

################################################################################################

# POISSON - Overdispersion noted
model_smooth_1 <- gam(TB ~  offset(log(Population)) + s(Indigenous) + s(Illiteracy) + s(Urbanisation) + s(Density) + s(Poverty) + s(Poor_Sanitation) + s(Unemployment) + s(Timeliness) + s(Year) + s(Region) + s(lon) + s(lat) , data= TBdata , family = 'nb'(link='log'))

# 2x2 plot for the residuals
par(mfrow=c(2,2))
# Runing gam.check on our original model
gam.check(model_smooth_1,pch=20)
# reset graphics window
par(mfrow=c(1,1))


#####PREDICT############
df <- data.frame(Pop = TBdata$Population , TB = TBdata$TB)
preds <- predict(model_smooth_1 , newdata = TBdata , type = 'response' , se.fit = TRUE)
df$preds <- preds$fit
df$lower <- preds$fit - 1.96*preds$se.fit
df$upper <- preds$fit + 1.96*preds$se.fit

ggplot(df , aes(x = Pop , y = TB))+
  geom_point(alpha=0.5)+
  geom_smooth(aes(y = preds) , se = TRUE)