PImage a;
float currx, curry, currz;
float R = 50;
float depthStep = 20;

void setup()
{
  a = loadImage("./house.png");
  size(a.width, a.height);
  currz = 100;
}

void draw(){
  //image(a, 0, 0);
  background(255);
  a.loadPixels();
  float cx = width/2;
  float cy = height/2;

  color[] pixelCopy= new color[a.pixels.length];
  arrayCopy( a.pixels, pixelCopy);
  
  for (int i=0; i< width; i++) {
    for (int j=0; j< height; j++) {
      color c = pixelCopy[pixtoarr(i, j)];
      fill(c);
      noStroke();
      float currx = itox(i);
      float curry = jtoy(j);
      float newx =  xReloc(currx, curry, currz);
      float newy =yReloc(currx, curry, currz); 
      ellipse(xtoi(newx),ytoj(newy), xResize(currx, curry, currz), yResize(currx, curry, currz));
      
    }
  }
  
}

float xResize(float oldx, float oldy, float oldz){
  float depth = R + oldz;
  float l = (float)Math.sqrt(R*R - oldx*oldx);
  return depth*R*R/(pow(l, 3));
  //return D/oldz;
}

float yResize(float oldx, float oldy, float oldz){
  float depth = R + oldz;
  float l = (float)Math.sqrt(R*R - oldy*oldy);
  return depth*R*R/(pow(l, 3));
}

float xReloc(float oldx, float oldy, float oldz){
  float depth = R + oldz;
  float l = (float)Math.sqrt(R*R - oldx*oldx);
  return oldx*(depth)/l;
}

float yReloc(float oldx, float oldy, float oldz){
  float depth = R + oldz;
  float l = (float)Math.sqrt(R*R - oldy*oldy);
  return oldy*(depth)/l;
}

void keyPressed() {

  if (key == '=' || key == '+' ) {
    currz += depthStep; 
    //println(currDepth);
  } 
  else if (key == '-' || key == '_') {
    currz -= depthStep; 
    //println(currDepth);
  }
}


float itox(int i){
  return i-(width/2);
}

float xtoi(float x){
  return x + (width/2);
}

float jtoy(int j){
  return j-(height/2);
}

float ytoj(float y){
  return y +(height/2);
}

int pixtoarr(int i, int j){
  return j*width + i;
}
