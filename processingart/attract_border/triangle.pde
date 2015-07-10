class triangle {

  PVector[] points = new PVector[3];
  PVector center = new PVector();
  PVector speed = new PVector();
  float maxspeed = 10;
  boolean moving = false;
  float acceleration = 0.01; // in percentage
  boolean attract = true;

  public triangle(PVector[] pts) {
    points = pts;
    this.center = getCenter();
    setSpeed(0, 0);
  }

  void setTarget(PVector v) {
    float s = speed.mag();
    v.sub(center);
    v.normalize();
    if (attract) {
      v.mult(s);
    } else {
      v.mult(-s);
    }
    this.speed = v;
  }

  void updateme() {
    if (moving) {
      for (int i=0; i< points.length; i++) {
        points[i].x += speed.x;
        points[i].y += speed.y;
        this.center = getCenter();
        if (speed.mag()< maxspeed) {
          speed.x = speed.x*(1 + acceleration);
          speed.y = speed.y*(1 + acceleration);
        }
      }
    }
  }

  void drawme() {
    beginShape();
    vertex(points[0].x, points[0].y);
    vertex(points[1].x, points[1].y);
    vertex(points[2].x, points[2].y);
    endShape(CLOSE);
  }

  void setSpeed(float x, float y) {
    this.speed.x = x;
    this.speed.y = y;
  }

  void setSpeed(PVector v) {
    this.speed = v;
  }

  PVector getCenter() {
    float midx = points[0].x +points[1].x + points[2].x;
    float midy = points[0].y +points[1].y + points[2].y;
    return new PVector(midx/3, midy/3);
  }
}

