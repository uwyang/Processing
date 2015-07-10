float currHue;
float currR;
float currBright;
color currColor;
float currx, curry;
float meanStep = 2;
float varStep = 1;
float brightStep = 10;
float fadeStep = 8;


void setup() {
  size(400, 300);
  currHue = random(255);

  currx = random(width);
  curry = random(height);
  colorMode(HSB, 255);
  background(currHue, 240, 5);
  noStroke();
  color c = color(currHue, 230, 20); 
  fill(c);
  println("sat: " + saturation(c));
  println("hue: " + hue(c));
  println("bright: " + brightness(c));
  ellipse(currx, curry, 5, 5);
}

void draw() {
  loadPixels();
  color[] pixelCopy = new color[pixels.length];
  arrayCopy(pixels, pixelCopy);
  for (int i=1; i<width-1; i++) {
    for (int j=1; j<height-1; j++) {
      int pixnum = getPixel(i, j); 
      color c = pixels[pixnum];
      float bc = brightness(c);
      if (bc>7) {
        c = brighten(c, random(brightStep));
        brightenNear(pixels, pixelCopy, i, j, 1.5);
        c = fade(c, 20);
        /*
        if (saturation(c)> 100) {
          //c= fade(c, random(fadeStep));
          c= fade(c, 20);
          //println(saturation(c));
        } else {
          c= fade(c, 20 );
        }*/
        pixelCopy[pixnum] = c;
      }
    }
  }
  arrayCopy(pixelCopy, pixels);
  /*
  color c = pixels[getPixel((int)currx, (int)curry)];
  println("sat: " + saturation(c));
  println("hue: " + hue(c));
  println("bright: " + brightness(c));
  //println(saturation(pixels[getPixel((int)currx, (int)curry)]));
  */
  updatePixels();
  
}

int getPixel(int i, int j) {
  return j*width + i;
}

void brightenNear(color[] pixelarr, color[] pixelto, int pixi, int pixj, float b) {
  color c;
  color newc;
  int currpixnum;
  float r = 1.5;
  for (int i= -round (r); i<= round(r); i++) {
    for (int j= -round (r); j<= round(r); j++) {
      if ((!(i==0 && j==0) ) && ((i*i + j*j) <= r*r)) {
        currpixnum = getPixel(i+ pixi, j+pixj);
        c = pixelarr[currpixnum];
        newc = brighten(c, random(b));
        pixelto[currpixnum] = newc;
      }
    }
  }
}

void fadeNear(color[] pixelarr, color[] pixelto, int pixi, int pixj, float b) {
  color c;
  color newc;
  int currpixnum;
  float r = 1.5;
  for (int i= -round (r); i<= round(r); i++) {
    for (int j= -round (r); j<= round(r); j++) {
      if ((!(i==0 && j==0) ) && ((i*i + j*j) <= r*r)) {
        currpixnum = getPixel(i+ pixi, j+pixj);
        c = pixelarr[currpixnum];
        newc = fade(c, random(b));
        pixelto[currpixnum] = newc;
      }
    }
  }
}


color brighten(color c, float b) {
  //println("sat: "+saturation(c));
  return color(currHue, saturation(c), brightness(c) + b);
}

color fade(color c, float s) {
  //println("old sat:  " + saturation(c) + ", s: " + s);
  color newc = color(currHue, saturation(c) - s, brightness(c));
  
  //println("curr sat:  " + saturation(newc));
  return newc ;
}

