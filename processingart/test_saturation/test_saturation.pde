float currHue;
float currR;
float currBright;
float currx, curry;
color c;

void setup(){
  size(400, 300);
  frameRate(10);
  currHue = random(255);
  currx = random(width);
  curry = random(height);
  colorMode(HSB, 255);
  color currColor = color(10, 240, 20);
  background(currColor);
  println("sat: " + saturation(currColor));
  println("hue: " + hue(currColor));
  println("bright: " + brightness(currColor));
  colorMode(HSB, 255);
  c = color(0, 126, 255);
  println("sat: " + saturation(c));
  println("hue: " + hue(c));
  println("bright: " + brightness(c));
  println("---------------------");
  colorMode(HSB, 255);
  color c = color(200, 230, 20); 
  //fill(c);
  println("sat: " + saturation(c));
  println("hue: " + hue(c));
  println("bright: " + brightness(c));
  //ellipse(100, 100, 5, 5);
}

void draw(){
  colorMode(HSB, 255);
  color newc = color(hue(c), saturation(c) - 2.5, brightness(c));
  c = newc;
  //background(c);
  loadPixels();
  //println("sat: " + saturation(pixels[100]));
  
}


color fade(color c, float s) {
  float currs = saturation(c);
  //println(currs + "reduce to " +  ((int) currs - s));
  color newc = color(currHue, (int) currs - s, brightness(c));
  //println(saturation(newc));
  return newc;
}
