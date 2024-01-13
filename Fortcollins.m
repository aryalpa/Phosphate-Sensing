latFortCollins = [40.5209 40.6407];  % Latitude range for the Fort Collins area
lonFortCollins = [-105.1494 -105.0350];  % Longitude range for the Fort Collins area

% Sample data for phosphate concentrations and locations
locations = [40.670821, -105.2307415
40.6521316, -105.1785383
40.6295451, -105.1686205
40.6218663, -105.1402263
40.612133, -105.113882
40.6032583, -105.0958919
40.5944697, -105.07377
40.5989159, -105.0809921
40.6008888, -105.0910738
40.6004955, -105.0859984
40.5913146, -105.0712882
40.5916932, -105.0714444
40.5799977, -105.0563527
40.5675005, -105.0271129
40.5589539, -105.0193767
40.574752, -105.104426
40.574747, -105.107976

40.579073, -105.106264

40.582000, -105.110304

40.582664, -105.105851

40.583445, -105.102701

40.582550, -105.102810

40.574959, -105.128878



    % ... Add more coordinates
];

phosphateConcentrations = [0
0.372294
0.772876
1.350792
2.447423
0.825549
0
3.086998
0
0
0
4.106045
2.716825
3.670311
3.625547
0
0
0
0
1.322394
0
1.673696
1.849088


    % ... Add more concentrations
];

% Create a color gradient map based on a 0 to 4.5 scale
% Set the color gradient colormap to 'jet'
colormap('jet');
colorScaleMin = 0;
colorScaleMax = 4.5;
colorMap = colormap; % Add this line to define colorMap

colorIndicesFortCollins = round(interp1(linspace(colorScaleMin, colorScaleMax, size(colorMap, 1)), 1:size(colorMap, 1), phosphateConcentrations));

% Define circle size based on concentration (adjust the scaling factor as needed)
minSize = 150;
maxSize = 500;
scatterSizeFortCollins = minSize + (maxSize - minSize) * (phosphateConcentrations - colorScaleMin) / (colorScaleMax - colorScaleMin);

% Plot the map centered around Fort Collins
figure;
geoplot([latFortCollins(1) latFortCollins(2)], [lonFortCollins(1) lonFortCollins(2)], '-*')
geobasemap streets
geolimits(latFortCollins, lonFortCollins);

% Plot circles with gradient color and size for Fort Collins
scatterColorFortCollins = colorMap(colorIndicesFortCollins, :);
geoscatter(locations(:, 1), locations(:, 2), scatterSizeFortCollins, scatterColorFortCollins, 'filled');

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