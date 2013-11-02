// an info exchange strategy where RGB values are exchanged between peers

class RandomExchangeStrategy implements ExchangeStrategy {
  void exchangeInfo(PeerStrategy peerStrat, Vehicle v1, Vehicle v2, Relation r) {
      if (peerStrat.isPeer(v1, v2, r)) {
        if (!r.inExchange) {
          // push or pull?
          if (random(2) < 1) {
            exchangeInfo(v1, v2);
          } else {
            exchangeInfo(v2, v1);
          }
          r.inExchange = true;
        }        
      } else if (r.inExchange) {
        r.inExchange = false;
      }      
  }


  void exchangeInfo(Vehicle v1, Vehicle v2) {
    Object keys[] = v1.state.keySet().toArray();
    float r = random(keys.length + 1);
    if (r < keys.length) {
      String key = (String) keys[(int) r];
      v2.state.put(key, v1.state.get(key));
    }
  }

  
};

