PImage img;
PFont codefont;
String imgfile = "tree3.jpg";
String fontname = "courier";
int fontsize = 5;
int minlength = 10;
int maxlength = 50;
float minblack = 0.6;


void setup() {
  img = loadImage(imgfile);
  size(img.width, img.height);
  frameRate(200);
  background(255);
  //image(img, 0, 0);
  //codefont = createFont(fontname, 5);
  //textFont(codefont);
  //text("hello", 50, 50);
}

void draw(){
  line currline = new line(floor(random(width)), floor(random(height)));
  float currb;
  currline.getpoint2(random(minlength, maxlength));
  currb = currline.getBlackness(img);
  //print(currb);
  if(currb > minblack){
    line(currline.x1, currline.y1, currline.x2, currline.y2);
  }
}


