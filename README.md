## About

Processing sketch in alpha version for data visualizer for DataNodes with 3 axes of acceleration data for the Emerge project.

## Notes

*  Creates ten spheres and updates normalized vector with incoming data.
*  Reads `data/session2_minibees.txt` file line by line and reads the accel. xyz data points.
*  Arrow colour and sphere transparency determined by vector magnitude.
*  Sphere colour is arbitrary.
*  Spacebar pauses or resumes playback.
*  Left-click rotates camera, middle-click pans camera, double-click to reset camera.

## Screencast

[17MB .mov](http://dl.dropbox.com/u/62786/emerge-dataviz/emerge-dataviz-alpha-sketch.mov)

## Screenshots

DataNodes laid out sequential in 3d-space:
![Screen 1](http://dl.dropbox.com/u/62786/emerge-dataviz/emerge-dataviz-alpha-sketch-screen01.png)

Correlation?
![Screen 1](http://dl.dropbox.com/u/62786/emerge-dataviz/emerge-dataviz-alpha-sketch-screen02.png)

Node 4 and 6 are inactive
![Screen 1](http://dl.dropbox.com/u/62786/emerge-dataviz/emerge-dataviz-alpha-sketch-screen03.png)

## TODO

*  Refine/correct vector math
*  Add DataCorrelation class
*  Allow addition/removal of DataNodes
*  DataNetwork connectivity

## Notes

Built with Processing 1.5.1, with the following libraries:

*  [PeaseCam v0.92](http://mrfeinberg.com/peasycam/)
*  [shapes3d (v1.9.2)](http://www.lagers.org.uk/s3d4p/distribution/web/index.html)

## Author & License

Matthieu Tremblay, license stuff coming