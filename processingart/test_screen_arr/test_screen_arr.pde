  

PrintWriter output;
float currHue;
hsba c1;
hsba[][] colarr;
hsba[][] lastcolarr;
float brightProb = 1;
boolean printtofile = true;
boolean printc = false;

void setup() {
  output = createWriter("positions.txt"); 
  frameRate(1);
  size(10, 10);
  colorMode(HSB);
  background(0);
  initArr();
  currHue = random(255);
  
  c1 = new hsba(0, 255, 255);
  //println("currhue: " + currHue);
  fill(c1.getColor());
  noStroke();
  rect(2, 2, 3, 4);
  getCanvasPix(colarr);
  //drawCanvas(colarr);
  
  //
}


void draw() {
  arrayCopy(colarr, lastcolarr);
  output.println("c1.h is: " + c1.h);
  

  
  c1.h = (c1.h + 20)%255;
  for (int i= 0; i<width; i++) {
    for (int j=0; j<height; j++) {
      
      hsba currhsba = lastcolarr[i][j]; 
      if (currhsba.b > 8) {
        //println("x: " + i + ", y: " + j);
        printPixInfo(lastcolarr, i, j, printtofile);
        brightenNear(i, j, 2);
        //colarr[i][j].brighten(random(2));
      }
    }
  }
  
  drawCanvas(colarr);
  //background(color(c1.h, 200, 200));
  
}



void brightenNear(int ipos, int jpos, float byb) {
  int r = 1;
  for (int i= -r; i<=r; i++) {
    for (int j= -r; j<=r; j++) {
      if (inCanvas(ipos + i, jpos + j)) {
        if (i*i + j*j <= r*r && random(1) < brightProb) {
          hsba currpix = colarr[round(ipos + i)][round(jpos + j)]; 

          if (!currpix.hasHue) {
            currpix.h = c1.h;
            currpix.hasHue = true;
            currpix.b = 200;
          }
          
        }
      }
    }
  }
}

void initArr() {
  colarr = new hsba[width][height];
  lastcolarr = new hsba[width][height];
  for (int i=0; i<width; i++) {
    for (int j=0; j<height; j++) {
      //initially, there is no hue and all squares are black. 
      colarr[i][j] = new hsba(255, 0);
    }
  }
  arrayCopy(colarr, lastcolarr);
}


boolean inCanvas(int i, int j) {
  if (i >=0 && i< width && j > 0 && j < height) {
    return true;
  }
  return false;
}

void drawCanvas(hsba[][] frompix) {
  loadPixels();
  for (int i=0; i<frompix.length; i++) {
    for (int j=0; j<frompix[0].length; j++) {
      //println("x: " + i + ", y: " + j);
      pixels[j*width + i] = frompix[i][j].getColor();
    }
  } 
  updatePixels();
}

void getCanvasPix(hsba[][] arr){
   loadPixels();
  for (int i=0; i<width; i++) {
    for (int j=0; j<height; j++) {
      //println("x: " + i + ", y: " + j);
      color currpix =pixels[j*width + i]; 
      if(brightness(currpix)< 20){
        arr[i][j] = new hsba(255, brightness(currpix));
      }else {
      arr[i][j] = new hsba(hue(currpix), saturation(currpix), brightness(currpix));
      }
    }
  } 
}

void printPixInfo(hsba[][] currarr, int x, int y, boolean c) {
  hsba currpix = currarr[x][y];
  if(!c && printc){
  println("initx: " + x + ", inity: " + y);
  println("h: " + currpix.h);
  println("s: " + currpix.s);
  println("b: " + currpix.b);
  println("point color: " + currpix.getColor());}
  else {
  output.println("frame number: " + frameCount);
  output.println("x: " + x + ", y: " + y);
  output.println("h: " + currpix.h + " s: " + currpix.s + " b: " + currpix.b);
  }
}

void keyPressed() {
  if(key == 'e' || key == 'E'){
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit(); // Stops the program
  }
}
