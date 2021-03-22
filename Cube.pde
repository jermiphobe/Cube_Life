class Cube {
  int dim;
  int len; 
  
  //For clear mode
  boolean clear = false;
  
  //The final 2-dimensional arrays to hold the boards
  ArrayList<ArrayList<int[]>> front = new ArrayList<ArrayList<int[]>>();
  ArrayList<ArrayList<int[]>> top = new ArrayList<ArrayList<int[]>>();
  ArrayList<ArrayList<int[]>> back = new ArrayList<ArrayList<int[]>>();
  ArrayList<ArrayList<int[]>> bottom = new ArrayList<ArrayList<int[]>>();
  ArrayList<ArrayList<int[]>> left = new ArrayList<ArrayList<int[]>>();
  ArrayList<ArrayList<int[]>> right = new ArrayList<ArrayList<int[]>>();
  
  //Array to hold the cube
  Box[][][] cube;
  
  //----- For visualizing neighbors --------//
  
  int tmp_x = 0;
  int tmp_y = 0;
  boolean visualize = false;
  boolean started = false;
  ArrayList<ArrayList<int[]>> visualize_board;
  int position;
  
  //---------------------------------------------//
  
  Cube(int dimension, int len) {
    dim = dimension;
    this.len = len;
    
    //For the positioning/centering of each box in the cube
    int offset = (dim - 1) * len / 2;
    
    //Create the cube
    cube = new Box[dim][dim][dim];
    
    //Create the arrays -> 0, 0, 0 is the top/back/left corner
    for (int x = 0; x < dim; x += 1) { 
      for (int y = 0; y < dim; y += 1) {
        for (int z = 0; z < dim; z += 1) {
                   
          //Create a cube to put into the cube array
          Box box = new Box(x * len - offset, y * len - offset, z * len - offset, len);
          cube[x][y][z] = box;
          
        }
      }
    }
    
    //Create the 6 arrays
      //int[] -> [0] current state, [1] next state, [2] x pos, [3] y pos, [4] z pos, [5] neighbor count, 
      // [6] if currently finding neighbors for this square, [7] if it got checked as neighbor
    for (int x = 0; x < dim; x += 1) {
      ArrayList<int[]> tmp_front = new ArrayList<int[]>();
      ArrayList<int[]> tmp_top = new ArrayList<int[]>();
      ArrayList<int[]> tmp_back = new ArrayList<int[]>();
      ArrayList<int[]> tmp_bottom = new ArrayList<int[]>();
      ArrayList<int[]> tmp_left = new ArrayList<int[]>();
      ArrayList<int[]> tmp_right = new ArrayList<int[]>();
      
      for (int y = 0; y < dim; y += 1) {
        //Add to front
        int[] tmp = {0, (int)random(2), x, y, dim - 1, 0, 0, 0};
        tmp_front.add(tmp);
        
        //Add to back
        int new_x = ((dim - x) + dim) % dim;
        if (new_x == 0) {
          new_x = dim - 1;
        } else {
          new_x -= 1;
        }
        
        int[] tmp2 = {0, (int)random(2), new_x, y, 0, 0, 0, 0};
        tmp_back.add(tmp2);
        
        //Add to top
        int[] tmp3 = {0, (int)random(2), 0, y, x, 0, 0, 0};
        tmp_top.add(tmp3);
        
        //Add to bottom
        int new_z = ((dim - x) + dim) % dim;
        if (new_z == 0) {
          new_z = dim - 1;
        } else {
          new_z -= 1;
        }
        
        int[] tmp4 = {0, (int)random(2), dim - 1, y, new_z, 0, 0, 0};
        tmp_bottom.add(tmp4);
        
        //Add to left
        int[] tmp5 = {0, (int)random(2), x, 0, y, 0, 0, 0};
        tmp_left.add(tmp5);
        
        //Add to right
        new_z = ((dim - y) + dim) % dim;
        if (new_z == 0) {
          new_z = dim - 1;
        } else {
          new_z -= 1;
        }
        
        int[] tmp6 = {0, (int)random(2), x, dim - 1, new_z, 0, 0, 0};
        tmp_right.add(tmp6);
        
      } 
      //Add all temp arrays to main arrays
      front.add(tmp_front);
      back.add(tmp_back);
      top.add(tmp_top);
      bottom.add(tmp_bottom);
      left.add(tmp_left);
      right.add(tmp_right);
      
    }
    
  }
  
  //Go through each board and update it's next value based on it's neighbors
  void update_boards() {    
    //Update front
    update_board(front, 0);
    
    //Update back
    update_board(back, 1);
    
    //Update top
    update_board(top, 2);
    
    //Update bottom
    update_board(bottom, 3);
    
    //Update left
    update_board(left, 4);
    
    //Update right
    update_board(right, 5);
  }
  
  //Update a single board
  void update_board(ArrayList<ArrayList<int[]>> board, int pos) {
    //Loop through the grid
    for (int i = 0; i < dim; i += 1) {
      for (int j = 0; j < dim; j += 1) {
        int neighbors = 0;
        int[] curr = board.get(i).get(j);
        
        neighbors = count_neighbors(i, j, board, pos);      
        curr[5] = neighbors;
        
        //Set the next state
        if (curr[0] == 1 && (neighbors == 2 || neighbors == 3)) {
          curr[1] = 1;
        } else if (curr[0] == 0 && neighbors == 3) {
          curr[1] = 1;
        } else {
          curr[1] = 0;
        }
        
      }
    }// End of loop through grid
    
  }
  
  int count_neighbors(int i, int j, ArrayList<ArrayList<int[]>> board, int pos) {
   //int[] curr = board.get(i).get(j);
   int neighbors = 0;
        
    //Find neighbors//
    for (int x = -1; x < 2; x += 1) {
      for (int y = -1; y < 2; y += 1) {
        //Skip if current square
        if (x == 0 && y == 0) {
          continue;
        }
        
        //Find neighbor and check if alive
        int check_x = i + x;
        int check_y = j + y;
    
        //Skip if both x and y go off the board
        if ((check_x < 0 || check_x == dim) && (check_y < 0 || check_y == dim)) {
          continue;
        }
        
        //Figure out neighbor in other boards if x/y are off the grid
          // 1 = up, 2 = down, 3 = left, 4 = right
        //If goes above
        if (check_x < 0) {
          neighbors += find_neigh_top(check_y, pos);
          continue;
        }
        
        //If goes below
        if (check_x == dim) {
          neighbors += find_neigh_bottom(check_y, pos);
          continue;
        }
        
        //If goes left
        if (check_y < 0) {
          neighbors += find_neigh_left(check_x, pos);
          continue;
        }
        
        //If goes right
        if (check_y == dim) {
          neighbors += find_neigh_right(check_x, pos);
          continue;
        }
        
        //Indexes are on same board, so find neighbor and status
        int[] to_check = board.get(check_x).get(check_y);
        to_check[7] = 1;
        if (to_check[0] == 1) {
          neighbors += 1;
        }
        
      }
    }// End of find neighbors 
    
    return neighbors;
  }
  
  //Find neighbors that go off the top of the current board
  int find_neigh_top(int index, int pos) {
    int neighbor = 0;
      
    int[] neigh;
    if (pos == 0) {
      neigh = top.get(dim - 1).get(index);
    } else if (pos == 1) {
      neigh = bottom.get(dim - 1).get(index);
    } else if (pos == 2) {
      neigh = back.get(dim - 1).get(index);
    } else if (pos == 3) {
      neigh = front.get(dim - 1).get(index);
    } else if (pos == 4) {
      neigh = top.get(index).get(0);
    } else {
      index = ((dim - 1) - index);
      neigh = top.get(index).get(dim - 1);
    }
    
    neigh[7] = 1;
    neighbor = neigh[0];
 
    return neighbor;
  }
  
  //Find neighbors that go off the bottom of the current board
  int find_neigh_bottom(int index, int pos) {
    int neighbor = 0;
    
    int[] neigh;
    if (pos == 0) {
      neigh = bottom.get(0).get(index);
    } else if (pos == 1) {
      neigh = top.get(0).get(index);
    } else if (pos == 2) {
      neigh = front.get(0).get(index);
    } else if (pos == 3) {
      neigh = back.get(0).get(index);
    } else if (pos == 4) {
      index = ((dim - 1) - index);
      neigh = bottom.get(index).get(0);
    } else {
      neigh = bottom.get(index).get(dim - 1);
    }
    
    neigh[7] = 1;
    neighbor = neigh[0];
    
    return neighbor;
  }
  
  //Find neighbors that go off the left of the current board
  int find_neigh_left(int index, int pos) {
    int neighbor = 0;
 
    int[] neigh;
    if (pos == 0) {
      neigh = left.get(index).get(dim - 1);
    } else if (pos == 1) {
      index = ((dim - 1) - index);
      neigh = left.get(index).get(0);
    } else if (pos == 2) {
      neigh = left.get(0).get(index);
    } else if (pos == 3) {
      index = ((dim - 1) - index);
      neigh = left.get(dim - 1).get(index);
    } else if (pos == 4) {
      index = ((dim - 1) - index);
      neigh = back.get(index).get(0);
    } else {
      neigh = front.get(index).get(dim - 1);
    }
    
    neigh[7] = 1;
    neighbor = neigh[0];

    return neighbor;
  }
  
  //Find neighbors that go off the right of the current board
  int find_neigh_right(int index, int pos) {
    int neighbor = 0;

    int[] neigh;
    if (pos == 0) {
      neigh = right.get(index).get(0);
    } else if (pos == 1) {
      index = ((dim - 1) - index);
      neigh = right.get(index).get(dim - 1);
    } else if (pos == 2) {
      index = ((dim - 1) - index);
      neigh = right.get(0).get(index);
    } else if (pos == 3) {
      neigh = right.get(dim - 1).get(index);
    } else if (pos == 4) {
      neigh = front.get(index).get(0);
    } else {
      neigh = back.get(index).get(dim - 1);
    }
    
    neigh[7] = 1;
    neighbor = neigh[0];
    
    return neighbor;
  }
  
  //Loop through each board and set/draw the appropriate box object in the cube
  void draw_cube() {
    
    //Draw top face -> left of cube
    fill_face(top, 2);
    
    //Draw bottom face
    fill_face(bottom, 3);
    
    //Draw front face
    fill_face(front, 0);
    
    ////Draw back face
    fill_face(back, 1);
    
    //Draw left face
    fill_face(left, 4);
    
    //Draw right face
    fill_face(right, 5);
    
  }
  
  void fill_face(ArrayList<ArrayList<int[]>> board, int pos) {
    int x;
    int y;
    int z;
    
    for (ArrayList<int[]> col: board) {
      for (int[] square: col) {
        square[0] = square[1];
        color fill_col = color(255);
        boolean draw_fill = true;
        
        x = square[2];
        y = square[3];
        z = square[4];
        
        if (square[0] == 1) {
          fill_col = color(0);
        } else {
          if (clear) {
            draw_fill = false;
          } else {
            fill_col = 255;
          }
        }
        
        //Decide which fill method to use based off of pos
        //Front
        if (pos == 0) {
          cube[x][y][z].draw_front(fill_col, draw_fill);
        
        //Back
        } else if (pos == 1) {
          cube[x][y][z].draw_back(fill_col, draw_fill);
         
        //Top
        } else if (pos == 2) {
          cube[x][y][z].draw_left(fill_col, draw_fill);
        
        //Bottom
        } else if (pos == 3) {
          cube[x][y][z].draw_right(fill_col, draw_fill);
        
        //Left
        } else if (pos == 4) {
          cube[x][y][z].draw_top(fill_col, draw_fill);
        
        //Right
        } else if (pos == 5) {
          cube[x][y][z].draw_bottom(fill_col, draw_fill);
          
        }
      }
    }
    
  }
  
  //Draw the grids 2D - mostly for testing to make sure I can connect the sides right
  void draw_2D() {
    int box_inc = len * dim + 5;
    
    //Starting point for the 4 up/down boxes
    int x_top = (width / 2) - (len * dim / 2);
    int y_top = 15;
    
    //Starting point for the left and right box
    int x_long = x_top - box_inc;
    int y_long = 15 + box_inc;
    
    //Draw the top box
    draw_2D_board(x_top, y_top, top);
    y_top += box_inc;
    
    //Draw the front box
    draw_2D_board(x_top, y_top, front);
    y_top += box_inc;
    
    ////Draw the bottom box
    draw_2D_board(x_top, y_top, bottom);
    y_top += box_inc;
    
    //Draw the back box
    draw_2D_board(x_top, y_top, back);
    y_top += box_inc;
    
    //Draw left box
    draw_2D_board(x_long, y_long, left);
    x_long += (box_inc * 2);
    
    //Draw right box
    draw_2D_board(x_long, y_long, right);
    
  }
  
  void draw_2D_board(int x_point, int y_point, ArrayList<ArrayList<int[]>> board) {
    int X = x_point;
    int Y = y_point;
    
    //Draw the given board
    for (int x = 0; x < dim; x += 1) {
      ArrayList<int[]> curr_board = board.get(x);
      for (int y = 0; y < dim; y += 1) {
        int[] curr = curr_board.get(y);
        curr[0] = curr[1];
        
        //If alive draw a black square
        if (curr[0] == 1) {
          fill(0);
          stroke(0);
        } else {
          noFill();
          stroke(0);
        }
        
        if (visualize) {
          if (curr[6] == 1 ) {
            if (curr[0] == 1) {
              fill(color(31, 117, 254));
            } else {
              fill(color(31, 117, 254), 50);
            }
          }
          
          if (curr[7] == 1) {
            if (curr[0] == 1) {
              fill(color(102, 255, 0));
            } else {
              fill(color(102, 255, 0), 50);
            }
          }
        }
        
        //Draw the square
        square(X, Y, len);
        
        fill(255);
        String coords = curr[2] + "," + curr[3] + "," + curr[4];
        textSize(len / 3);
        text(coords, X, Y + len / 2);
        
        X += len;
        
      }
      
      X = x_point;
      Y += len;
      
    }
    
  }
  
  //Used to highlight the current square and what squares are being checked
  void display_neighbors() {
    if (!started) {
      visualize_board = top;
      position = 2;
      started = !started;
    }
    
    int neighbors = 0;
    
    int[] curr = visualize_board.get(tmp_x).get(tmp_y);
    
    //Loop through to unset each neighbor
    for (int i = 0; i < dim; i += 1) {
      for (int j = 0; j < dim; j += 1) {
        top.get(i).get(j)[6] = 0;
        top.get(i).get(j)[7] = 0;
        bottom.get(i).get(j)[6] = 0;
        bottom.get(i).get(j)[7] = 0;
        front.get(i).get(j)[6] = 0;
        front.get(i).get(j)[7] = 0;
        back.get(i).get(j)[6] = 0;
        back.get(i).get(j)[7] = 0;
        left.get(i).get(j)[6] = 0;
        left.get(i).get(j)[7] = 0;
        right.get(i).get(j)[6] = 0;
        right.get(i).get(j)[7] = 0;
      }
    }
    
    curr[6] = 1;
    neighbors = count_neighbors(tmp_x, tmp_y, visualize_board, position);
    
    curr[5] = neighbors;
    
    //Set the next state
    if (curr[0] == 1 && (neighbors == 2 || neighbors == 3)) {
      curr[1] = 1;
    } else if (curr[0] == 0 && neighbors == 3) {
      curr[1] = 1;
    } else {
      curr[1] = 0;
    }
    
    tmp_y += 1;
    
    if (tmp_y == dim) {
      //Decide what to do at the end of the row based on what board I'm on
      
      //If on top
      if (position == 2) {
        tmp_y = 0;
        tmp_x += 1;
        
        //If on bottom corner
        if (tmp_x == dim) {
          tmp_x = 0;
          tmp_y = 0;
          visualize_board = left;
          position = 4;
        }
        
        //If on left
      } else if (position == 4) {
        
        //If on end of left
        if (tmp_y == dim) {
          tmp_y = 0;
          visualize_board = front;
          position = 0;
          
        }
        //If on front
      } else if (position == 0) {
        
        //If on end of front
        if (tmp_y == dim) {
          tmp_y = 0;
          visualize_board = right;
          position = 5;
        }
        
        //If on right
      } else if (position == 5) {
        
        //If on end of right
        if (tmp_y == dim && tmp_x < dim) {
          tmp_x += 1;
          visualize_board = left;
          position = 4;
          tmp_y = 0;
          
          //If on bottom corner of right
          if (tmp_x == dim) {
            tmp_y = 0;
            tmp_x = 0;
            visualize_board = bottom;
            position = 3;
          }
        }
         
        //If on bottom
      } else if (position == 3) {
        tmp_y = 0;
        tmp_x += 1;
        
        //If on bottom corner
        if (tmp_x == dim) {
          tmp_x = 0;
          tmp_y = 0;
          visualize_board = back;
          position = 1;
        }
        
        //If on back
      } else if (position == 1) {
        tmp_y = 0;
        tmp_x += 1;
        
        //If on bottom corner
        if (tmp_x == dim) {
          tmp_x = 0;
          tmp_y = 0;
          visualize_board = top;
          position = 2;
        }
      }
      
      
    }
    
  }
  
  void toggle_visualize() {
    visualize = !visualize;
  }
  
}
