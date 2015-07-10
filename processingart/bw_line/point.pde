class point{
  int x, y;
  boolean showPos=false;
  
  public point(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  public point getPointInR(float maxr){
    float r = random(maxr);
    float theta = random(TWO_PI);
    float newx = x + cos(theta)*r;
    float newy = y + sin(theta)*r;
    return new point(round(newx), round(newy));
  }
}

