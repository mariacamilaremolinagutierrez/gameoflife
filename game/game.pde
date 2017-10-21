/* 
Conway's game of life...
 
Rules:
1. Death from isolation: Each live cell with less than two live neighbors dies
in the next generation
2. Death from overpopulation: Each cell with four or more live neighbors dies
in the next generation
3. Birth: Each dead cell with exactly three live neighbors comes to life in the
next generation
4. Survival: Each live cell with two live neighbors survives in the next
generation

Authors: 
Milton Quiroga
Maria Camila Remolina Gutierrez
*/

int[][] grid, futureGrid; // current state and next generation
int iterations = 0;

void setup() {
  
  /* Dimensions of canvas: */
  size(17,17); 
  
  /* Frame rate: */
  frameRate(8);
  
  /* Background: */
  background(255,255,255);
  
  /* Initial state: */
  grid = new int[width][height];
  futureGrid = new int[width][height];

  /* para llenado automático, lo que va por dentro
  float density = 0.3 * width * height; // densidad inicial... que tan denso es al principio
  for (int i = 0; i < density; i=i+1) {
    // en 0 para que no ponga nada, en 1 para que llene aleatoriamente algunos
    grid[int(random(width))][int(random(height))] = 0; 
  } 
  // end for() del llenado inicial de la vaina
  */
  
  /* Pulsar: */
  
  // Horizontal lines
  grid[2][4] = 1; 
  grid[2][5] = 1;
  grid[2][6] = 1;
  grid[2][10] = 1;
  grid[2][11] = 1;
  grid[2][12] = 1;
  
  grid[7][4] = 1; 
  grid[7][5] = 1;
  grid[7][6] = 1;
  grid[7][10] = 1;
  grid[7][11] = 1;
  grid[7][12] = 1;
  
  grid[9][4] = 1; 
  grid[9][5] = 1;
  grid[9][6] = 1;
  grid[9][10] = 1;
  grid[9][11] = 1;
  grid[9][12] = 1;
 
  grid[14][4] = 1; 
  grid[14][5] = 1;
  grid[14][6] = 1;
  grid[14][10] = 1;
  grid[14][11] = 1;
  grid[14][12] = 1;
  
  //Vertical lines
  grid[4][2] = 1; 
  grid[5][2] = 1;
  grid[6][2] = 1;
  grid[10][2] = 1;
  grid[11][2] = 1;
  grid[12][2] = 1;
  
  grid[4][7] = 1; 
  grid[5][7] = 1;
  grid[6][7] = 1;
  grid[10][7] = 1;
  grid[11][7] = 1;
  grid[12][7] = 1;
  
  grid[4][9] = 1; 
  grid[5][9] = 1;
  grid[6][9] = 1;
  grid[10][9] = 1;
  grid[11][9] = 1;
  grid[12][9] = 1;
 
  grid[4][14] = 1; 
  grid[5][14] = 1;
  grid[6][14] = 1;
  grid[10][14] = 1;
  grid[11][14] = 1;
  grid[12][14] = 1;
 
  /* Glider:
  grid[1][1] = 0; grid[2][1] = 1;
  grid[3][1] = 0;
  grid[1][2] = 0;
  grid[2][2] = 0;
  grid[3][2] = 1;
  grid[1][3] = 1;
  grid[2][3] = 1;
  grid[3][3] = 1;
  */
  
  /* Patrón de 28 "live" pixels in a straight line that achieves infinite growth:
  grid[401][250] = 1;
  grid[402][250] = 1;
  grid[403][250] = 1; 
  grid[404][250] = 1;
  grid[405][250] = 1;
  grid[406][250] = 1; 
  grid[407][250] = 1;
  grid[408][250] = 1;

  grid[409][250] = 0;
  grid[410][250] = 1;
  grid[411][250] = 1; 
  grid[412][250] = 1;
  grid[413][250] = 1;
  grid[414][250] = 1;
  grid[415][250] = 0;
  grid[416][250] = 0;
  grid[417][250] = 0;

  grid[418][250] = 1; 
  grid[419][250] = 1;
  grid[420][250] = 1;

  grid[421][250] = 0;
  grid[422][250] = 0;
  grid[423][250] = 0;
  grid[424][250] = 0;
  grid[425][250] = 0;
  grid[426][250] = 0;
  grid[427][250] = 1; 
  grid[428][250] = 1;
  grid[429][250] = 1;
  grid[430][250] = 1; 
  grid[431][250] = 1;
  grid[432][250] = 1;
  grid[433][250] = 1;
  grid[434][250] = 0;
  grid[435][250] = 1;
  grid[436][250] = 1;
  grid[437][250] = 1;
  grid[438][250] = 1;
  grid[439][250] = 1;
  */
  
  /* Coloring according to grid: */
  for (int x = 1; x < width-1; x=x+1) {
    for (int y = 1; y < height-1; y=y+1) {
      if(grid[x][y] == 1) {
        set(x, y, color(0));
      } else {
        set(x, y, color(255));
      } // end if then else
    } //end for()
  } // end for()

  /* Save initial state: */
  saveFrame("frames/first.png"); 
} // end setup...

void draw() {
  
  iterations = iterations + 1;
  
  for (int x = 1; x < width-1; x=x+1) {
    for (int y = 1; y < height-1; y=y+1) {
      /* Para "que pase el chorizo"
        for (int x = 0; x < width; x=x+1) {
          for (int y = 0; y < height; y=y+1) {
      */

      // Check the number of neighbors (adjacent cells)
      int nb = neighbors(x, y);
  
      if ((grid[x][y] == 1) && (nb < 2)) {
        futureGrid[x][y] = 0; // Isolation death
        set(x, y, color(0));
      } 
      else if ((grid[x][y] == 1) && (nb > 3)) { 
        futureGrid[x][y] = 0; // Overpopulation death
        set(x, y, color(0));
      } 
      else if ((grid[x][y] == 0) && (nb == 3)) { 
        futureGrid[x][y] = 1; // Birth
        set(x, y, color(255));
      } 
      else { 
        futureGrid[x][y] = grid[x][y]; // Survive
      } // end if-then-else
    } // end for()
  } // end for()
  
  // Swap current and future grids
  int[][] temp = grid; grid = futureGrid;
  futureGrid = temp;

  if(iterations % 1000000 == 0) {
    saveFrame("frames/glider-######.png");
  } // end if
} // end draw()

// Count the number of adjacent cells 'on'. Esta función "no pasa el chorizo"... el objeto llega al límite y muere...

int neighbors(int x, int y) { 
  return grid[x][y-1] // North
  + grid[x+1][y-1] // Northeast
  + grid[x+1][y] // East
  + grid[x+1][y+1] // Southeast
  + grid[x][y+1] // South + grid[x-1][y+1] // Southwest
  + grid[x-1][y] // West + grid[x-1][y-1] // Northwest
  ;
} // end neighbors()

/*
Para que la figura pase el chorizo utilice mejor la función de abajo...
int neighbors(int x, int y) {
 int north = (y + height-1) % height;
 int south = (y + 1) % height;
 int east = (x + 1) % width;
 int west = (x + width-1) % width;
 return grid[x][north] // North
 + grid[east][north] // Northeast
 + grid[east][y] // East
 + grid[east][south] // Southeast + grid[x][south] // South
 + grid[west][south] // Southwest
 + grid[west][y] // West
 + grid[west][north] // Northwest
 ;
} // end neighbors()
*/