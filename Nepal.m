% Sample data for phosphate concentrations and locations in Nepal
locationsNepal = [
    27.7646370000000, 85.3299990000000
    27.7778760000000, 85.3620750000000
    27.7619620000000, 85.4226380000000
    27.7589450000000, 85.4206660000000
    27.6486570000000, 85.2821560000000
    27.5988730000000, 85.3865660000000
    27.5943010000000, 85.3788650000000
    27.5978230000000, 85.3867900000000
    27.7852070000000, 85.3656900000000
    27.5974990000000, 85.3794200000000
    27.8016710000000, 85.3276500000000
    27.8024950000000, 85.3217000000000
    27.7085140000000, 85.3167600000000
    27.6783930000000, 85.2337190000000
    27.6741030000000, 85.2365500000000
    27.6741310000000, 85.2382580000000
    27.6804360000000, 85.2408710000000
    27.6813190000000, 85.2392340000000
    27.6847670000000, 85.2370980000000
    27.6821640000000, 85.2310720000000
    27.7338000000000, 85.3005720000000
    27.6754010000000, 85.4353630000000
    27.6757620000000, 85.4337000000000
    27.6789000000000, 85.2970190000000
    27.9543070000000, 85.2952070000000
    27.4323800000000, 85.2108600000000
    27.6688210000000, 85.3312980000000
    27.6736560000000, 85.3252710000000
    27.6763940000000, 85.3260750000000
    27.6754410000000, 85.3243930000000
    27.7080740000000, 85.3154870000000
    27.6707420000000, 85.3267610000000
    27.5964420000000, 85.3860460000000
    27.9888780000000, 83.7698510000000
    27.6742560000000, 85.4334400000000
    27.6766280000000, 85.4313190000000
    27.8020760000000, 85.3244540000000
    27.7938090000000, 85.3300080000000
    27.7340510000000, 85.3009440000000
    27.6768910000000, 85.4352040000000
    27.6769240000000, 85.4383070000000
    27.6772710000000, 85.3239570000000
    27.7062650000000, 85.3151470000000
    27.6686330000000, 85.3301730000000
    27.6702400000000, 85.4311750000000
    27.6759980000000, 85.3242070000000
    27.6725780000000, 85.4325280000000
];

phosphateConcentrationsNepal = [0
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
0.413499365000000
0.640060549000000
0.726076100000000
1.41706934000000
1.67247805900000
1.85921373900000
1.99175660300000
2.03091383400000
2.76699345300000
2.97924913300000
3.25311349500000
3.46184091400000
4.43707168800000
5.33327297300000
7.15238288400000
10
    % ... Add more concentrations
];

% Create a color gradient map based on a 0 to 4.5 scale
% Set the color gradient colormap to 'jet'
colormap('jet');
colorScaleMin = 0;
colorScaleMax = 10;
colorMap = colormap; % Add this line to define colorMap

colorIndicesNepal = round(interp1(linspace(colorScaleMin, colorScaleMax, size(colorMap, 1)), 1:size(colorMap, 1), phosphateConcentrationsNepal));

% Define circle size based on concentration (adjust the scaling factor as needed)
minSize = 200;
maxSize = 600;
scatterSizeNepal = minSize + (maxSize - minSize) * (phosphateConcentrationsNepal - colorScaleMin) / (colorScaleMax - colorScaleMin);

% Plot the map centered around Nepal
figure;
geoplot([locationsNepal(1, 1), locationsNepal(2, 1)], [locationsNepal(1, 2), locationsNepal(2, 2)], '-*');
geobasemap('streets');

% Plot circles with gradient color and size for Nepal
scatterColorNepal = colorMap(colorIndicesNepal, :);
geoscatter(locationsNepal(:, 1), locationsNepal(:, 2), scatterSizeNepal, scatterColorNepal, 'filled');

% Define the color scale limits from 0 to 10 (adjust as needed)
colorScaleMin = 0;
colorScaleMax = 10;

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
