float currx, curry, currz;
float l = 100;
float initsize = 20;
float depthStep = 20;
float updown = 0;
float leftright =0;

void setup(){
  frameRate(10);
  size(600, 400);
  currx = 0;
  curry = 0;
  currz = 1000;
  
}

void draw(){
  background(255);
  fill(200, 200, 0, 200);
  pushMatrix();
  translate(width/2, height/2);
  
  for(int i=-(int)(width/2); i<width/2; i+=20){
    for(int j=-(int)(height/2); j<height/2; j+=20){
      currx = i + leftright;
      curry = j + updown;
      float newx =  xReloc(currx, curry, currz);
      float newy =yReloc(currx, curry, currz); 
      ellipse(newx,newy, xResize(currx, curry, currz)*initsize, yResize(currx, curry, currz)*initsize);  
    }
  }
  
  popMatrix();
  
}

float xResize(float oldx, float oldy, float oldz){
  float depth = l + oldz;
  float h = (float)Math.sqrt(oldz*oldz - oldx*oldx);
  return depth*oldz*oldz/(pow(h, 3));
  //return D/oldz;
}

float yResize(float oldx, float oldy, float oldz){
  float depth = l + oldz;
  float h = (float)Math.sqrt(oldz*oldz - oldy*oldy);
  return depth*oldz*oldz/(pow(h, 3));
}

float xReloc(float oldx, float oldy, float oldz){
  float depth = l + oldz;
  float h = (float)Math.sqrt(oldz*oldz - oldx*oldx);
  return oldx*(depth)/h;
}

float yReloc(float oldx, float oldy, float oldz){
  float depth = l + oldz;
  float h = (float)Math.sqrt(oldz*oldz - oldy*oldy);
  return oldy*(depth)/h;
}

void keyPressed() {

    if (key == CODED) {
    if (keyCode == UP) {
      updown = updown-30;
    } 
    else 
      if (keyCode == DOWN) {
      updown = updown+30;
    } 
    else 
      if (keyCode == LEFT) {
      leftright = leftright-30;
    }  
    else 
      if (keyCode == RIGHT) {
      leftright = leftright+30;
      println("right pressed");
    }
  }
  
  if (key == '=' || key == '+' ) {
    currz += depthStep; 
    println(currz);
  } 
  else if (key == '-' || key == '_') {
    currz -= depthStep; 
    println(currz);
  }
}

boolean inFrame(float x, float y){
  return (abs(x)<width/2)&&(abs(y)<height/2);
}

