class Box {
  
  //For positioning and drawing
  int len;
  PVector pos;
  float r;
  
  color pink = color(255, 166, 201);
  
  Box(int x, int y, int z, int len) {
    pos = new PVector(x, y, z);
    this.len = len;
    r = len / 2;
  }
  
  //Draw a black square on the top of a cube
  void draw_top(color col, boolean draw) {
    if (draw) {
      fill(col);
      stroke(0);
    } else {
      noFill();
      noStroke();
    }
    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    beginShape(QUADS);
    
    //Top
    vertex(-r, -r, -r);
    vertex(r, -r, -r);
    vertex(r, -r, r);
    vertex(-r, -r, r);
    
    endShape();
    popMatrix();
  }
  
  //Draw a black square on the bottom of a cube
  void draw_bottom(color col, boolean draw) {
    if (draw) {
      fill(col);
      stroke(0);
    } else {
      noFill();
      noStroke();
    }
    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    beginShape(QUADS);
    
    //Bottom
    vertex(-r, r, -r);
    vertex(r, r, -r);
    vertex(r, r, r);
    vertex(-r, r, r);
    
    endShape();
    popMatrix();
  }
  
  //Draw a black square on the left of a cube
  void draw_left(color col, boolean draw) {
    if (draw) {
      fill(col);
      stroke(0);
    } else {
      noFill();
      noStroke();
    }
    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    beginShape(QUADS);
    
    //Left
    vertex(-r, -r, -r);
    vertex(-r, r, -r);
    vertex(-r, r, r);
    vertex(-r, -r, r);
    
    endShape();
    popMatrix();
  }
  
  //Draw a black square on the right of a cube
  void draw_right(color col, boolean draw) {
    if (draw) {
      fill(col);
      stroke(0);
    } else {
      noFill();
      noStroke();
    }
    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    beginShape(QUADS);
    
    //Right
    vertex(r, -r, -r);
    vertex(r, r, -r);
    vertex(r, r, r);
    vertex(r, -r, r);
    
    endShape();
    popMatrix();
  }
  
  //Draw a black square on the front of a cube
  void draw_front(color col, boolean draw) {
    if (draw) {
      fill(col);
      stroke(0);
    } else {
      noFill();
      noStroke();
    }
    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    beginShape(QUADS);
    
    //Front
    vertex(-r, -r, r);
    vertex(r, -r, r);
    vertex(r, r, r);
    vertex(-r, r, r);
    
    endShape();
    popMatrix();
  }
  
  //Draw a black square on the front of a cube
  void draw_back(color col, boolean draw) {
    if (draw) {
      fill(col);
      stroke(0);
    } else {
      noFill();
      noStroke();
    }
    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    beginShape(QUADS);
    
    //Back
    vertex(-r, -r, -r);
    vertex(r, -r, -r);
    vertex(r, r, -r);
    vertex(-r, r, -r);
    
    endShape();
    popMatrix();
  }
  
  void draw_red() {
    stroke(0);
    fill(color(255, 0, 0));
    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    beginShape(QUADS);
    
    //Back
    vertex(-r, -r, -r);
    vertex(r, -r, -r);
    vertex(r, r, -r);
    vertex(-r, r, -r);
    
    //Front
    vertex(-r, -r, r);
    vertex(r, -r, r);
    vertex(r, r, r);
    vertex(-r, r, r);
    
    //Bottom
    vertex(-r, r, -r);
    vertex(r, r, -r);
    vertex(r, r, r);
    vertex(-r, r, r);
    
    //Top
    vertex(-r, -r, -r);
    vertex(r, -r, -r);
    vertex(r, -r, r);
    vertex(-r, -r, r);
    
    //Left
    vertex(-r, -r, -r);
    vertex(-r, r, -r);
    vertex(-r, r, r);
    vertex(-r, -r, r);
    
    //Right
    vertex(r, -r, -r);
    vertex(r, r, -r);
    vertex(r, r, r);
    vertex(r, -r, r);
    
    endShape();
    popMatrix();
    
  }
  
  
}
