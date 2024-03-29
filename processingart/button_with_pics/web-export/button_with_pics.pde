/* @pjs preload="data/base.gif, data/roll.gif, data/down.gif"; */

ImageButtons button;



void setup()

{

  size(200, 200);

  background(102, 102, 102);

  

  // Define and create image button

  PImage b = loadImage("data/base.gif");

  PImage r = loadImage("data/roll.gif");

  PImage d = loadImage("data/down.gif");

  int x = width/2 - b.width/2;

  int y = height/2 - b.height/2; 

  int w = b.width;

  int h = b.height;

  button = new ImageButtons(x, y, w, h, b, r, d);

}



void draw()

{

  button.update();

  button.display();

}



class Button

{

  int x, y;

  int w, h;

  color basecolor, highlightcolor;

  color currentcolor;

  boolean isOver = false;

  boolean isPressed = false;   

  

  void pressed() {

    if(isOver && mousePressed) {

      isPressed = true;

    } else {

      isPressed = false;

    }    

  }

  

  boolean overRect(int x, int y, int width, int height) {

  if (mouseX >= x && mouseX <= x+width && 

      mouseY >= y && mouseY <= y+height) {

    return true;

  } else {

    return false;

  }

}

}



class ImageButtons extends Button 

{

  PImage base;

  PImage roll;

  PImage down;

  PImage currentimage;



  ImageButtons(int ix, int iy, int iw, int ih, PImage ibase, PImage iroll, PImage idown) 

  {

    x = ix;

    y = iy;

    w = iw;

    h = ih;

    base = ibase;

    roll = iroll;

    down = idown;

    currentimage = base;

  }

  

  void update() 

  {

    over();

    pressed();

    if(isPressed) {

      currentimage = down;

    } else if (over){

      currentimage = roll;

    } else {

      currentimage = base;

    }

  }

  

  void over() 

  {

    if( overRect(x, y, w, h) ) {

      isOver = true;

    } else {

      isOver = false;

    }

  }

  

  void display() 

  {

    image(currentimage, x, y);

  }

}

