import java.util.TreeMap;

class Vehicle {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float wandertheta;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

  TreeMap<String, Object> state;
  ArrayList<String> highlights;
  int highlightEnd;
  
  
  PShape shape;


  Vehicle(PShape shape, float x, float y) {
    this.shape = shape;
    
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    location = new PVector(x,y);
    wandertheta = 0;
    maxspeed = 2;
    maxforce = 0.05;
    
    state = new TreeMap<String, Object>();
    highlights = new ArrayList<String>();
    highlightEnd = 0;
  }
  
  void randomizeState() {
    state.put("red", (float) random(255));
    state.put("green", (float) random(255));
    state.put("blue", (float) random(255));
    state.put("a", (float) random(255));
    state.put("b", (float) random(255));
    state.put("c", (float) random(255));
    
    highlights.clear();
    highlights.addAll(state.keySet());
    highlightEnd = millis() + 2000;
  }

  void run() {
    update();
    borders();
    display();
  }

  // Method to update location
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  void wander() {
    float wanderR = 25;         // Radius for our "wander circle"
    float wanderD = 80;         // Distance for our "wander circle"
    float change = 0.3;
    wandertheta += random(-change,change);     // Randomly change wander theta

    // Now we have to calculate the new location to steer towards on the wander circle
    PVector circleloc = velocity.get();    // Start with velocity
    circleloc.normalize();            // Normalize to get heading
    circleloc.mult(wanderD);          // Multiply by distance
    circleloc.add(location);               // Make it relative to boid's location
    
    float h = velocity.heading2D();        // We need to know the heading to offset wandertheta

    PVector circleOffSet = new PVector(wanderR*cos(wandertheta+h),wanderR*sin(wandertheta+h));
    PVector target = PVector.add(circleloc,circleOffSet);
    seek(target);

    // Render wandering circle, etc. 
    if (debug) drawWanderStuff(location,circleloc,target,wanderR);
  }  

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }


  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  void seek(PVector target) {
    PVector desired = PVector.sub(target,location);  // A vector pointing from the location to the target

    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  // Limit to maximum steering force

    applyForce(steer);
  }

  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    
    float red = (Float) state.get("red");
    float green = (Float) state.get("green");
    float blue = (Float) state.get("blue");
    float r = (Float) state.get("r");
    float strokeWidth = (Float) state.get("width");
    
    fill(red, green, blue);
    stroke(255 - red, 255 - green, 255 - blue);
    strokeWeight(strokeWidth);
    pushMatrix();
    translate(location.x,location.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
    
    // reset stroke weight
    strokeWeight(1);
  }

  // Wraparound
  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }

  void drawCircleAround(float rad) {
    stroke(255); 
    noFill();
    ellipseMode(CENTER);
    ellipse(location.x, location.y, rad*2, rad*2);
  }
}


// A method just to draw the circle associated with wandering
void drawWanderStuff(PVector location, PVector circle, PVector target, float rad) {
  stroke(255); 
  noFill();
  ellipseMode(CENTER);
  ellipse(circle.x,circle.y,rad*2,rad*2);
  ellipse(target.x,target.y,4,4);
  line(location.x,location.y,circle.x,circle.y);
  line(circle.x,circle.y,target.x,target.y);
}



