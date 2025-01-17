% Define the size of the image
imageSize = [500, 500]; % 500x500 pixels

% Create a black background
image = zeros(imageSize);

% Define the diamond parameters
center = [250, 250]; % Center of the diamond
radius = 100; % Radius (distance from the center to the vertices)

% Create a grid of coordinates
[x, y] = meshgrid(1:imageSize(2), 1:imageSize(1));

% Calculate the distance from each pixel to the center along the diamond's axes
distanceFromCenter = abs(x - center(1)) + abs(y - center(2));

% Create the diamond by setting pixels within the radius to white (1)
image(distanceFromCenter <= radius) = 1;

% Display the image
imshow(image);
