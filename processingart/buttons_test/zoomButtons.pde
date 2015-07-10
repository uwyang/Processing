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

