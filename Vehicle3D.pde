class Vehicle3D extends Vehicle {

  Vehicle3D(PShape shape, float x, float y) {
    super(shape, x, y);
  }

  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    
    float red = (Float) state.get("red");
    float green = (Float) state.get("green");
    float blue = (Float) state.get("blue");
    
    hint(DISABLE_DEPTH_TEST); // avoids z-fighting
    
    pushMatrix();
    
    stroke(red, green, blue);
    fill(red, green, blue, 128);
    translate(location.x, location.y, 0);
    rotate(theta);
    
    /*
    // this is the sphere display
    sphereDetail((int) res);
    sphere(r);
    */
    
    // this is the drop shape
    shapeMode(CENTER);
    shape(shape, 0, 0, 50, 50);
    
    // these are the bar indicators to the left
    // the red one
    stroke(red, 0, 0, red);
    fill(red, 0, 0, red);
    beginShape();
    vertex(-35, 2); 
    vertex(-22, 2); 
    vertex(-22, 4); 
    vertex(-35, 4);
    endShape(CLOSE); 

    // the green one
    stroke(0, green, 0, green);
    fill(0, green, 0, green);
    beginShape();
    vertex(-35, 6); 
    vertex(-22, 6); 
    vertex(-22, 8); 
    vertex(-35, 8);
    endShape(CLOSE); 

    // the blue one
    stroke(0, 0, blue, blue);
    fill(0, 0, blue, blue);
    beginShape();
    vertex(-35, 10); 
    vertex(-22, 10); 
    vertex(-22, 12); 
    vertex(-35, 12);
    endShape(CLOSE); 

    popMatrix();
    
    // reset stroke weight
    strokeWeight(1);    
  }
}


