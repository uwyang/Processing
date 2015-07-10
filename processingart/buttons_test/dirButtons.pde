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

