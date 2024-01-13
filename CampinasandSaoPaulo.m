% Sample data for phosphate concentrations and locations in Brazil
locationsBrazil = [
    -22.811225, -47.074068;
    -22.875688, -47.056314;
    -22.825654, -47.076006;
    % ... Add more coordinates in Brazil
];

phosphateConcentrationsBrazil = [
    0.855398478;
    0;
    0;
    % ... Add more concentrations
];

% Create a color gradient map based on a 0 to 4.5 scale
% Set the color gradient colormap to 'jet'
colormap('jet');
colorScaleMin = 0;
colorScaleMax = 4.5;
colorMap = colormap;

% Define the latitude and longitude range for the Brazil map
latRangeBrazil = [-23, -22.7]; % Adjust this range as needed
lonRangeBrazil = [-47.2, -46.9]; % Adjust this range as needed

% Create a figure with two subplots
figure;

% Plot the Brazil map in the first subplot
subplot(1, 2, 1);
geoplot(latRangeBrazil, lonRangeBrazil, '-*');
geobasemap('streets');
geolimits(latRangeBrazil, lonRangeBrazil);

scatterColorBrazil = colorMap(round(interp1(linspace(colorScaleMin, colorScaleMax, size(colorMap, 1)), 1:size(colorMap, 1), phosphateConcentrationsBrazil)), :);
scatterSizeBrazil = 150 + 350 * (phosphateConcentrationsBrazil - colorScaleMin) / (colorScaleMax - colorScaleMin);
geoscatter(locationsBrazil(:, 1), locationsBrazil(:, 2), scatterSizeBrazil, scatterColorBrazil, 'filled');
title('Campinas, Brazil');  % Updated title for Brazil

% Plot the Brazil map in the second subplot
subplot(1, 2, 2);
geoplot(latRangeBrazil, lonRangeBrazil, '-*');
geobasemap('streets');
geolimits(latRangeBrazil, lonRangeBrazil);

scatterColorBrazil = colorMap(round(interp1(linspace(colorScaleMin, colorScaleMax, size(colorMap, 1)), 1:size(colorMap, 1), phosphateConcentrationsBrazil)), :);
scatterSizeBrazil = 150 + 450 * (phosphateConcentrationsBrazil - colorScaleMin) / (colorScaleMax - colorScaleMin);
geoscatter(locationsBrazil(:, 1), locationsBrazil(:, 2), scatterSizeBrazil, scatterColorBrazil, 'filled');
title('Raia Olimpica river, Sao Paulo, Brazil');  % Updated title for Brazil
