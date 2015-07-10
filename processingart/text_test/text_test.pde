void setup() {
  PFont vfont;

  // The font ".ttf" must be located in the 

  // current sketch's "data" directory to load successfully
  size(200, 200);

  vfont = loadFont("calibri.ttf");

  textFont(vfont, 44); 

  text("word", 15, 50);
}

