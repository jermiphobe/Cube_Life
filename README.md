# Cube_Life

[Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)

This was by far the most annoying of my Processing Game of Life projects.  I wanted to have a cube again, but instead of it being a cube of cubes, I wanted to have a 2D simulation on each side of the cube with the ability of the simulation to wrap around the sides of the cube (youc can still move the graphics around like the cube program).  My original thought was to use another three dimensional array like I did with the cube Game of Life.  However, I want the corner cubes different sides to act independently, so I decided to make 6 different two dimensional arrays and connect the sides to the appropriate array.  This turned out to be quite the process.  

To test how the connections between the arrays worked I at first had a 2D screen that laid out the arrays in a cross shape, like you unfolded the cube.  I then went cube by cube displaying a current square and it's neighbors, both on the same array and the neighbor array.  I would loop through all of the squares and see how it went to the neighbors.  I would get one side working, making sure it checked the right array and the right indexes.  If one index went off the side of the array, I would just invert it (so 0 went to the size of the array, if it was bigger than the array it would go to 0).  This didn't always line up because of the orientation of the arrays, so sometimes I would have to move the index to the other side of the specifc array.  

You can still view this by changing the "flat" boolean in the top of the Cube_life file.  Once the 2D simulation is running, the space bar will turn on the neighbor finding visualization.  Any other key will then move the current square through the boards in a preset pattern.  Hitting the spacebar again will resume the simulation.

One more fun little addition I made to the program is to clear the dead squares so you only see the alive squares.  To do this in the 3D version, hit the 'c' key to turn it off and on.  It's a little weird, but it's a fun way to see all of alive squares around the cube at the same time! 
