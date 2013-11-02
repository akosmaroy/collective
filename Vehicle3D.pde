class Vehicle3D extends Vehicle {

  Vehicle3D(float x, float y) {
    super(x, y);
  }

  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    
    float red = (Float) state.get("red");
    float green = (Float) state.get("green");
    float blue = (Float) state.get("blue");
    float r = (Float) state.get("r");
    float res = (Float) state.get("res");
    
    stroke(red, green, blue);
    fill(red, green, blue, 128);
    pushMatrix();
    translate(location.x, location.y, 0);
    rotate(theta);
    sphereDetail((int) res);
    sphere(r);
    popMatrix();
    
    // reset stroke weight
    strokeWeight(1);
  }
}


