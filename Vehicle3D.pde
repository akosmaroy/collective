class Vehicle3D extends Vehicle {

  Vehicle3D(PShape shape, float x, float y) {
    super(shape, x, y);
  }

  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    
    float red = (Float) state.get("red");
    float green = (Float) state.get("green");
    float blue = (Float) state.get("blue");
    
    hint(DISABLE_DEPTH_TEST); // avoids z-fighting
    
    pushMatrix();
    
    stroke(red, green, blue);
    fill(red, green, blue, 128);
    translate(location.x, location.y, 0);
    rotate(theta);
    
    /*
    // this is the sphere display
    sphereDetail((int) res);
    sphere(r);
    */

    //drawShape();

    //drawBars(red, green, blue);
    
    // draw the radar chart
    Object v[] = state.values().toArray();
    float values[] = new float[v.length];
    for (int i = 0; i < state.values().size(); ++i) {
      values[i] = ((Float) v[i]) / 255.0;
    }
    
    drawRadarChart(values, 50);
    

    popMatrix();
    
    // reset stroke weight
    strokeWeight(1);    
  }
  
  /**
   *  Draw the shape of the vehicle.
   */
  void drawShape() {
    // this is the drop shape
    shapeMode(CENTER);
    shape(shape, 0, 0, 50, 50);
  }

  /**
   *  Draw the color bars of the vehicle.
   */
  void drawBars(float red, float green, float blue) {
    // the red one
    stroke(red, 0, 0, red);
    fill(red, 0, 0, red);
    beginShape();
    vertex(-35, 2); 
    vertex(-22, 2); 
    vertex(-22, 4); 
    vertex(-35, 4);
    endShape(CLOSE); 

    // the green one
    stroke(0, green, 0, green);
    fill(0, green, 0, green);
    beginShape();
    vertex(-35, 6); 
    vertex(-22, 6); 
    vertex(-22, 8); 
    vertex(-35, 8);
    endShape(CLOSE); 

    // the blue one
    stroke(0, 0, blue, blue);
    fill(0, 0, blue, blue);
    beginShape();
    vertex(-35, 10); 
    vertex(-22, 10); 
    vertex(-22, 12); 
    vertex(-35, 12);
    endShape(CLOSE); 
  }
  
  /**
   *  Draw a radar chart, with the specified radius.
   *
   *  @param values the values to draw, which are normalized between 0..1
   *  @param r the radius of the chart
   */
  void drawRadarChart(float[] values, float r) {
    float theta = TWO_PI / values.length;
    
    strokeWeight(2);
    stroke(0, 177, 255, 255);
    fill(0, 0, 0, 0);

    // draw the radar chart as splines    
    beginShape();
    float alpha = 0;
    // overindexing so that the curve is closed
    for (int i = 0; i < values.length + 3; ++i, alpha += theta) {
      float v = values[i % values.length] * r;
      float x = sin(alpha) * v;
      float y = -cos(alpha) * v;
      
      curveVertex(x, y);
    }
    endShape();
    
    // draw the value axes
    strokeWeight(1);
    stroke(150, 150, 150, 150);
    beginShape(LINES);
    alpha = 0;
    for (int i = 0; i < values.length; ++i, alpha += theta) {
      float x = sin(alpha) * r;
      float y = -cos(alpha) * r;
      
      vertex(0, 0);
      vertex(x, y);
    }
    endShape();
    
    // draw concentric circles as guides
    strokeWeight(0.5);
    stroke(150, 150, 150, 150);
    fill(0, 0, 0, 0); 
    for (int i = 0; i <= 5; ++i) {
      float s = 2 * r * ((float) i) / 5;
      ellipse(0, 0, s, s); 
    }
    
  }
}


