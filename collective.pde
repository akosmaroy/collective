// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Demonstration of Craig Reynolds' "Wandering" behavior
// See: http://www.red3d.com/cwr/

// Click mouse to turn on and off rendering of the wander circle

ArrayList<Vehicle> collective;
boolean debug = false;

void setup() {
  size(1024, 768);
  
  collective = new ArrayList<Vehicle>();
  for (int i = 0; i < 10; ++i) {
    collective.add(new Vehicle(width/(i+1),height/(i+1)));
  }
}

void draw() {
  background(255);
  for (Vehicle wanderer : collective) {
    wanderer.wander();
    wanderer.run();
  }
}

void mousePressed() {
  debug = !debug;
}


