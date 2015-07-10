float currHue;
float currHue2;
hsba c1;
hsba[][] colarr;
hsba[][] lastcolarr;
int edge=50;
float fadeStep = 2.5;
float fadeStartBrightness = 50;
float brightProb = 0.5; // fading probability is bP percent. 
float fadeProb = 0.6;
int framenum =0;
float brightenr = 3;
float mixhuer = 5;
//boolean moviemode = true;
boolean moviemode = false;

void setup() {
  size(400, 300);
  //frameRate(20);
  colorMode(HSB);
  //initially, the canvas is hueless. 

  background(0);
  initArr();
  currHue = random(255);

  c1 = new hsba(currHue, 255, 200);
  //println("currhue: " + currHue);
  fill(c1.getColor());
  noStroke();
  int initx = edge + (int) random(width - edge*2);
  int inity = edge + (int)random(height - edge*2);
  //initx = 70;
  //inity = 50;
  makeHueCircle(initx, inity, 10, currHue, 10);
  currHue = random(255);
  initx = edge + (int) random(width - edge*2);
  inity = edge + (int)random(height - edge*2);
  //initx = 300; 
  //inity = 150;
  makeHueCircle(initx, inity, 30, currHue, 10);

  hsba currpix = colarr[initx][inity];
  copyCanvasArr(colarr, lastcolarr);
  drawCanvas(colarr);
  //printPixInfo(initx, inity);
}


void draw() {
  framenum++;
  for (int i= width-1; i>0; i--) {
    for (int j=height-1; j>0; j--) {
      hsba currhsba =lastcolarr[i][j]; 
      if (currhsba.b > 8) {
        brightenNear(i, j, 2);
        colarr[i][j].brighten(random(2));
      }
    }
  }

  for (int i= 0; i<width; i++) {
    for (int j=0; j<height; j++) {
      hsba newhsba = colarr[i][j];
      if (newhsba.b > 7) {
        if (newhsba.b > fadeStartBrightness) {
          if (random(1) < fadeProb) {
            newhsba.fade(fadeStep);
          }
        }
      }
    }
  }


  for (int i=0; i<width; i++) {
    for (int j=0; j<height; j++) {
      hsba currhsba =lastcolarr[i][j]; 
      if (currhsba.b > 10) {
        mixHue(i, j);
      }
    }
  }

  drawCanvas(colarr);
  copyCanvasArr(colarr, lastcolarr);
  if (framenum>50 && moviemode) {
    saveMovie();
  }
  //printPixInfo(initx, inity);
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
  copyCanvasArr(colarr, lastcolarr);
}

void brightenNear(int ipos, int jpos, float byb) {
  float r = brightenr;
  hsba centerpix = lastcolarr[ipos][jpos].getCopy();

  for (int i= round (-r); i<=r; i++) {
    for (int j= round (-r); j<=r; j++) {
      if (inCanvas(ipos + i, jpos + j)) {
        if (i*i + j*j <= r*r && random(1) < brightProb) {
          hsba currpix = colarr[round(ipos + i)][round(jpos + j)]; 
          if (!currpix.hasHue) {
            currpix.h = centerpix.h;
            currpix.hasHue = true;
          }
          currpix.brighten(random(byb));
        }
      }
    }
  }
}


void mixHue(int ipos, int jpos) {
  float r = mixhuer;
  hsba centerpix = colarr[ipos][jpos];
  hsba historypix = lastcolarr[ipos][jpos].getCopy();
  ArrayList <hsba> neighbours = new ArrayList <hsba>();
  int numneighbours = 0;
  int numhues = 0;


  for (int j= -round (r); j<= round(r); j++ ) {
    for (int i= -round (r); i<= round(r); i++ ) {
      if (random(1) > 0.9) {
        if (inCanvas(ipos+i, jpos + j)) {
          if (i*i + j*j < r*r) {

            hsba currpix = colarr[ipos + i][jpos + j];
            currpix.avgHue(historypix);
            //centerpix.avgHue(currpix);
          }
        }
      }
    }
    /*
  if (numhues > 2) {
     //println("num hues: " + numhues);
     //println("mix! " + neighbours.size());
     float newh =  centerpix.avgHue(neighbours);
     centerpix.h = newh;
     }
     */
    //colarr[ipos][jpos] = historypix;
  }
}


  boolean inCanvas(int i, int j) {
    if (i>=0 && i<width && j>=0 && j<height) {
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

  void printPixInfo(int x, int y) {
    hsba currpix = colarr[x][y];
    println("initx: " + x + ", inity: " + y);
    println("h: " + currpix.h);
    println("s: " + currpix.s);
    println("b: " + currpix.b);
    println("point color: " + currpix.getColor());
  }

  void makeHueCircle(int initx, int inity, int initr, float hue, float bri) {
    for (int i= -initr; i<initr; i++) {
      for (int j= -initr; j<initr; j++) {
        hsba currpix = colarr[initx+ i][inity+j];
        if (i*i + j*j < initr*initr) {
          currpix.h = hue;
          currpix.hasHue = true;
          currpix.b  = bri;
        }
      }
    }
  }

  void keyPressed() {
    if (keyCode == ENTER) {
      println("save pic");
      saveFrame("./hueX2_###.jpg");
    }
  }

  void saveMovie() {
    saveFrame("./movie5/hueX2_###.jpg");
  }


  void copyCanvasArr(hsba[][] fromarr, hsba[][] toarr) {
    for (int i=0; i<fromarr.length; i++) {
      for (int j=0; j<fromarr[0].length; j++) {
        toarr[i][j] = fromarr[i][j].getCopy();
      }
    }
  }

