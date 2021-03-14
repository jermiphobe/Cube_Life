import peasy.*; //<>//

int dim = 20;
int len;
int iteration = 1;

//For 2D and visualizing finding neighbors
boolean flat = false;
boolean visualize = false;

Cube cube;
PeasyCam cam;

//To determine if it will be 2D or 3D
void settings() {
  if (flat) {
    size(900, 900);
    len = (width - 40) / (dim * 4);
  } else {

    size(800, 800, P3D);
    //fullScreen(P3D);
    len = (width / 2) / dim;
  }
}

//Create the cube object
void setup() {
  cube = new Cube(dim, len);
  if (!flat) {
    cam = new PeasyCam(this, 800);
  }
}

void draw() {
  //Will draw the 2D version
  if (flat) {
    //Will let you iterate through finding neighbors
    if (visualize) {
      background(200);
      cube.draw_2D();
    } else {
      if (iteration % 20 == 0) {
        background(200);
        cube.draw_2D();
        cube.update_boards();
      }
    }
    
    //Draw the cube version
  } else {
    rotateY(PI / 6);
    
     //Will let you iterate through finding neighbors
    if (visualize) {
      background(200);
      cube.draw_cube();
    } else {
       background(200);
       cube.draw_cube();
      if (iteration % 20 == 0) {
        cube.update_boards();
      }
    }
  }
  
  iteration += 1;
  
}

void keyTyped() {
  if (key == 32 && flat == true) {
    visualize = !visualize;
    cube.toggle_visualize();
  } else {
    cube.display_neighbors();
  }
  
}
