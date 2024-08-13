# ARIMA

INTRODUCTION

There are multiple model options to use from when forecasting time series data. A commonly used model is the autoregressive integrated moving average (ARIMA) model. It has three components, the autoregressive component AR(p), the integrated component I(d) and the moving average component MA(q). Combined, they create an ARIMA (p, d, q) model. An ARIMA model is most suited for time series data that has a trend, seasonal pattern or is non-stationary data. Each part of the ARIMA will be explained using a model fitted on the United States Gross Domestic Product data (US GDP) from the year 1947 until 2020 will be used. The software used to carry out the analysis is R Studio.

TIME SERIES DATA

When provided with a time series data to do forecasting, it is advised to identify the data patterns to guide in choosing the best model to use. The US GDP data is plotted below to identify the pattern.

![992F755C-8CE5-42F7-B78B-447A62E4E94F](https://github.com/user-attachments/assets/d38000e0-7403-44f3-8cf4-3a625a20cbbc)

The plot above shows that the US GDP data has an upwards trend and seems to show a seasonal pattern too. The ARIMA model should work for this data because the ARIMA model works well with time series that have a trend in the data or seasonal patterns. The trend in the data makes a data non-stationary because the mean of the data is not constant over time.

After identifying the pattern of the data, it is important to make sure that the data is stationary so that the model can forecast better. A stationary data should have constant properties such as mean and variance over time. When the statistical properties are constant, it is easier for the ARIMA model or even other models to analyse the data and make reliable forecasts. A time series data with an increasing or decreasing trend, like the US GDP data, violates the stationary data assumptions because the mean is not constant over time.

In order to remove the trend to create stationary data, the differencing method is employed. This means, the difference between two data points is used to represent a point in the new differenced data instead. A data that has gone through differencing once will have one missing data point at the very beginning because it has no value to be differenced with. Normally, the first differencing can solve the problem of non-stationary data but that is not always the case. Differencing is done on the US GDP data and the plot of the first and second differencing done on the data is shown below.

![7B6C4F00-8493-4113-BD65-3040BC987B68](https://github.com/user-attachments/assets/fa6e2367-5593-4860-8e59-2abab460f5d2)

The plots for the first and second differencing still does not solve the stationary problem. It can be seen that the variance still increases over time. This could be due to other patterns in the original data such as multiplicative seasonal patterns. Consequently, a different method to transform the data into a constant variance data is applied which is using the logarithmic transformation method. Hence, the method is performed and the plot of the data that has been transformed using the log method is shown below.

![FF32FCAB-1B9F-408F-AAF4-8DE9D173A9D4](https://github.com/user-attachments/assets/6ccd9714-e1ee-4489-8d74-ae975790f01a)

The plot above shows that the log transformation has removed the multiplicative seasonal pattern. This should allow the differencing to work better to remove the trend from the new log data. The plot for the first and second difference performed on the new log data is shown below. The first plot below shows a better variance than when the data was differenced before the log transformation. The second plot also shows a good pattern but differencing many times makes the analysis more complex. Regardless, it is good to try both when modeling the ARIMA model because there is no one rule to identify how many differences will result in the best model. 

![4B6E8C32-AFAF-4B8F-A844-01CD7014AC06](https://github.com/user-attachments/assets/b88038be-6b1d-4181-87d9-d156c7e4146e)

ARIMA MODELING

As mentioned earlier, the ARIMA model consists of three components: AR(p), I(d), MA(q). First, the I(d) value, which represents the number of times the data is differentiated, will be discussed. The method is straightforward but finding the right number of differentiations to be done is not easy. Basically, the ‘d’ value takes the number of times the data has been differentiated. Based on the previously done differentiation, we will try using the value 1 or 2 for the I(d) value. Differentiating once will result in an ARIMA (0, 1, 0) model while differentiating twice will result in an ARIMA (0, 2, 0) model and so on. Now, we have two models to try and find the best ARIMA model. The next part is to determine the AR(p) and MA(q) values of the ARIMA model.

The first component, AR(p) is the autoregressive component and its role in the ARIMA model is to take care of the short term changes in data. The ARIMA model is designed to identify the relationship between an observation with another observation at a certain lagged value. The lagged value is the value of ‘p’ in the AR(p) component.

The last component, MA(q) is the moving average component and takes part in the ARIMA model to represent the long term trends. This part of the ARIMA model is actually representing the linear combination of error terms of the lagged forecasts. The ‘q’ value is the number of lagged forecast errors in the model.

The value of ‘p’ and ‘q’ can be identified using the autocorrelation function (ACF) and partial autocorrelation (PACF) plots. These plots will show the number of lags which could indicate a good ‘p’ and ‘q’ value. The AR(p) value is retrieved from referring to the PACF plot while the MA(q) value is retrieved by referring to the ACF plot. An example is shown below for the US GDP data that has been transformed.

![F94695EB-BF88-44C5-AAD8-34594ACEF753](https://github.com/user-attachments/assets/e8b25147-f144-4e41-9105-fe7febf3bebb)

The method to interpret the ACF and PACF plot is to look at whether the plot dies out or cuts off. In the example above, the ACF plot dies out and the PACF plot cutts of at around lag 0.05. An ACF that dies out with a PACF that cuts off suggests that the MA(q) value to be 0 and the AR(p) value to be the cut off point from the PACF plot. The ACF and PACF plots are just suggestions to guide the values of the AR(p) and MA(q) in an ARIMA model. It is still best to try other combinations of ‘p’ and ‘q’ values.

Now, the values for the two ARIMA models are ARIMA (0.05, 1, 0) and ARIMA (0.05, 2, 0). The R software rounds off the values making the new values for the models ARIMA (0, 1, 0) and ARIMA (0, 2, 0). The next step is to create the model.

After modeling the ARIMA model for both models earlier, The summary for the models are checked to make sure that the best model is chosen to forecast. In order to identify the best model, the mean absolute error (MAE) values are compared and the model with the smallest MAE value is chosen as the best model. The summary for ARIMA (0, 1, 0) and ARIMA (0, 2, 0) are shown below.

![706712D7-C937-4080-BB16-4723AF6F086A](https://github.com/user-attachments/assets/4cb4063b-658a-4d4a-bf03-496370738850)

Based on the summary of the models, ARIMA (0, 1, 0) shows a smaller MAE value. Before proceeding to the diagnostic testing section, a comparison of the forecasted values is done for both models by plotting the forecasted values.

ARIMA (0, 1, 0):
![8CEC76C7-6466-4787-B55D-37A4BCC953CD](https://github.com/user-attachments/assets/a620602c-185e-4e5d-90a3-e1af38e3dcad)

ARIMA (0, 2, 0):
![046A33DE-2FAC-4FF5-83D1-B94BF8A4F365](https://github.com/user-attachments/assets/2479496c-1be5-4cdf-96ef-abc0f431876f)

The plots above show the forecasts for ARIMA (0, 1, 0) and ARIMA (0, 2, 0). The first plot for ARIMA (0, 1, 0) forecasted stagnant values which indicates that the model is inadequate to forecast values for the data which does not seem to be correct. Hence, we are left with the ARIMA (0, 2, 0) to perform diagnostic testing.

ARIMA DIAGNOSTIC TEST

Checking the residuals, stationarity, normality and independence of an ARIMA model are part of the diagnostic test for ARIMA models. These tests are important to make sure that the model is valid and reliable to be used for forecasting values. The assumptions of an ARIMA model are:

The time series data used for the ARIMA model should be stationary
The residuals should be independent, have a normal distribution and have equal variance.

In the earlier section, the data has been transformed and differenced so the data is assumed to be stationary. The next diagnostic test is to check the residuals. The independence and variance of the residuals is checked by visualising the residuals in a scatter plot. There should be no pattern or clusters of points in the plot. The plot for ARIMA (0, 2, 0) is shown below.

![F3810BDB-2EDD-4EF3-A440-0F431F111BC6](https://github.com/user-attachments/assets/27fbc0a2-edf1-4f75-b841-1a5f9a363c6f)

The plot above shows that there is a slight funnel shape which indicates that the model is not capturing certain patterns in the data. The model fails the independent residuals assumption and the equal variance assumption. The next test is the normality test where the residuals are assumed to have a normal distribution. The histogram for the residuals is shown below. The histogram below does not show a normal distribution. The model fails the normality assumption too.

![DACA405B-5BA1-408B-AC8F-94CCD164E066](https://github.com/user-attachments/assets/8749beb4-9411-45f8-928e-f728a132c431)

Another test that could be done to check the adequacy of the model is the Ljung-Box statistic test. This test will result in a p-value and the p-value should not be significant which means it should not be smaller than the alpha value. The Ljung-Box test result for ARIMA (0, 2, 0) is shown below. The p-value is smaller than alpha 0.05 so the model is not adequate for making forecasts. 

![B8815048-4286-45D8-A6A5-AE56B0FEBF2A_4_5005_c](https://github.com/user-attachments/assets/b5e74e76-1d65-49a4-8c14-7d593f146307)

To conclude, this model fails most of the diagnostic tests and the reason may be that the model fails to capture the seasonal pattern of the data. The next section will employ a more complex ARIMA model to take into consideration the seasonal pattern present in the data.

SARIMA MODELING

In order to model a model that will capture the seasonal pattern, the seasonal part of the ARIMA model should be specified. This can be done using a SARIMA model. The SARIMA model is an extension of the ARIMA model and the ‘S’ stands for ‘seasonal’ making it a Seasonal ARIMA model. This model will handle the seasonal component of the data by adding a seasonal part to the model with ‘P’, ‘D’, ‘Q’ values that will represent the values for the seasonal component of a SARIMA(p, d, q)(P, D, Q) model. 

In R Studio, there is an Auto ARIMA option that will automatically select the best (p, d, q)(P, D, Q) values that will result in the best model. This section will use the Auto ARIMA option to choose the best SARIMA model. The model summary is shown below.

![08D113C7-9E47-4531-9A89-957D6217BE4B_4_5005_c](https://github.com/user-attachments/assets/aa0d8667-477a-4a96-b18c-c2783f9c19b1)

The ARIMA model from the Auto ARIMA option in R Studio shows that the best model is the SARIMA(3,1,2)(0,1,2) model. The first three values are the ARIMA values (p, d, q) and the other three values are the values for the seasonal component (P, D, Q). A good model has a small MAE value. The MAE value for this model is 0.008851 which is very low indicating that it could be a good model. The next part of the SARIMA analysis would be to perform the diagnostic tests on the SARIMA model.

SARIMA DIAGNOSTIC TEST

The diagnostic test for the SARIMA model is the same as the ARIMA model. Firstly, check the residuals to see if the residuals are independent and have equal variance. The plot is shown below. The residuals in the plot below still seem to exhibit a funnel pattern which means that the model fails the residual independency and equal variance test.

![DD41FA41-8215-4E7C-8716-7FD901206375_4_5005_c](https://github.com/user-attachments/assets/7579dcf4-4cb8-4e82-8f0a-ccfc07fe858f)

The next test is the normality test. The histogram of residuals is shown below. The histogram also shows a distribution that is not normal and the test is failed.

![D943369B-351E-4BCE-BC69-464728112AF6](https://github.com/user-attachments/assets/6ac7d614-f5ac-4f0c-add8-44ff4f387d94)

The final test is the Ljung Box statistic test. The results below show that the p-value is larger than alpha 0.05 hence it passes the Ljung-Box statistic test. 

![906E5168-443B-4A7B-A849-56E2CBB98BC4_4_5005_c](https://github.com/user-attachments/assets/8e6cef98-1964-4932-8eab-47d95e5903ca)

To conclude, the SARIMA(3,1,2)(0,1,2) model also fails most of the tests. However, the model passes the Ljung-Box statistic test. This indicates that the model validity and reliability is not the best even when there is no significant autocorrelation in the model. The model may still be used but it will not be the best model for reliable and valid forecasts. Below, the forecast for the SARIMA(3,1,2)(0,1,2) model is plotted and shown. The blue line is the forecasted value and the grey area is the lower and upper intervals.

![158EE78E-1BDE-49C5-A7E1-2D28E311F285](https://github.com/user-attachments/assets/7362a066-4157-4947-8dc5-74f82d1154bb)

To conclude, the SARIMA model is also not the best model to forecast the US GDP data. After making sure that the model has a low MAE value and checking the model using diagnostic tests, the model still fails a few assumptions for ARIMA models. In forecasting, there will be certain models suited for certain data patterns. Even after using data that has a pattern suitable for the ARIMA model, it still fails many tests hence it is good to use other forecasting options such as the Trigonometric Box-Cox transformation, ARMA errors, Trend and Seasonal components (TBATS) model.
