/**
 * DataNode v0.1
 * Matthieu Tremblay
 * 
 */
 
import shapes3d.utils.*;
import shapes3d.animation.*;
import shapes3d.*;

class DataNode {
 
  String id;
  float posX, posY, posZ, accelX, accelY, accelZ, magnitude;
  color c;
  PVector accelerometerVector, directionVector;
  Cone arrowHead;
  
  DataNode (PApplet parent, String id, int posX, int posY, int posZ ) {
    this.id = id; // ie.  /minibee.1/node.1/accel
    
    this.posX = posX;
    this.posY = posY;
    this.posZ = posZ;
    
    accelerometerVector = new PVector(0,0,0);
    directionVector = new PVector(0,0,0);
    
    arrowHead = new Cone(parent, 6);
    arrowHead.drawMode( Shape3D.SOLID );

    this.c = color ( 20, random(50, 100), random(50, 100)); // random bright color
  }
  
  public void display() {
    pushMatrix();  
      translate( posX , posY , posZ ); 
      drawSphere();
      drawDirectionVector();
      drawIdLabel();
      drawAxis();
    popMatrix();
  }
  
  public void update(float x, float y, float z) {
    accelerometerVector.set( x  , y , z );
//    accelerometerVector.normalize();
    
//    directionVector.set( accelerometerVector.x - 0.5, accelerometerVector.y - 0.5, accelerometerVector.z - 0.5 );
//    directionVector.normalize();
    directionVector.set( accelerometerVector.x, accelerometerVector.y, accelerometerVector.z );
   magnitude = sqrt( pow( directionVector.x, 2 ) + pow( directionVector.y, 2 ) + pow( directionVector.z, 2 ) );
  }

  private void drawDirectionVector() {
    color variableRed;

    pushMatrix();
    
      scale(magnitude * 3);

      // set the weight and color of the arrow
      strokeWeight(5);
      variableRed = color ( map(magnitude, 0, 2, 50, 100), map(magnitude, 0, 2, 50, 100), 0); 
      stroke( variableRed, 100 ); // red
      
      // draw the line
      line(0, 0, 0, directionVector.x, directionVector.y, directionVector.z);


      arrowHead.setSize(0.2, 0.2, 0.5);
      arrowHead.fill( variableRed  );
      
      arrowHead.shapeOrientation( PVector.mult(directionVector, -1) , directionVector);
      arrowHead.draw();
    popMatrix();
  }
  
  private void drawSphere() {
    pushMatrix(); 
        scale( 4 );
        //strokeWeight(1);
        //stroke(200, 50);
        noStroke();
        fill( c, map(magnitude, 0, 2, 10, 100) );
        sphereDetail( 12 );
        sphere(1);      
    popMatrix(); 
  }
  
  
  
  private void drawIdLabel() {
    pushMatrix();
      textAlign(CENTER);
      fill(100, 100, 100);
      stroke(0);
      
      scale(0.2);
      rotateY(0);
      
      text( this.id, 0, 35, 0);
    popMatrix();
  }


  void drawAxis() {
    pushMatrix();
  
      scale(8);
      strokeWeight(1);
    
      // x-axis, red
      stroke(100,0,0);
      line(0,0,0,1,0,0);
      
      // y-axis, green
      stroke(0,100,0);
      line(0,0,0,0,1,0);
      
      // z-axis, blue
      stroke(0,0,100);
      line(0,0,0,0,0,1);
  
    popMatrix();
  }

}

