class line{
  int x1, y1, x2, y2;
  float l;
  float theta;
  float blackness=0;
  
  public line(int x, int y){
    this.x1 = x;
    this.y1 = y;
  }
  
  //DO NOT USE! 
  //atan will return -PI/2 to PI/2, 
  //thus can not provide full directinoal information. 
  //(Can be fixed, but too much work. )
  public void line(int x, int y, int u, int w){
    this.x1 = x;
    this.y1 = y;
    this.x2 = u; 
    this.y2 = w;
    this.theta = atan((y2-y1)/(x2-x1));
    this.l = dist(x1, y1, x2, y2);
  }
  
  public void getpoint2(float maxr){
    this.theta = random(TWO_PI);
    float r = random(maxr);
    this.x2 = round(this.x1 + r*cos(theta));
    this.y2 = round(this.y1 + r*sin(theta));
    this.l = r;
  }
 
 //how un-bright the line is
 public float getBlackness(PImage img){
   int i=0;
   int currb = 0;
   float currr = 0;
   float currx, curry;
   float totalbrightness = 0;
   //guaranteed not to miss a point. 
   float rstep = 0.5;
   println(this.l);
   while(currr<= this.l){
     currx = x1 + cos(theta)*currr;
     curry = y1 + sin(theta)*currr;
     color c = img.get(round(currx), round(curry));
     //255: white.
     totalbrightness += brightness(c);
     i++;
     currr = currr + rstep;
   }
   return (1-(totalbrightness/i)/255);
 }
  
}
