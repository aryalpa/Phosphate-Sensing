% naya Main file for mobile integration of phosphate detection app/device.


% Clear workspace
clear;

% Initialize phone, logging, camera
m = mobiledev;
m.Logging = 1;

% Initialize a SensorData for the new data
currentMeasurement = SensorData;

% Get device taking pictures
currentMeasurement.deviceType = m.Device;

% Try to capture an image until successful
maxAttempts = 10;
imageCaptured = false;

for attempt = 1:maxAttempts
    % Take image
    [currentMeasurement.image, currentMeasurement.imageTime] = mobileTakePicture(m);
    
    % Check if the image was captured successfully
    if ~isempty(currentMeasurement.image)
        imageCaptured = true;
        break;
    end
    
    % If image capture failed, wait for a short duration and then try again
    pause(1); % Adjust the delay time as needed
end

% If image capture failed after multiple attempts, handle the error as needed
if ~imageCaptured
    error('Failed to capture an image after multiple attempts.');
end

% Get current GPS location
[currentMeasurement.deviceLocationLat, currentMeasurement.deviceLocationLon, currentMeasurement.deviceLocationAlt] = getCurrentPosition(m);

% Stop logging, clear mobiledev
m.Logging = 0;

% Continue with the rest of your code

% Read the image taken by the mobile device
img = currentMeasurement.image;

% Define the centers and radii of the circular ROIs
roi_centers = [134, 499;    % center of ROI 1
               265, 482;    % center of ROI 2
               388, 506;    % center of ROI 3
               269, 344];  % center of ROI 4 (Normalization ROI) this coordinated is placed at blue reference

roi_radii = 60 * ones(4, 1);  % radius of each ROI (same for all ROIs)

% Create binary masks for each ROI
[x, y] = meshgrid(1:size(img, 2), 1:size(img, 1));
masks = cell(4, 1);
for i = 1:4
    masks{i} = ((x - roi_centers(i, 1)).^2 + (y - roi_centers(i, 2)).^2) <= roi_radii(i).^2;
end

% Extract the red channel of the image
red_channel = img(:, :, 1);

% Invert the red channel values
inverted_red = 255 - red_channel;

% Calculate the mean inverted red value of each ROI
mean_inverted_red = zeros(4, 1);
for i = 1:4
    mean_inverted_red(i) = mean(inverted_red(masks{i}));
end

% Display the ROIs and mean inverted red values with text on the image
figure;
imshow(img);
hold on;
for i = 1:4
    viscircles(roi_centers(i, :), roi_radii(i), 'Color', 'r');
    text(roi_centers(i, 1) - roi_radii(i), roi_centers(i, 2) + roi_radii(i), ...
        ['Mean Inverted Red Value: ', num2str(mean_inverted_red(i)), ''], 'Color', 'r');
end

% Display all the mean inverted red values
disp('All Mean Inverted Red Values:');
disp(mean_inverted_red);

% Normalize the values using the 4th ROI
normalized_values = mean_inverted_red ./ mean_inverted_red(4);

% Display only the normalized values for ROIs 1, 2, and 3
disp('Normalized Values for ROIs 1, 2, and 3:');
disp(normalized_values(1:3));

% Calculate the mean and standard deviation of the normalized values for ROIs 1, 2, and 3
mean_normalized_1_2_3 = mean(normalized_values(1:3));
std_normalized_1_2_3 = std(normalized_values(1:3));

% Display the mean and standard deviation of the normalized values for ROIs 1, 2, and 3
disp(['Mean of Normalized Values for ROIs 1, 2, and 3: ' num2str(mean_normalized_1_2_3)]);
disp(['Standard Deviation of Normalized Values for ROIs 1, 2, and 3: ' num2str(std_normalized_1_2_3)]);

%%% FUNCTION DEFINITIONS %%%
%In: mobiledev, representing the phone
%Out: an image file
function [img,t] = mobileTakePicture(mDev)
c = camera(mDev,'back');
c.Resolution = string(c.AvailableResolutions(2));
c.Autofocus = 'on';
[img,t] = snapshot(c,'manual');
end

%In: mobiledev, representing the phone
%Out: lat,lon,altitude, single number for each
function [lat,lon,alt] = getCurrentPosition(mDev)
x = 0;
lat = [];
%Check for lat/long data, continue checking until data is found
%This is so that a slow-updating phone will still get data at some point
while(isempty(lat))
    pause(1)
    [lat,lon,~,~,~,alt,~] = poslog(mDev);
    x = x+1;
    if(x==1)
        disp("Waiting for GPS data...")
    end
    if(x==10)
        disp("No GPS data found...")
        return
    end
end
lat = lat(1);
lon = lon(1);
alt = alt(1);
disp("GPS location found...")
end

%In: SensorData file,
%Out: Saved file
function saveData(cur)
baseFileName = string(cur.sensorID + "_" + string(cur.imageTime));
fullFileName = fullfile(pwd,"generatedData/",baseFileName);
save(fullFileName,'cur');
end

function [bar, barLoc,r] = searchForBarcode(I)
disp("Searching for Barcode...")
[msg,~,loc] = readBarcode(I,"DATA-MATRIX");
r = 1;
%If no barcode found, rotate image and check continually, when found,
%rotate image.
while(isempty(loc) && r)
    r = r +1;
    Ir = imrotate(I,r);
    [msg,~,loc] = readBarcode(Ir,"DATA-MATRIX");
    if(not(rem(r,10)))
        disp("Running search: " + r)
    end
    if r == 360
        disp("No Barcode Found")
        bar = 0;
        return
    end
end
disp("Barcode Found: "+ msg)
barLoc = loc;
bar = msg;
end

function iCropped = getMeasurementArea(I,barLocation,r)
xDev = barLocation(2,1) - barLocation(1,1);
yDev = barLocation(2,2) - barLocation(1,2);
minOuterX = min([barLocation(2,1),barLocation(1,1),barLocation(3,1),barLocation(4,1)]);
minOuterY = min([barLocation(2,2),barLocation(1,2),barLocation(3,2),barLocation(4,2)]);
len = sqrt(xDev*xDev + yDev*yDev);
a = rad2deg(atan(yDev/xDev));
iCrop = imcrop(I,[minOuterX-3*len minOuterY-3*len 6*len 6*len]);
if barLocation(2,2) < barLocation(1,2)
    iRot = imrotate(iCrop,a+r+180,"nearest","crop");
else
    iRot = imrotate(iCrop,a+r,"nearest","crop");
end
imshow(iRot)
iCropped = iRot;
end

%In: A SensorData, with a barcode
%Out: A SensorData, with the barcode split and attributes updated accordingly.
function ret = digestBarcode(meas)
splitBar = split(meas.barcode,'-');
meas.sensorVersion = splitBar(1);
meas.referenceVersion = splitBar(2);
meas.sensorTests = split(splitBar(3),',');
meas.sensorID = splitBar(4);
ret = meas;
end
