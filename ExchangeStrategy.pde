// base strategy to manag exchanging info between peers

interface ExchangeStrategy {
  void exchangeInfo(PeerStrategy peerStrat, Vehicle v1, Vehicle v2, Relation r);
};

