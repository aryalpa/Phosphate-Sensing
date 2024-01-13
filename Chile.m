% Sample data for phosphate concentrations and locations in Chile
locationsChile = [-33.581173, -70.46162
    -33.582737, -70.462156
    -32.231399, -71.506386
    -33.620069, -71.620594
    -32.236103, -71.508201
    -32.23626, -71.508223
    -33.785392, -70.23247
    -33.785839, -70.232672
    -33.595987, -70.372386
    -33.59593, -70.372993
    -33.595369, -70.373397
    -33.594752, -70.372656
    -32.231548, -71.506672
    -32.233361, -71.508127
    -33.826722, -70.064444
    -33.827673, -70.08544
    -33.826883, -70.066969
    -33.826346, -70.091992
    -32.23141, -71.506293
    % ... Add more coordinates
];

phosphateConcentrationsChile = [0
    0
    1.728890585
    1.617377496
    0
    0
    0
    0
    0
    0
    0
    0
    0
    0
    0.914046439
    1.94
    3.939258511
    4.357622089
    1.091755189
    % ... Add more concentrations
];

% Create a color gradient map based on a 0 to 4.5 scale
% Set the color gradient colormap to 'jet'
colormap('jet');
colorScaleMin = 0;
colorScaleMax = 4.5;
colorMap = colormap; % Add this line to define colorMap

colorIndicesChile = round(interp1(linspace(colorScaleMin, colorScaleMax, size(colorMap, 1)), 1:size(colorMap, 1), phosphateConcentrationsChile));

% Define circle size based on concentration (adjust the scaling factor as needed)
minSize = 150;
maxSize = 500;
scatterSizeChile = minSize + (maxSize - minSize) * (phosphateConcentrationsChile - colorScaleMin) / (colorScaleMax - colorScaleMin);

% Plot the map centered around Chile
figure;
geoplot([locationsChile(1, 1), locationsChile(2, 1)], [locationsChile(1, 2), locationsChile(2, 2)], '-*');
geobasemap('streets');
geolimits([-34, -32.2], [-72, -70]); % Adjust the latitudes and longitudes as needed

% Plot circles with gradient color and size for Chile
scatterColorChile = colorMap(colorIndicesChile, :);
geoscatter(locationsChile(:, 1), locationsChile(:, 2), scatterSizeChile, scatterColorChile, 'filled');

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
ax.YLabel.FontSize = 16;
ax.XLabel.FontSize = 16;

% Set font size for latitude and longitude axis tick numbers
ax.YAxis.FontSize = 16;
ax.XAxis.FontSize = 16;
