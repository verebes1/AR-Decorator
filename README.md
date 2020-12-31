# AR Decorator a Wall Painint application

## Description

This is an Augmented Reality based wall painint app example which uses RealityKit and two example colors blue and red currently hardcoded. 

## Usage

The app launches and uses red paint by default. 
To change the paint color tap on the paint bucket and it will cycle through the available colours. The colour is only placed on walls detected by semantic segmentation in ARKit. If the surface detectes is not classed as wall no paint will be placed on the object. 

To save a screenshot of the current ARView just tap SAVE IMAGE and allow access to your Camera Roll.

## Requirements
XCode 12.3 
Swift 5.3.2
iPhone 12 Pro to use Lidar Scanner
iOS 14.3

## Technologies used
-Swift<br>
-ARKit<br>
-RealityKit<br>