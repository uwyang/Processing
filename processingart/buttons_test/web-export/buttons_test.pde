PFont currFont =  loadFont("Verdana.ttf"); 
int zoom=10;
int x=200;
int y = 200;
textButton zin, zout;
dirButtons dbut;
zoomButtons abut;


void setup()
{
  size(300, 300);
  dbut = new dirButtons();
  zbut = new zoomButtons();
  textFont(currFont); 
  size(300, 300);
}

void draw() {
  background(200);
  handleButtons();
  fill(200, 200, 0);
  ellipse(x, y, zoom, zoom);
  //rect(100, 100, i, i);
}

void handleButtons() {
  dbut.update();
  zbut.update();

  if (zbut.isZIn()) {
    zoom++;
  } else if (zbut.isZOut() && zoom>0) {
    zoom--;
  }


  if (dbut.isLeft()) {
    x--;
  } else if (dbut.isRight()) {
    x++;
  } 

  if (dbut.isDown()) {
    y++;
  } else if (dbut.isUp()) {
    y--;
  }
}

class dirButtons {
  textButton l, r, u, d;

  public dirButtons() {
    u = new textButton(50, 20, "U");
    d = new textButton(50, 80, "D");
    l = new textButton(20, 50, "L");
    r = new textButton(80, 50, "R");
  }
  
  void update(){
    u.update();
    d.update();
    l.update();
    r.update();
  }

  boolean isUp() {
    return (mousePressed && u.isOver());
  }
  
  boolean isDown(){
    return (mousePressed && d.isOver());
  }
  
  boolean isLeft(){
    return (mousePressed && l.isOver());
  }
  
  boolean isRight(){
    return (mousePressed && r.isOver());
  }
}

class textButton
{
  int x, y;
  int w = 30;
  int h = 30;
  int corner = 5;
  int size;
  int fontSize = 20;
  String mytext = "O";
  color textcol = color(255);
  color col = color(0, 0, 0);
  color overcol= color(200, 0, 200);
  color downcol = color(255, 50, 255);

  textButton(int x, int y, String s) {
    this.x = x;
    this.y = y;
    this.mytext = s;
    drawButton(col);
  }

  void drawButton(color c) {
    rectMode(CENTER);
    fill(c);
    rect(x, y, w, h, corner);
    fill(textcol);
    textAlign(CENTER);
    textFont(currFont, fontSize);
    text(mytext, x, y+(h/4));
  }

  void update() {
    if (isOver()) {
      if(mousePressed){
        drawButton(downcol);
      }else{
        drawButton(overcol);
      }
    }else{
      drawButton(col);
    }
  }

  boolean isOver() {
    if (mouseX < x + w/2 && mouseX > x-w/2 && mouseY< y + w/2 && mouseY>y-w/2) {
      return true;
    }
    return false;
  }
}

class zoomButtons {
  textButton zin, zout;

  public zoomButtons() {
    zin = new textButton(30,height - 70, "+");
    zout = new textButton(30,height - 30, "-");
  }

  void update() {
    zin.update();
    zout.update();
  }

  boolean isZIn() {
    return (mousePressed && zin.isOver());
  }

  boolean isZOut() {
    return (mousePressed && zout.isOver());
  }
}


