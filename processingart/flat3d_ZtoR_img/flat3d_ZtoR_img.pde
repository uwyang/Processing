PImage a;
float currx, curry, currz;
float l = 50;
float depthStep = 20;
float dirStep = 10;
float updown = 0;
float leftright =0;

void setup()
{
  frameRate(3);
  a = loadImage("./house.png");
  size(a.width/4, a.height/4);
  currz = 150;
}

void draw() {
  //image(a, 0, 0);
  background(255);
  a.loadPixels();
  float cx = width/2;
  float cy = height/2;
  
  color[] pixelCopy= new color[a.pixels.length];
  arrayCopy( a.pixels, pixelCopy);
  //background(tempc);

  for (int i=0; i< width; i++) {
    for (int j=0; j< height; j++) {
      //color c = pixelCopy[pixtoarr(i, j)];
      color c = getpixel(pixelCopy, a.width, a.height, width, height, i, j);
      
      fill(c);
      noStroke();
      float currx = itox(i);
      float curry = jtoy(j);
      currx += leftright;
      curry += updown;
      float newx =  xReloc(currx, curry, currz);
      float newy = yReloc(currx, curry, currz); 
      if (inframe(newx, newy)) {
        float xsize = xResize(currx, curry, currz);
        float ysize = yResize(currx, curry, currz);
        rect(xtoi(newx), ytoj(newy), xsize, ysize);
      }
    }
  }
  println("done draw");

}



float xResize(float oldx, float oldy, float oldz) {
  float depth = l + oldz;
  float h = (float)Math.sqrt(oldz*oldz - oldx*oldx);
  return depth*oldz*oldz/(pow(h, 3));
  //return D/oldz;
}

float yResize(float oldx, float oldy, float oldz) {
  float depth = l + oldz;
  float h = (float)Math.sqrt(oldz*oldz - oldy*oldy);
  return depth*oldz*oldz/(pow(h, 3));
}

float xReloc(float oldx, float oldy, float oldz) {
  float depth = l + oldz;
  float h = (float)Math.sqrt(oldz*oldz - oldx*oldx);
  return oldx*(depth)/h;
}

float yReloc(float oldx, float oldy, float oldz) {
  float depth = l + oldz;
  float h = (float)Math.sqrt(oldz*oldz - oldy*oldy);
  return oldy*(depth)/h;
}

void keyPressed() {
  
    if (key == CODED) {
    if (keyCode == UP) {
      updown = updown-dirStep;
    } 
    else 
      if (keyCode == DOWN) {
      updown = updown+dirStep;
    } 
    else 
      if (keyCode == LEFT) {
      leftright = leftright-dirStep;
    }  
    else 
      if (keyCode == RIGHT) {
      leftright = leftright+dirStep;
      //println("right pressed");
    }
  }

  if (key == '=' || key == '+' ) {
    currz += depthStep; 
    println(currz);
  } else if (key == '-' || key == '_') {
    currz -= currz/10;
    println(currz);
  }
}


float itox(int i) {
  return i-(width/2);
}

float xtoi(float x) {
  return x + (width/2);
}

float jtoy(int j) {
  return j-(height/2);
}

float ytoj(float y) {
  return y +(height/2);
}

int pixtoarr(int i, int j) {
  return j*width + i;
}

boolean inframe(float x, float y) {
  if (abs(x)<width/2 && abs(y)<height/2) {
    return true;
  }
  return false;
}

color getpixel(color[] img, int oldw, int oldh, int neww, int newh, float newx, float newy){
  color c;
  
  int fromx = (int)( (newx/neww)*oldw);
  int fromy = (int) ((newy/newh)*oldh);
  int fromarrnum =fromy*oldw + fromx;
 if(fromarrnum < img.length){ 
  c = img[fromarrnum];
 }
 else {
   c = img[0];
   println(fromarrnum + " out of b");
 }
 
  return c;
}
