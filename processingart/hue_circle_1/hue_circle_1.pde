float currHue;
float currR;
float currBright;
color currColor;
float currx, curry;
float meanStep = 2;
float varStep = 1;
float brightStep = 10;


void setup(){
  size(400, 300);
  currHue = random(255);
  
  currx = random(width);
  curry = random(height);
  colorMode(HSB, 255);
  background(currHue, 255, 5);
  noStroke();
  fill(currHue, 255, 20);
  ellipse(currx, curry, 5, 5); 
}

void draw(){
  loadPixels();
  color[] pixelCopy = new color[pixels.length];
  arrayCopy(pixels, pixelCopy);
  for (int i=1; i<width-1; i++){
    for(int j=1; j<height-1; j++){
      int pixnum = getPixel(i, j); 
      color c = pixels[pixnum];
      float bc = brightness(c);
      if (bc>7){
        pixelCopy[pixnum] = brighten(c, random(brightStep));
        brightenNear(pixels, pixelCopy, i, j, 1.5); 
      }
      
    }
  }
  arrayCopy(pixelCopy, pixels);
  updatePixels();
}

int getPixel(int i, int j){
  return j*width + i;
}

void brightenNear(color[] pixelarr, color[] pixelto, int i, int j, float b){
  color c = pixelarr[getPixel(i+1, j)];
  pixelto[getPixel(i+1, j)] = brighten(c, random(b));
  c = pixelarr[getPixel(i+1, j+1)];
  pixelto[getPixel(i+1, j+1)] = brighten(c, random(b));
  c = pixelarr[getPixel(i+1, j-1)];
  pixelto[getPixel(i+1, j-1)] = brighten(c, random(b));
  c = pixelarr[getPixel(i-1, j)];
  pixelto[getPixel(i-1, j)] = brighten(c, random(b));
  c = pixelarr[getPixel(i-1, j+1)];
  pixelto[getPixel(i-1, j+1)] = brighten(c, random(b));
  c = pixelarr[getPixel(i-1, j-1)];
  pixelto[getPixel(i-1, j-1)] = brighten(c, random(b));
  c = pixelarr[getPixel(i, j+1)];
  pixelto[getPixel(i, j+1)] = brighten(c, random(b));
  c = pixelarr[getPixel(i, j-1)];
  pixelto[getPixel(i, j-1)] = brighten(c, random(b));
}

color brighten(color c, float b){
  return color(currHue, saturation(c), brightness(c) + b);
}
