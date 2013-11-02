// a distance-based peer strategy

class DistancePeerStrategy implements PeerStrategy {
  float maxDistance;
  
  DistancePeerStrategy() {
    maxDistance = Float.MAX_VALUE;
  }
  
  DistancePeerStrategy(float maxDist) {
    maxDistance = maxDist;
  }
  
  boolean isPeer(Vehicle v1, Vehicle v2, Relation r) {
    return r.distance < maxDistance;  
  }
};
