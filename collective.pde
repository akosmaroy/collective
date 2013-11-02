// Click mouse to turn on and off debug visualization

int NO_ELEMENTS = 10;
float NEIGHBOR_DIST = 50;

ArrayList<Vehicle> collective;
TriangularMatrix<Relation> relations;

PeerStrategy peerStrat;
ExchangeStrategy exStrat;

boolean debug = false;

void setup() {
  size(1024, 768);
  
  relations = new TriangularMatrix<Relation>(NO_ELEMENTS);
  for (int i = 0; i < NO_ELEMENTS; ++i) {
    for (int j = i + 1; j < NO_ELEMENTS; ++j) {
      relations.set(i, j, new Relation());
    }
  }
      
  collective = new ArrayList<Vehicle>();
  for (int i = 0; i < NO_ELEMENTS; ++i) {
    Vehicle v = new Vehicle(random(width), random(height));
    v.state.put("red", (float) random(255));
    v.state.put("green", (float) random(255));
    v.state.put("blue", (float) random(255));
    v.state.put("r", (float) random(15));
    
    collective.add(v);
  }
  
  peerStrat = new DistancePeerStrategy(NEIGHBOR_DIST);
  exStrat = new RandomExchangeStrategy();
}

void draw() {
  background(0);
  
  if (random(50) < 1) {
    Vehicle v = collective.get((int) random(NO_ELEMENTS));
    v.state.put("red", (float) random(255));
    v.state.put("green", (float) random(255));
    v.state.put("blue", (float) random(255));
    v.state.put("r", (float) random(15));
    
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

void mousePressed() {
  debug = !debug;
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


