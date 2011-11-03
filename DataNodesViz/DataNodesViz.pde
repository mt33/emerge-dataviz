/**
 * DataNodesViz v0.1 – Alpha sketches
 * Matthieu Tremblay
 * 
 */

import peasy.*;

import datanetwork.*;	//import the datanetwork pacakage
import datanetwork.javaosc.OSCMessage;	//required for dnEvent(OSCMessages message)


int NUM_DATA_NODES = 10;
DataNode dataNodes[] = new DataNode[ NUM_DATA_NODES ];
int DATA_NODE_SPACING = 16;
int dataNodesWidth;

PeasyCam cam;
BufferedReader reader;
String line;

PFont font;
boolean paused = true;

DNConnection dn;	//DNConnection
//DNNode node;	//DNNode

/* ------------------------------- */
void setup()  { 
  
  size(1200, 600, P3D); 
  frameRate(60);
  
  font = loadFont("Monaco-48.vlw");
  textFont(font, 12);

  dataNodesWidth = int( (NUM_DATA_NODES-1) * DATA_NODE_SPACING );

  cam = new PeasyCam(this, dataNodesWidth/2,-5,0,80);
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(500);

  ambientLight(150, 150, 150, 0 , 50, 0);
  strokeWeight(1);
  colorMode(RGB, 100); 
  noFill();  

  // to read accel data
//  reader = createReader("session2_minibees.txt"); 
  
  	//Create a DNConnection.  Parameters are IP, outgoing port, incoming port, client name.
  dn = new DNConnection(this, "127.0.0.1", dn.getServerPort("127.0.0.1"), 6009, "p5Client");
  dn.setVerbo(2);	//set the verbosity to receive all messages but server pings.
  dn.register();	//register the client on the network.  Can be done anytime.

  createDataNodes();
} 

void dnEvent(OSCMessage message) {
//	println("OSCMessage: " + message.getAddress());
}

void dnEvent(String addr, String[] args) {
//	println("String: '" + addr + "' with " + args.length + " arguments as Strings");
}


void dnEvent(String addr, float[] args) {
//  println("Float: '" + addr + "' with " + args.length + " arguments as floats");
  if ( addr.equals( "/data/node" ) ){
    
//      for ( int i=1; i<6; i++ ){
//        println( "data slot "  + i + " is " + args[i] );
//      }
      // assign the background color variables based on the data coming from the node:
    dataNodes[ (int) args[0] - 1 ].update( args[4]*2-1, args[5]*2-1, args[6]*2-1 );
    dataNodes[ (int) args[0] - 1 ].update2( args[1], args[2], args[3] );
//      println( "bgred " + bgred );
  }  
}

void createDataNodes() {
  for (int i = 0; i < dataNodes.length; i++) {
    dataNodes[i] = new DataNode(this, "node" + (i+1), i * DATA_NODE_SPACING, 0 , 0) ;
  }
}

void subscribeDataNodes() {
  for (int i = 0; i < dataNodes.length; i++) {
    dn.subscribeNode( i+1 );
  }
}

void draw()  {
  background(0);
//  drawRoom();

  drawDataNodes();
} 

void drawRoom() {
  fill( 20, 20, 20, 100); // greyish fill
  stroke(100, 100, 100, 50); // white stroke
    
  pushMatrix();

    translate( 1, 20, -dataNodesWidth/4); // move "down" a bit, below the data nodes
    scale(dataNodesWidth, 1, dataNodesWidth/1.5);
    rotateX( PI/2 );

    beginShape();
      vertex(0, 0, 0);
      vertex(1, 0, 0);
      vertex(1, 1 ,0);
      vertex(0, 1, 0);
    endShape(CLOSE);
    
  popMatrix();
}

void drawDataNodes() {
  for (int i = 0; i < dataNodes.length; i++) {
    dataNodes[i].display();
  }
}



/*
void readAccelerometerData() {

  int index = 0;
  String node = "";
  float x, y, z;
  
  // go through the text file
  try {
    line = reader.readLine();
  } catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  
  if (line == null)  {
    // Stop reading because of an error or file is empty
    noLoop();  
  } else {
    // break up the line into an array of pieces delimited by a space
    String[] pieces = split(line, " " );
    
    // the minibee node is indicated here
    node = pieces[3];
    //print( "Trying to match " + node) ;
    String[][] m = matchAll(node, "([0-9]+)");

    if ( m[1][1] != null) {
      //println ( ", " + m[1][1]);
      index = int(m[1][1]);
    }
 
    // grab the last 3 pieces which are xyz accel data points      
    x = float( pieces[ 5 ] ) / 512;
    y = float( pieces[ 6 ] ) / 512;
    z = float( pieces[ 7 ] ) / 512;
      
    dataNodes[index-1].update( x, y, z );
    println( "Updating dataNode " + index + " with magnitude " + dataNodes[index-1].magnitude );
  }
}
*/


void keyPressed(  ) {
  // play/pause
  if (key == ' ' && paused) {
    paused = false;
  } else if (key == ' ' && !paused) {
    paused = true;
  } else if(key == 's') { 
    subscribeDataNodes();
  }
}
