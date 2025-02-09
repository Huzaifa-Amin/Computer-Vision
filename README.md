# Computer Vision - MATLAB

This repository contains various MATLAB scripts demonstrating image processing techniques, including shape generation, intensity transformations, spatial filtering, and thresholding.

## Features
- **Circle and Diamond Shape Creation**
- **Intensity Transformations** (Negative, Gamma, Logarithmic, Contrast Stretching)
- **Nonlinear Spatial Filtering**
- **Thresholding using Otsu's Method**
- **Image Analysis & Enhancement**
- **Detection of Partially Filled Bottles**

---

## Tasks

### Task 1: Circle Creation
This script generates a white circle centered at `(128, 128)` with a radius of `50` pixels on a `256x256` black background.

**File:** `Task-1.m`

```matlab
% Create a black background
image = zeros(256, 256);

% Define center and radius
center = [128, 128];
radius = 50;

[x, y] = meshgrid(1:size(image, 2), 1:size(image, 1));

% Compute the distance and create a circle
dist = sqrt((x - center(1)).^2 + (y - center(2)).^2);
disk = (dist <= radius);

% Assign white pixels to the circle
image(disk) = 1;

imshow(image);
```

### Task 2: Diamond Creation
This script generates a white diamond shape centered at `(250, 250)` with a "radius" of `100` pixels.

**File:** `Task-2.m`

```matlab
imageSize = 500; % Canvas size
background = zeros(imageSize, imageSize);

% Define center and half-width
centerX = imageSize / 2;
centerY = imageSize / 2;
halfWidth = imageSize / 4;

% Create grid
[x, y] = meshgrid(1:imageSize, 1:imageSize);

% Define diamond shape
diamond = abs(x - centerX) + abs(y - centerY) <= halfWidth;
background(diamond) = 1;

imshow(background);
```

---

## Exercises

### Exercise 1: Intensity Transformations
#### Negative Transformation
```matlab
f = imread('Picture1.png');
g = imcomplement(f);
imshow(f);
figure;
imshow(g);
```

#### Power Law (Gamma Correction)
```matlab
f = imread('Picture1.png');
g = imadjust(f, [], [], 0.5);
imshow(f);
figure;
imshow(g);
```

#### Contrast Stretching
```matlab
f = imread('seeds.png');
fd = im2double(f);
m = mean2(fd);
g = 1./(1+(m./(fd+eps)).^4);
imshow(f);
figure;
imshow(g);
```

#### Logarithmic Transformation
```matlab
f = imread('light.png');
g = im2uint8(mat2gray(log(1+double(f))));
imshow(f);
figure;
imshow(g);
```

---

### Exercise 2: Image Type Detection & Enhancement
This program determines the type of an image (binary, grayscale, or RGB) and detects issues such as low contrast, over-dark, or over-bright conditions. If needed, it enhances the image.

```matlab
clc;
clear;
close all;

% Read the input image
[file, path] = uigetfile({'*.*'}, 'Select an Image File');
if isequal(file, 0)
    disp('User canceled file selection.');
    return;
end
img = imread(fullfile(path, file));

% Determine image type
if islogical(img)
    img_type = 'Binary Image';
elseif ndims(img) == 2
    img_type = 'Grayscale Image';
elseif ndims(img) == 3
    img_type = 'RGB Image';
else
    error('Unknown image format.');
end

fprintf('Image Type: %s\n', img_type);

% Convert RGB to grayscale if needed
if strcmp(img_type, 'RGB Image')
    gray_img = rgb2gray(img);
else
    gray_img = img;
end

% Compute Histogram
imhist(gray_img);

% Analyze brightness and contrast
mean_intensity = mean(gray_img(:));
std_dev = std(double(gray_img(:)));

% Define thresholds
low_thresh = 50;
high_thresh = 200;
low_contrast_thresh = 40;

% Detect issues
if mean_intensity < low_thresh
    enhanced_img = imadjust(gray_img, stretchlim(gray_img), []);
elseif mean_intensity > high_thresh
    enhanced_img = imadjust(gray_img, stretchlim(gray_img), []);
elseif std_dev < low_contrast_thresh
    enhanced_img = histeq(gray_img);
else
    enhanced_img = gray_img;
end

imshow(enhanced_img);
```

---

### Exercise 3: Detecting Partially Filled Bottles
This script labels only incompletely filled bottles in an image.

```matlab
clc;
clear;
close all;

% Read the image
[file, path] = uigetfile({'*.*'}, 'Select an Image File');
if isequal(file, 0)
    disp('User canceled file selection.');
    return;
end
img = imread(fullfile(path, file));

% Convert to grayscale
gray_img = rgb2gray(img);

% Apply edge detection
edges = edge(gray_img, 'Canny');

% Detect circular objects using Hough Transform
[centers, radii] = imfindcircles(gray_img, [20 100], 'ObjectPolarity', 'dark', 'Sensitivity', 0.9);

% Convert to binary for segmentation
bw = imbinarize(gray_img, 'adaptive');

% Morphological operations
bw = imclose(bw, strel('disk', 5));
bw = imfill(bw, 'holes');

% Label connected components
props = regionprops(bw, 'BoundingBox', 'Area');

figure, imshow(img);
hold on;

for i = 1:length(props)
    bbox = props(i).BoundingBox;
    subImage = imcrop(gray_img, bbox);
    profile = mean(subImage, 2);
    [~, liquidLevel] = min(profile);
    if liquidLevel < 0.7 * size(subImage, 1)
        rectangle('Position', bbox, 'EdgeColor', 'r', 'LineWidth', 2);
        text(bbox(1), bbox(2) - 10, 'Partially Filled', 'Color', 'red', 'FontSize', 12);
    end
end
hold off;
```

---

### Additional Exercises
#### Nonlinear Spatial Filtering (Median Filter)
```matlab
f = imread('cktboard.png');
fn = imnoise(f, 'salt & pepper', 0.2);
gm = medfilt2(fn, [3 3]);
imshow(gm);
```

#### Otsu Thresholding
```matlab
I = imread('COINS.png');
level = graythresh(I);
BW = im2bw(I,level);
imshow(BW);
```

---

## License

This project is open-source and available under the MIT License. See the [LICENSE](LICENSE) file for more information.

