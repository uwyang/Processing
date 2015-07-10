float currx, curry, currz;
float R = 200;
float initsize = 20;
float depthStep = 5;

void setup(){
  size(600, 400);
  currx = 0;
  curry = 0;
  currz = 100;
  
}

void draw(){
  background(255);
  fill(200, 200, 0, 200);
  pushMatrix();
  translate(width/2, height/2);
  
  for(int i=-(int)(width/2); i<width/2; i+=20){
    for(int j=-(int)(height/2); j<height/2; j+=20){
      ellipse(xReloc(i, j, currz),yReloc(i, j, currz), xResize(i, j, currz)*initsize, yResize(i, j, currz)*initsize);  
    }
  }
  
  popMatrix();
  
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


