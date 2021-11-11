import processing.serial.*;

Serial myPort;
String val="";


float inc = .3, f=0;
float scl = 50;
int cols, rows;
float zoff = 0;
Particle[] particles;
PVector[] flowField;

int savedTime;
int totalTime = 5000;


void setup()
{
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 115200);
  
  
  
  
 
  
  colorMode(RGB, 255);
  //size(800, 600, P2D);
  cols = floor(width / scl);
  rows = floor(height / scl);
  
  particles = new Particle[100000];
  for(int i = 0; i < particles.length; ++i)
    particles[i] = new Particle();
    
  flowField = new PVector[cols * rows];
  
  background(255);
}

public void settings() {
  size(1900, 1000, "processing.opengl.PGraphics2D");
}

void draw()
{
 
  
  
  if ( myPort.available() > 0 ) 
  {  // If data is available,
     val = myPort.readStringUntil('\n');         // read it and store it in val
     
     if(val!=null){f = float(val);} 
} 
  
   //println(f);

  
  float yoff = 0;
  for(int y = 0; y < rows; y++) {
    float xoff = 0;
    for(int x = 0; x < cols; x++) {
      // set the vector in the flow field
      int index = x + y * cols; 
      float angle = noise(xoff, yoff, zoff) * TWO_PI  ;
      PVector v = PVector.fromAngle(angle);
      v.setMag(3); // set the power of the field on the particle
      flowField[index] = v;
      
      xoff += inc;
    }
    yoff += inc;
    zoff += 0.0001; // rate the flow field changes
  }
  
  // update and draw the particles
  for(int i = 0; i < particles.length; ++i) {
    particles[i].follow(flowField);
    particles[i].update(f);
    particles[i].show();
   }
   
   
   //saving image
   if(key=='s' || key=='S'){save("img.jpg");}
}
