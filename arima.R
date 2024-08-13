setwd("/Users/macbookair/Desktop/STQS4444 Time Series and Forecasting")
library(forecast)
library(zoo)

usgdp <- read.csv("GDPUS_nsa.csv")
head(usgdp)
gdp_ts <- ts(data = usgdp$NA000334Q, start = c(1947, 1), frequency = 4)

log_gdp_ts <- log(gdp_ts)
plot(gdp_ts, main = "Original GDP Time Series")
plot(log_gdp_ts, main = "Log-transformed GDP Time Series")

#diff_gdp <- diff(log_gdp_ts, differences = 1)
#plot.ts(diff_gdp)

par(mfrow = c(2, 1))
acf(log_gdp_ts, lag.max = 100,main = "Sample Autocorrelation Function")
pacf(log_gdp_ts, lag.max = 100, main = "Sample Partial Autocorrelation Function")
par(mfrow = c(1, 1))


# model ARIMA pdq - 0.05, d, 0
# trial and error and 2 seems to have the best results (1 created stagnant forecast, 4 created downwards forecast)
model <- arima(log_gdp_ts, c(0.05, 2, 0))
summary(model)
plot(fitted(model))

plot.ts(log_gdp_ts, main = "ARIMA (0, 2, 0)")
lines(fitted(model), col = rgb(1, 0, 0, alpha = 0.5))
lines(forecast(model)$mean, col = "blue")
legend("topleft", legend = c("US GDP", "fitted values", "forecasted values"), col = c("black", "red", "blue"), lty = 1)

fc_log_gdp <- forecast(model)
plot(forecast(model))
lines(fitted(model), col = "red")

fc_gdp <- exp(forecast(model)$mean)
plot(fc_gdp, type = "p")

##### diagnositic test #####
residuals <- residuals(model)

plot(residuals, type = "p"); abline(h = 0)
acf(residuals, lag.max = 280,main = "Sample Autocorrelation Function")
hist(residuals, breaks = 4)
hist(residuals)

Box.test(residuals, lag = 20, type = "Ljung-Box")
tsdiag(model)


#############
# Fit SARIMA model
sarima_model <- auto.arima(log_gdp_ts, seasonal = TRUE)
summary(sarima_model)
plot(forecast(sarima_model))
tsdiag(sarima_model)

res_sa <- residuals(sarima_model)

plot(res_sa, type = "p"); abline(h = 0)
acf(res_sa, lag.max = 20, main = "Sample Autocorrelation Function")
hist(res_sa, breaks = 4)
hist(res_sa)
Box.test(res_sa, lag = 20, type = "Ljung-Box")


########

model1 <- arima(log_gdp_ts, c(0.05, 1, 0))
summary(model1)
plot.ts(log_gdp_ts)
lines(fitted(model1), col = "red")
lines(forecast(model1)$mean, col = "blue")

fc_log_gdp <- forecast(model1)
plot(forecast(model1))
lines(fitted(model1), col = "red")

residuals1 <- residuals(model1)
plot(residuals1, type = "p"); abline(h = 0)
hist(residuals1)
Box.test(residuals1, lag = 20, type = "Ljung-Box")







