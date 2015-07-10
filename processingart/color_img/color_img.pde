hsba c1;
hsba[][] colarr;
hsba[][] lastcolarr;
int edge=50;
float fadeStep = 3;
float fadeStartBrightness = 50;
float brightProb = 0.6; // fading probability is bP percent. 
float fadeProb = 0.6;
int framenum =0;
PImage img;
String imgfile = "majora.jpg";

void setup() {
  img = loadImage(imgfile);
  size(img.width, img.height);

  //frameRate(20);
  colorMode(HSB);
  //initially, the canvas is hueless. 

  initArr();
  image(img, 0, 0);

  hsba currpix = colarr[round(width/2)][round(height/2)];
  arrayCopy(colarr, lastcolarr);
  drawCanvas(colarr);
  //printPixInfo(initx, inity);
}


void draw() {
  framenum++;
  for (int i=0; i<width; i++) {
    for (int j=0; j<height; j++) {
      hsba currhsba =lastcolarr[i][j]; 
      if (currhsba.b > 7) {

        brightenNear(i, j, 1);
        currhsba.brighten(random(2));
        if (currhsba.b > fadeStartBrightness) {
          if (random(1) < fadeProb) {
            currhsba.fade(fadeStep);
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
  if (framenum>0) {
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
      color c =  img.get(i, j);
      if (brightness(c) <10) {
        colarr[i][j] = new hsba(255, 0);
      } else {
        colarr[i][j] = new hsba(hue(c), saturation(c), brightness(c));
      }
    }
    arrayCopy(colarr, lastcolarr);
  }
}

void brightenNear(int ipos, int jpos, float byb) {
  float r = 2.3;
  hsba centerpix = lastcolarr[ipos][jpos].getCopy();
  for (int i= -round (r); i<=round(r); i++) {
    for (int j= -round (r); j<=round(r); j++) {
      if (inCanvas(ipos + i, jpos + j)) {
        if (i*i + j*j < r*r && random(1) < brightProb) {
          hsba currpix = colarr[ipos + i][jpos + j]; 
          hsba lastpix = lastcolarr[ipos + i][jpos + j].getCopy();
          currpix.brighten(random(byb));
          if (!currpix.hasHue) {
            currpix.h = centerpix.h;
            currpix.hasHue = true;
          }
        }
      }
    }
  }
}

void mixHue(int ipos, int jpos) {
  float r = 8;
  hsba centerpix = colarr[ipos][jpos];
  ArrayList <hsba> neighbours = new ArrayList <hsba>();
  int numneighbours = 0;
  int numhues = 0;


  for (int i= -round (r); i<= round(r); i++) {
    for (int j= -round (r); j<= round(r); j++) {
      if (inCanvas(ipos+i, jpos + j)) {
        hsba currpix = colarr[ipos + i][jpos + j]; 
        if (i*i + j*j < r*r) {
          numneighbours +=1;
          if (!currpix.hasHue) {
            break;
          } else {
            numhues ++;
            neighbours.add(currpix);
          }
        }
      }
    }
  }

  if (numhues > 2) {
    //println("num hues: " + numhues);
    //println("mix! " + neighbours.size());
    float newh =  centerpix.avgHue(neighbours);
    centerpix.h = newh;
  }
}

color getPixel(int i, int j) {
  return pixels[i + j*width];
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

void printPixInfo(int x, int y) {
  hsba currpix = colarr[x][y];
  //println("initx: " + x + ", inity: " + y);
  println("h: " + currpix.h);
  println("s: " + currpix.s);
  println("b: " + currpix.b);
  println("point color: " + currpix.getColor());
}


void keyPressed() {
  if (keyCode == ENTER) {
    println("save pic");
    saveFrame("./hueX2_###.jpg");
  }
}

void saveMovie() {
  saveFrame("./movie1/majoraX1_###.jpg");
}

