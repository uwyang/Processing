/*
goal: accomplish glittering effect without using 
 OpenGl 3D engine or anthing like that. 
 */

// P ~ R*D 
//P: Object size, D: distance, R: image
//so, for thing at dist say, D: R*311.5/dist

float csize = 20;
float depthStep = 3;
float xyStep = 5;
int xnum, ynum;
float shiftx = 0; 
float shifty = 0;
float currDepth = 0;

void setup() {
  size(600, 400);
  smooth();
  //frameRate(25);
  background(255);
  xnum = ceil(height/csize)-1;
  ynum = ceil(width/csize)-1;
}

void draw() {
  background(255);
  drawAxis();
  drawCircles();
}

void drawAxis() {
  pushMatrix();
  translate(width/2, height/2);
  noFill();
  stroke(0);
  strokeWeight(0.5);
  ellipse(0, 0, 15, 15);
  strokeWeight(1);
  stroke(126, 100);
  line(0, -height/3, 0, height/3);
  line(-width/3, 0, width/3, 0);
  popMatrix();
}

void drawCircles() {
  translate(width/2, height/2);

  float currx = 0;
  float curry = 0;
  for (int i= -round(xnum); i< round(xnum); i++) {
    for (int j= -round(ynum); j< round(ynum); j++) {
      currx = i*csize + shiftx;
      curry = j*csize + shifty;
      flat3dObj obj = new flat3dObj(currx, curry, currDepth);
      float xsize, ysize;
      xsize = csize*obj.xResize();
      ysize = csize*obj.yResize();
      pushMatrix();
      translate(obj.xRepos(), obj.yRepos());
      /*
      if (i==0 || j==0) {
       println("curr i, j: " + i + " " + j);
       println("position: " + obj.xRepos() + " " + obj.yRepos());
       println("resize: " + obj.xResize() + " " + obj.yResize());
       ellipse(0, 0, 10, 10);
       }
       */
      noStroke();
      fill(192, 0, 192, 100);
      ellipse(0, 0, xsize, ysize);
      popMatrix();
    }
  }
}

void keyPressed() {
  if (keyCode == ENTER) {
    println("save pic");
    saveFrame("./glitter###.jpg");
  }
  if (key == CODED) {
    if (keyCode == UP) {
      shifty += xyStep;
    } 
    else if (keyCode == DOWN) {
      shifty -= xyStep;
    } 
    else if (keyCode == LEFT) {
      shiftx -= xyStep;
    } 
    else if (keyCode == RIGHT) {
      shiftx += xyStep;
    }
  }

  if (key == '=' || key == '+' ) {
    currDepth += depthStep; 
    //println(currDepth);
  } 
  else if (key == '-' || key == '_') {
    currDepth -= depthStep; 
    //println(currDepth);
  }
}

