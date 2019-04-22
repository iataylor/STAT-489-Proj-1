

% Load any .mat file.
fileToLoad = '44027Edited';
LoadedData = load(fileToLoad);
X = LoadedData.X44027;

% Replace any NaN entries ('MM' in actual file) with cubic spline
% interpolated value, allowing for numerical analysis.
[rows, cols] = size(X);
for j = 1:cols
    newCol = fillmissing(X(:,j), 'spline');
    X(:, j) = newCol;
end
sum(sum(isnan(X))) %If non zero, there's a problem.

% Columns are in order..
% 1 - Time in mmddhh, 2 - Wind Dir in degT, 3 - Wind Speed in m/s, 4 - Gust in
% m/s, 5 - Wave Height in m, 6 - DPD in sec, 7 - APD in sec, 8 - MWD in degT, 
% 9 - Pressure in hPa, 10 - Atmospheric Temp in degC, 11 - Water
% Temperature in degC, 12 - Dewpoint in degC, 13 - PTDY in hPa.

% Need to extract outcome variable (wave height). -1 to all indexes > 5 in
% previous comment.
Y = X(:, 5);
X(:,5) = [];

X = [Y X];

save(fileToLoad, 'X');

