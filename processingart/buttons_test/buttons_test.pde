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

