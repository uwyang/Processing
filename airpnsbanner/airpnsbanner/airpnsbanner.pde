int bannerwidth = 2050;
int bannerheight = 439;

int startxpos = -30;
int startypos = -100;

int bluemargin = 30;

int colspace = 100;
int rowspace = 100;


//color scheme from: 
//http://www.colorcombos.com/color-schemes/56/ColorCombo56.html
color[] sharpcolors = {#00CC00, #FF9900, #000099};
//Or, from the original
color[] origcolors = {#7CD279, #FCC135, #2D6C9C};


color[] colors = sharpcolors;
color greencolor = colors[0];
color orangecolor = colors[1];
color bluecolor = colors[2];

PImage[] imgs;

String imgpath ="C:/Users/Yang/Documents/airpns/pics/bannerpics/resized2";

void setup() {
  
  frameRate(1);
  
  size(bannerwidth, bannerheight);
  background(greencolor);
  imgs = loadImgsFromDir(imgpath);
  
  placeImgs(imgs);
}

void draw(){
  
}

void drawrect(int x, int y, int w, int h){
  pushMatrix();
  translate(x -bluemargin, y -bluemargin);
  noStroke();
  fill(bluecolor);
  rect(0, 0, w+ 2*bluemargin, h+2*bluemargin);
  popMatrix();
}

void placeImgs(PImage[] imgs){
  int currxpos = startxpos;
  int currypos = startypos;
  int currimgwidth = 0;
  int currimgheight = 0;
  
  for(int i=0; i< imgs.length; i++){
    PImage currimg = imgs[i];
    drawrect(currxpos, currypos, currimg.width, currimg.height);
    image(currimg, currxpos, currypos);
    currxpos  = currimg.width + currxpos+ colspace;
    if (currxpos > width){
      currxpos = startxpos; 
      currypos = currypos + currimg.height + rowspace;
    }
  }
}

PImage[] loadImgsFromDir(String dir) {
  String[] filedirs = listFileDirs(dir);
  PImage[] imgs = new PImage[filedirs.length];
  for (int i=0; i< imgs.length; i++){
    imgs[i] = loadImage(filedirs[i]);
  }
   return imgs;
}

String[] listFileDirs(String dir) {
  String[] filenames = listFileNames(dir);
  String[] filedirs = new String[filenames.length];
  for (int i=0; i< filedirs.length; i++){
    filedirs[i] = dir + "/" + filenames[i];
  }
  return filedirs;
}

String[] listFileNames(String dir) {

  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    println("Files processed: ");
    println(names);
    return names;
  } else {
    // If it’s not a directory
    return null;
  }
}

void mousePressed(){
  println("frame saved");
  saveFrame("./driveways###.jpg");
}

void keyPressed() {
  if (key == ENTER) {
    saveFrame("./driveways###.jpg");
  }
}
