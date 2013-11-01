// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Demonstration of Craig Reynolds' "Wandering" behavior
// See: http://www.red3d.com/cwr/

// Click mouse to turn on and off rendering of the wander circle

int NO_ELEMENTS = 10;
float NEIGHBOR_DIST = 50;
ArrayList<Vehicle> collective;
float dist[];
boolean debug = false;

void setup() {
  size(1024, 768);
  
  dist = new float[NO_ELEMENTS * (NO_ELEMENTS+1) / 2];
  collective = new ArrayList<Vehicle>();
  for (int i = 0; i < NO_ELEMENTS; ++i) {
    collective.add(new Vehicle(random(width), random(height),
                   (int) random(255), (int) random(255), (int) random(255)));
  }
}

void draw() {
  background(0);
  
  if (random(50) < 1) {
    Vehicle v = collective.get((int) random(NO_ELEMENTS));
    v.red = (int) random(255);
    v.green = (int) random(255);
    v.blue = (int) random(255);
  }
  
  calcDist();
  exchangeInfo();
  
  for (Vehicle wanderer : collective) {
    wanderer.wander();
    wanderer.run();
    if (debug) wanderer.drawCircleAround(NEIGHBOR_DIST);
  }
}

void mousePressed() {
  debug = !debug;
}

void calcDist() {
  int ix = 0;
  for (int i = 0; i < NO_ELEMENTS; ++i) {
    Vehicle v1 = collective.get(i);
    for (int j = i + 1; j < NO_ELEMENTS; ++j) {
      Vehicle v2 = collective.get(j);
      float d = v1.location.dist(v2.location);
      dist[ix++] = d;
    }
  } 
}

void exchangeInfo() {
  int ix = 0;
  for (int i = 0; i < NO_ELEMENTS; ++i) {
    for (int j = i + 1; j < NO_ELEMENTS; ++j) {
      if (dist[ix++] < NEIGHBOR_DIST) {
        Vehicle v1 = collective.get(i);
        Vehicle v2 = collective.get(j);
        
        v1.drawCircleAround(NEIGHBOR_DIST);
        v2.drawCircleAround(NEIGHBOR_DIST);

        if (random(2) < 1) {
          exchangeInfo(v1, v2);
        } else {
          exchangeInfo(v2, v1);
        }        
      }
    }
  } 
}

void exchangeInfo(Vehicle v1, Vehicle v2) {
  float r = random(4);
  switch ((int) r) {
    case 0:
      v2.red = v1.red;
      break;
    case 1:
      v2.green = v1.green;
      break;
    case 2:
      v2.blue = v1.blue;
      break;
    default:
  }
}
