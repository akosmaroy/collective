// base strategy to determine if vehicles are peers

interface PeerStrategy {
  boolean isPeer(Vehicle v1, Vehicle v2, Relation r);
};
