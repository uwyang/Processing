//y.l.
/* @pjs preload="bat.jpg"; */
triangle[] trs = new triangle[500];//500 seems to be the optimum. 
float trigsize = 5;

PImage currimg;

blackshape bs;
boolean stopatcenter = false;

float maxspeed = 5;

float r = 100;



void setup() {
  currimg = loadImage("bat.jpg");
  size(currimg.width, currimg.height);
  background(255);
  fill(0);
  //frameRate(fc);
  
  
  
  bs = new blackshape(currimg);
  r = min(width/3, height/3);
  setuparr();
  
  //println(v1.x);
}

void setuparr(){
    for (int i=0; i<trs.length; i++) {
    float randx = random(width);
    float randy = random(height);
    trs[i] = makeRandomTriangle(randx, randy, trigsize, 4);
    //println("x: " + randx + "y: " + randy);
    if (bs.isblack[(int)randx][(int)randy]) {
      trs[i].attract = false;
    }
    trs[i].moving = true;
    trs[i].speed = new PVector(1, 1);
    trs[i].maxspeed = maxspeed;
    float targetx = (width/2) + random(2*r) - r;
   float targety = (height/2) + random(2*r) - r; 
    trs[i].setTarget(new PVector(targetx, targety));
    //println(trs[i].speed.x + " " + trs[i].speed.y);
  }
}

void draw() {
  boolean notmoving = true;
  //bs.drawme();
  background(255);
  //println(frameCount);
  
  for (int i=0; i<trs.length; i++) {
    //println(i + " x: " + trs[i].center.x + ", y: " + trs[i].center.y + ", " + trs[i].moving);
    trs[i].updateme();

    int centerx = round(trs[i].center.x);
    int centery = round(trs[i].center.y);
    if (incanvas(centerx, centery)) {
      notmoving = (notmoving & (!trs[i].moving));
      trs[i].drawme();

      if (bs.isblack[centerx][centery] && trs[i].attract) {
        trs[i].moving = false;
      }
      if (!bs.isblack[centerx][centery] && !trs[i].attract){
        trs[i].moving = false;
      }
      
      if (closetocenter(trs[i].center) && stopatcenter) {
        trs[i].moving = false;
      }
    } else {

      trs[i].moving = false;
    }
  }
  smooth();
  if(notmoving){
    //println("noloop");
    noLoop();
  }
  

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

void mousePressed(){
  background(255);
  setuparr();
  loop();
}
