import peasy.*;

int NO_ELEMENTS = 15;
float NEIGHBOR_DIST = 50;

ArrayList<Vehicle> collective;
TriangularMatrix<Relation> relations;

PeerStrategy peerStrat;
ExchangeStrategy exStrat;

PeasyCam camera;

boolean debug = false;

void setup() {
  size(1024, 768, OPENGL);
  if (frame != null) {
    frame.setResizable(true);
  }
  
  camera = new PeasyCam(this, width/2, height/2, 0, 1000);
  camera.setMinimumDistance(1);
  camera.setMaximumDistance(10000);
  camera.setResetOnDoubleClick(false);
  
  relations = new TriangularMatrix<Relation>(NO_ELEMENTS);
  for (int i = 0; i < NO_ELEMENTS; ++i) {
    for (int j = i + 1; j < NO_ELEMENTS; ++j) {
      relations.set(i, j, new Relation());
    }
  }
  
  PShape shape = loadShape("vehicle.svg");
      
  collective = new ArrayList<Vehicle>();
  for (int i = 0; i < NO_ELEMENTS; ++i) {
    Vehicle3D v = new Vehicle3D(shape, random(width), random(height));
    v.randomizeState();
    
    collective.add(v);
  }
  
  peerStrat = new DistancePeerStrategy(NEIGHBOR_DIST);
  exStrat = new RandomExchangeStrategy();
}


void draw() {
  directionalLight(255, 255, 255,   // color
                   0, 0, -1);        // direction
  directionalLight(128, 128, 128,   // color
                   1, 0, 0);        // direction
  
  background(51);
  drawGrid();

  // randomlize an entity every once in a while  
  if (random(50) < 1) {
    Vehicle v = collective.get((int) random(NO_ELEMENTS));
    v.randomizeState();
    
    v.drawCircleAround(NEIGHBOR_DIST / 2);    
  }
  
  updateRelations();
  exchangeInfo();
  
  for (Vehicle wanderer : collective) {
    wanderer.wander();
    wanderer.run();
    if (debug) wanderer.drawCircleAround(NEIGHBOR_DIST);
  }
}

void drawGrid() {
  // draw a grid
  int wStep = width / 10;
  int hStep = height / 10;
  
  pushMatrix();
  noFill();
  stroke(128, 128);
  strokeWeight(1);
  beginShape(LINES);
  for (int i = 0; i < width; i += wStep) {
    vertex(i, 0, 0);
    vertex(i, height, 0);
  } 
  for (int i = 0; i < height; i += hStep) {
    vertex(0, i, 0);
    vertex(width, i, 0);
  } 
  endShape();
  popMatrix();
}

void keyPressed() {
  switch (keyCode) {
    case ' ':
      camera.reset();
      break;
    default:
  }
}

void updateRelations() {
  for (int i = 0; i < NO_ELEMENTS; ++i) {
    Vehicle v1 = collective.get(i);
    for (int j = i + 1; j < NO_ELEMENTS; ++j) {
      Vehicle v2 = collective.get(j);
      float d = v1.location.dist(v2.location);
      relations.get(i, j).distance = d;
    }
  } 
}

void exchangeInfo() {
  for (int i = 0; i < NO_ELEMENTS; ++i) {
    for (int j = i + 1; j < NO_ELEMENTS; ++j) {
      Vehicle v1 = collective.get(i);
      Vehicle v2 = collective.get(j);
      Relation r = relations.get(i, j);
      
      exStrat.exchangeInfo(peerStrat, v1, v2, r);
      
      if (r.inExchange) {
        v1.drawCircleAround(NEIGHBOR_DIST);
        v2.drawCircleAround(NEIGHBOR_DIST);
      }      
    }
  }
}

