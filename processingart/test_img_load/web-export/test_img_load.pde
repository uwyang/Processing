/* @pjs preload="bat.png"; */

PImage currimg;


void setup() {
  size(575, 208);
  currimg = loadImage("bat.png");
  loadPixels();
}

void draw(){
  image(currimg, 0, 0);
}

