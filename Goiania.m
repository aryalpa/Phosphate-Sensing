% Sample data for phosphate concentrations and locations in Brazil
locationsBrazil = [
    -16.610212, -49.283103;
    -16.628524, -49.269803;
    -16.642405, -49.257000;
    -16.628103, -49.240555;
    -16.622510, -49.240040;
    -16.648059, -49.242013;
    -16.648320, -49.261814;
    -16.644271, -49.267674;
    -16.652537, -49.262286;
    -16.595094, -49.281079;
    -16.627832, -49.254077;
];

phosphateConcentrationsBrazil = [
    1.085825837;
    0.349730745;
    1.692429208;
    0;
    1.91193469;
    0;
    0;
    2.285087487;
    10;
    6.640236682;
    1.534655475;
];

% Create a color gradient map based on a 0 to 10 scale
% Set the color gradient colormap to 'jet'
colormap('jet');
colorScaleMin = 0;
colorScaleMax = 10;
colorMap = colormap;

colorIndicesBrazil = round(interp1(linspace(colorScaleMin, colorScaleMax, size(colorMap, 1)), 1:size(colorMap, 1), phosphateConcentrationsBrazil));

% Define circle size based on concentration (adjust the scaling factor as needed)
minSize = 150;
maxSize = 500;
scatterSizeBrazil = minSize + (maxSize - minSize) * (phosphateConcentrationsBrazil - colorScaleMin) / (colorScaleMax - colorScaleMin);

% Define the latitude and longitude range for the region in Brazil you want to center the map around
latRange = [-16.7, -16.5];
lonRange = [-49.3, -49.2];

% Plot the map centered around Brazil
figure;
geoplot(locationsBrazil(:, 1), locationsBrazil(:, 2), '-*');
geobasemap('streets');
geolimits(latRange, lonRange);

% Plot circles with gradient color and size for Brazil
scatterColorBrazil = colorMap(colorIndicesBrazil, :);
geoscatter(locationsBrazil(:, 1), locationsBrazil(:, 2), scatterSizeBrazil, scatterColorBrazil, 'filled');

% Define the color scale limits from 0 to 10
colorScaleMin = 0;
colorScaleMax = 10;

% Create color gradient legend with the specified scale
caxis([colorScaleMin, colorScaleMax]);
c = colorbar;

% Set font size and style for colorbar label
% Set colormap for the colorbar to 'jet'
c.Colormap = jet;
c.Label.String = '[PO_4^3^-]_p_p_m';
c.Label.FontSize = 18;
c.Label.FontWeight = 'bold';

% Set font size for color gradient tick labels
c.FontSize = 12;

% Set font size for axis labels (latitude and longitude)
ax = gca; % Get the current axes handle
ax.FontName = 'Arial';
ax.FontSize = 12;
ax.YLabel.String = 'Latitude';
ax.XLabel.String = 'Longitude';
ax.YAxis.Label.FontSize = 12;
ax.XAxis.Label.FontSize = 12;
