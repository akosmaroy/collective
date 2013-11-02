/**
 *  A triangular matrix single-array representation without the diagonal.
 *  useful for storing symmetrical relationships, like distance, etc.
 */
class TriangularMatrix<E> {
  ArrayList<E> values;
  
  TriangularMatrix(int size) {
    int s = (size - 1) * size / 2;
    values = new ArrayList<E>(s);
    // populate the array list to the specified size
    while (s-- > 0) {
      values.add(null);
    }
  }

  int calcIndex(int x, int y) {
    // make sure x > y
    if (x < y) {
      int i = x;
      x = y;
      y = i;
    }
    
    return x * (x - 1) / 2 + y;
  }    
  
  /**
   *  Set a value between two indexes
   *
   *  @param x one of the indexes
   *  @param y the other index
   *  @param value the value to set
   *  @return the old value for the index
   */
  E set(int x, int y, E value) {
    int ix = calcIndex(x, y);
    
    E ret = values.get(ix);
    values.set(ix, value);
   
   return ret; 
  }
  
  /**
   *  Get a value for two indexes
   *
   *  @param x one of the indexes
   *  @param y the other index
   *  @return the value for the index
   */
  E get(int x, int y) {
    int ix = calcIndex(x, y);
    return values.get(ix);
  }
  
  
};
