/// class for color: 
// hue, saturation, brightness and alpha 
// are stored in an 4 dim float array. 
//hsba value: 0-100. 

class hsba {
  float h, s, b;
  float a = 1;
  float c;
  boolean hasHue = false;

  public hsba(float h, float s, float b) {
    this.h = h;
    this.s = s;
    this.b = b;
    this.hasHue = true;
  }

  public hsba(float s, float b) {
    this.s = s;
    this.b = b;
    this.hasHue = false;
  }

  hsba getCopy() {
    hsba copy = new hsba(this.s, this.b);
    if (this.hasHue) {
      copy.hasHue = true;
      copy.h = this.h;
    }
    return copy;
  }

  void setA(float a) {
    this.a = a;
  }

  color getColor() {
    colorMode(HSB);
    //println("h: " + h + ", s: " + s + ", b: " + b);
    if(hasHue){
    return color(h, s, b);
    } else {
      return color(0, s, b);
    }
  }

  //returns the intermediate hue. 
  float getMidHue(float newh) {
    float h1 = min(h, newh);
    float h2 = max(h, newh);
    float d1 = h2-h1;
    float d2 = h1 + (255 - h2);
    if (d1<d2) {
      return h1 + d1/2;
    } else {
      return (h2 + d2/2)%255;
    }
  } 

  void brighten(float byb) {
    this.b += byb;
    this.b = min(this.b, 255);
  }

  void fade(float byh) {
    this.s -= byh;
    this.s = max(this.s, 0);
  }

  void avgHue(float newh) {
    if (this.hasHue) {
      this.h = getMidHue(newh);
    } else {
      this.h = newh;
      this.hasHue = true;
    }
  }


  void avgHue(hsba newhsba) {
    if (!newhsba.hasHue) {
      if (this.hasHue) {
        //newhsba.h = this.h;
      } else {
      }
    } else {
      if (this.hasHue) {
        this.h = getMidHue(newhsba.h);
        newhsba.h = this.h;
      } else {
        this.h = newhsba.h;
        this.hasHue = true;
      }
    }
  }
  
  float avgHue(ArrayList <hsba> origarr){
    float r=0; 
    float g =0; 
    float b = 0;
    int num=0;
    //println("avg hue for " + origarr.size());
    for (int i=0; i<origarr.size(); i++){
      hsba currhsba = origarr.get(i); 
      if (currhsba.hasHue){
        color c = currhsba.getColor();
        num++;
        //println("point : " + i + ", r: " + red(c) + ", g: " + green(c) + ", b: " + blue(c));
        g += green(c);
        r += red(c);
        b += blue(c);
      }
    }
    g = g/num;
    r = r/num;
    b = b/num;
    colorMode(RGB);
   // println("r: " + r + ", g: " + g + ", b: " + b);
    color c = color(r, g, b);
    colorMode(HSB);
    return hue(c);
  }
  
}

