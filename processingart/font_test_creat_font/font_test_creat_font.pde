/* @pjs font="Arial.ttf"; */
        
void setup()
{
  size(200,200);
  noLoop();
  textFont(createFont("Arial",32));
}

void draw()
{
  background(255);
  String t = "P.js";
  float tw = textWidth(t);
  fill(0);
  text(t, (width-tw)/2, (height+32)/2);
}
