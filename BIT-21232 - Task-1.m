% Define the size of the image
imageSize = [500, 500]; % 500x500 pixels

% Create a black background
image = zeros(imageSize);

% Define the circle parameters
center = [250, 250]; % Center of the circle
radius = 100; % Radius of the circle

% Create a grid of coordinates
[x, y] = meshgrid(1:imageSize(2), 1:imageSize(1));

% Calculate the distance from each pixel to the circle center
distanceFromCenter = sqrt((x - center(1)).^2 + (y - center(2)).^2);

% Create the circle by setting pixels within the radius to white (1)
image(distanceFromCenter <= radius) = 1;

% Display the image
imshow(image);
