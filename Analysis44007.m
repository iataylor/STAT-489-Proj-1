% Data Analysis Script for Data Science Project.
%
% Column labels...
% 1 - Predictor Wave Height in m
% 2 - Time of measurement in mmddhh
% 3 - Wind Direction in degT
% 4 - Wind Speed in m/s
% 5 - Gusts in m/s
% 6 - Dominant Wave Period in sec
% 7 - Average Wave Period in sec
% 8 - Mean Wave Direction for DPD in degT
% 9 - Sea Level Pressure in hPa
% 10 - Atmospheric Temp in degC
% 11 - Sea Surface Temperature in degC (doesn't exist in 44018 since all vals are missing)
% 12 - Dewpoint in degC
% 13 - Pressure Tendency in hPa
% 
% All missing values were cubic piecewise spline interpolated column-wise in the Data
% Cleaning script. Information on it here
% 'https://www.mathworks.com/help/matlab/ref/fillmissing.html#bva1z1c-method'
% 
% For more in depth data label description refer to
% 'https://www.ndbc.noaa.gov/measdes.shtml'
%

load('44007Edited');

Y = X(:,1)
X(:,1) = [];
[rows, cols] = size(X);

% Simple Linear Regression

B0 = sym('B0');
B = sym('B%d', [1 cols]);
B = [B0 B]

B = X\Y;

yPred = X * B;

Rsq = sum((Y - yPred).^2) / sum((Y - mean(Y)).^2)

% Turns out my model is quite similar to the straight fitlm() model MATLAB
% provides for us. The differences are mostly in the intercept term which
% apparently the mldivide operator (B = X\Y) doesn't solve for the
% intercept correctly...

mdl = fitlm(X, Y)
coeffDiff = sum(mdl.Coefficients.Estimate) - sum(B)

% Regression variant 1 with Lasso and cross validation for lambda

% Regression variant 2 with Local Regression

% Principal Components Regression

% ANN 

% Summary Data and graphs