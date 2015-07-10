triangle tr; 
triangle[] trs = new triangle[100];
blackshape bs;
boolean stopatcenter = false;
int fc = 20;

float maxspeed = 5;
String fname = "./ah.jpg";

float wborder = 20;
float hborder = 10;


void setup() {
  background(255);
  fill(0);
  frameRate(fc);

  bs = new blackshape(fname);
  size(bs.img.width, bs.img.height);

  for (int i=0; i<trs.length; i++) {
    //trs[i] = makeRandomTriangle(random(width), random(height), 10, 4);
    float randoutx, randouty;
    if(random(1)<0.5){
      randoutx = -random(wborder);
    }else{
      randoutx = width + random(wborder);
    }
    
    if(random(1)<0.5){
      randouty = -random(hborder);
    }else{
      randouty = height + random(hborder);
    }
    //println("x: " + randoutx + " y: " + randouty);
    trs[i] = makeRandomTriangle(randoutx, randouty, 10, 4);
    //println("x: " + trs[i].center.x + " y: " + trs[i].center.y);
    trs[i].moving = true;
    trs[i].speed = new PVector(1, 1);
    trs[i].maxspeed = maxspeed;
    trs[i].setTarget(new PVector(width/2, height/2));
    //println(trs[i].speed.x + " " + trs[i].speed.y);
  }
  //println(v1.x);
}

void draw() {
  //bs.drawme();
  background(255);
  //println(frameCount);
  for (int i=0; i<trs.length; i++) {
    //println(i + " x: " + trs[i].center.x + ", y: " + trs[i].center.y + ", " + trs[i].moving);
    trs[i].updateme();
    
    int centerx = round(trs[i].center.x);
    int centery = round(trs[i].center.y);
    if (incanvas(centerx, centery)) {
      trs[i].drawme();
      if(bs.isblack[centerx][centery]){
        trs[i].moving = false;
      }
      if (closetocenter(trs[i].center) && stopatcenter) {
        trs[i].moving = false;
      }
    } else {
      if(!incanvas(centerx, centery, max(wborder, hborder))){
      trs[i].moving = false;
      } else {
        trs[i].moving = true;
      }
    } 
  }
  smooth();
}

triangle makeRandomTriangle(float x, float y, float r, float minr) {
  PVector v1 = new PVector(x, y);
  float randomangle = random(PI);
  float randr = random(r)+minr;
  float currx = x + randr*cos(randomangle);
  float curry = y + randr*sin(randomangle);
  PVector v2 = new PVector(currx, curry);
  //println("r: " + randr + ", shiftx: " + currx + ", shifty: " + curry );

  randomangle = random(PI/2);
  randr = random(r)+minr;
  currx = x + randr*cos(randomangle);
  curry = y + randr*sin(randomangle);
  PVector v3 = new PVector(currx, curry);
  PVector[] t = {
    v1, v2, v3
  };
  triangle tr =new triangle(t); 
  return tr;
}


boolean closetocenter(PVector v) {
  if (abs(v.x-width/2)< 2*maxspeed && abs(v.y - height/2)<maxspeed*2) {
    return true;
  }
  return false;
}

boolean incanvas(int x, int y) {
  if (x>=0 && x< width && y >=0 && y < height) {
    return true;
  }
  return false;
}

boolean incanvas(int x, int y, float r) {
  if (x>=(0-r) && x< (width+r) && y >=(0-r) && y < (height+r)) {
    return true;
  }
  return false;
}

