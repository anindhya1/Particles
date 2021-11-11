class Particle {
  PVector posInit = new PVector(random(width-1), random(height-1)); // position
  PVector vel = new PVector(0, 0); // velocity
  PVector acc = new PVector(0, 0); // acceleration
  PVector pos = posInit.copy(); // position
  PVector prevPos = pos.copy(); // previous position
  float maxSpeed = 8, maxForce = 2;
  float h = 180;
  float l, m, x=255, y=255, z=255;
  float alpha=10, step=15;
  
  void update(float l) {
    
    //if(alpha<0)
    //{
    //alpha = 1;
    ////posInit = new PVector(random(width), random(height));
    //}
    
    
    
    // keep current position
    prevPos.x = pos.x;                                
    prevPos.y = pos.y; 
    
    // apply acceleration and velocitiy
    vel.add(acc); 
    vel.limit(maxSpeed); // limit velocity
    pos.add(vel); 
    
    // handle window edges
    if(pos.x >= width || pos.y >= height) {pos.x = prevPos.x = constrain(posInit.x + (int)random(step*2)-step, 0, width-1); pos.y = prevPos.y = constrain(posInit.y + (int)random(step*2)-step, 0, height-1);}
                                                                                                                       //prevPos.x = constrain(posInit.x + (int)random(alpha*2)-alpha, 0, width-1);
    
    if(pos.x < 0 || pos.y < 0) {pos.x = prevPos.x = (int)random(width-1);pos.y = prevPos.y = (int)random(height-1);setcolor(l); } //prevPos.y = constrain(posInit.y + (int)random(alpha*2)-alpha, 0, height-1);
    
    //setcolor(l);
    
    
    // reset acceleration
    acc.mult(0); 
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void show() {
    
    //setcolor(l);
    
    if(alpha<0){alpha=10;m=l;update(m);}
    else{
    stroke(x, y, z, alpha);
    //alpha = alpha -.1;
    
    //h = h + .5;
    //if(h > 255){h=180;}
    strokeWeight(1);
    line(pos.x, pos.y, prevPos.x, prevPos.y);
    prevPos.set(pos);
    }
}

//void showred() {
//    stroke(random(200, 255), random(0, 115), random(147, 255), 10);
//    strokeWeight(.5);
//    line(prevPos.x, prevPos.y, pos.x, pos.y);
//    prevPos.set(pos);
//}

//void showwhite() {
//    stroke(255, 255, 255, 10);
//    strokeWeight(.5);
//    line(prevPos.x, prevPos.y, pos.x, pos.y);
//    prevPos.set(pos);
//}

  void setcolor(float l)
  {
   // println(l);
    if(l<=70 && l>58){x=y=z=255;}
    if(l>80 && l<=90){x=0; y=random(0,255); z=random(205,255);}
    //x=0; y=random(128,255); z=random(128,255);}
    if(l>70 && l<=80){x=random(148,255);  y=random(192); z=random(192,255);}
    if(l<58 || l>90) {x=0; y=random(0,255); z=random(205,255);}
   // x=0; y=random(128,255); z=random(128,255);
  }
  
  void follow(PVector[] flowField) {
    // get the index in the flow field
    int x = floor(pos.x / scl);
    int y = floor(pos.y / scl);
    int index = x + y * cols;
    
    
    // get the force and apply it
    PVector force = flowField[index];
    applyForce(force);
    //force.mult(maxSpeed);
    //// Steering is desired minus velocity
    //PVector steer = PVector.sub(force, vel);
    //steer.limit(maxForce);  // Limit to maximum steering force
    //applyForce(steer);
  }
}


  
