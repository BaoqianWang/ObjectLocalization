# Object Tracking and Localization
**Author: Baoqian Wang**

Implementation of Object Tracking and Localization Used in the paper [Geolocation using video sensor measurements]

## File structure

- `Matlab_scripts/Images`: contains 15 images of a mobile robot for testing.

- `Matlab_scripts/PositionData/Bao_GT_vicon.csv`: Real position data of mobile robot captured by motion capture system for video file.

- `Matlab_scripts/PositionData/location.csv`: Real position and image pixels position for the 15 images. 

- `Matlab_scripts/PositionData/pixelPosition0523`: Image pixels of mobile robot extracted by Yolo for video file.

- `Matlab_scripts/distortionCorrected.m`: function to implement distortion effect correction.

- `Matlab_scripts/multipleSingleImagesGeolocation.m`: Geolocation Main program for multiple images.

- `Matlab_scripts/videoGeolocation.m`: Geolocation Main program for video file.

- `custom_GR`: contains the labled images and configuration files to train a custom Yolo model for detecting the image pixel position of mobile robot.
