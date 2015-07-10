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

