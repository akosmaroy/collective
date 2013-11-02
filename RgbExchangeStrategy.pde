// an info exchange strategy where RGB values are exchanged between peers

class RgbExchangeStrategy implements ExchangeStrategy {
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

  
};

