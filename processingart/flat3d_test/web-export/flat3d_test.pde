float currx, curry, currz;
float D = 50;
float initsize = 20;

void setup(){
  size(600, 400);
  currx = 0;
  curry = 0;
  currz = 100;
  fill(200, 200, 0);
  
  for(int i=-(int)(width/2); i<200; i+=20){
    for(int j=-(int)(height/2); j<200; j+=20){
      ellipse(xReloc(i, j, currz),yReloc(i, j, currz), xResize(i, j, currz)*initsize, yResize(i, j, currz)*initsize);  
    }
  }
  
}

float xResize(float oldx, float oldy, float oldz){
  return D/oldz;
}

float yResize(float oldx, float oldy, float oldz){
  return D/oldz;
}

float xReloc(float oldx, float oldy, float oldz){
  return (oldx*D)/oldz;
}

float yReloc(float oldx, float oldy, float oldz){
  return (oldy*D)/oldz;
}




