% Updated sample data for phosphate concentrations and locations in Thailand
locationsThailand = [
    13.738631, 100.530308
    13.7429192537244, 100.5308837473462
    14.037128, 100.713842
    13.735321344419463, 100.53068639489702
    13.736235730689993, 100.53112919007968
    13.741780564174078, 100.53141231112268
    13.740943095893568, 100.52746214768496
    13.806180, 99.871993
    13.699067306350456, 99.86023026606817
    13.741956800532265, 100.52795046911491
    14.074084388334574, 100.60293428785333
    14.071322422365526, 100.61430610526185
    14.077878426732486, 100.59642759647951
    13.732032357979628, 100.53273188960611
    14.617700317106449, 100.74354065017508
    14.649280736379152, 100.6513647173098
    14.690612, 100.724021
    15.176100, 100.219600
    15.170257996145704, 100.23038362061436
    15.175565940084224, 100.23483999917264
];

phosphateConcentrationsThailand = [
    0
    0
    0
    0.8
    0
    0
    4.5
    0
    0.8
    0
    0
    1.6
    0
    0.7
    2.5
    1.6
    0
    0
    1.3
    0
];

% Create a color gradient map based on a 0 to 4.5 scale
% Set the color gradient colormap to 'jet'
colormap('jet');
colorScaleMin = 0;
colorScaleMax = 4.5;
colorMap = colormap; % Add this line to define colorMap

colorIndicesThailand = round(interp1(linspace(colorScaleMin, colorScaleMax, size(colorMap, 1)), 1:size(colorMap, 1), phosphateConcentrationsThailand));

% Define circle size based on concentration (adjust the scaling factor as needed)
minSize = 150;
maxSize = 500;
scatterSizeThailand = minSize + (maxSize - minSize) * (phosphateConcentrationsThailand - colorScaleMin) / (colorScaleMax - colorScaleMin);

% Sort the concentrations and locations by concentrations in descending order
[sortedConcentrations, sortIdx] = sort(phosphateConcentrationsThailand, 'descend');
sortedLocations = locationsThailand(sortIdx, :);
sortedSize = scatterSizeThailand(sortIdx);
sortedColor = colorMap(colorIndicesThailand(sortIdx), :);

% Plot the map centered around Thailand
figure;
geoplot(sortedLocations(:, 1), sortedLocations(:, 2), '-*');
geobasemap('streets');
geolimits([13.5, 15.5], [99.5, 100.8]); % Adjust the latitudes and longitudes as needed

% Plot circles with gradient color and size for Thailand
geoscatter(sortedLocations(:, 1), sortedLocations(:, 2), sortedSize, sortedColor, 'filled');

% Define the color scale limits from 0 to 4.5
colorScaleMin = 0;
colorScaleMax = 4.5;

% Create color gradient legend with the specified scale
caxis([colorScaleMin, colorScaleMax]);
c = colorbar;

% Set font size and style for colorbar label
% Set colormap for the colorbar to 'jet'
c.Colormap = jet;
c.Label.String = '[PO_4^3^-]_p_p_m';
c.Label.FontSize = 26;
c.Label.FontWeight = 'bold';
c.Label.FontName = 'Arial'; % Set the font name to Arial if it's not already the default

% Set font size for color gradient tick labels
c.FontSize = 20;

% Set font size and style for axis labels (latitude and longitude)
ax = gca; % Get the current axes handle
ax.FontName = 'Arial';
ax.FontSize = 16;

% Set font size for latitude and longitude axis tick labels
ylabel(ax, 'Latitude', 'FontSize', 16);
xlabel(ax, 'Longitude', 'FontSize', 16);

% Set font size for latitude and longitude axis tick numbers
ax.YAxis.FontSize = 16;
ax.XAxis.FontSize = 16;

% Remove the display of GPS coordinates on the map
ax.XAxis.Visible = 'off';
ax.YAxis.Visible = 'off';
