class blackshape{
  PImage img; 
  boolean[][] isblack;
  
  blackshape(PImage img){
    this.img = img; 
    color[] cs = img.pixels;
    
    isblack = new boolean[img.width][img.height];
    
    for (int i=0; i<img.width; i++){
      for (int j=0; j<img.height; j++){
        color c = cs[j*img.width + i];
        if(brightness(c)<100){
          isblack[i][j] = true;
        }else {
          isblack[i][j] = false;
        }
        
      }
    }
  }
  
  void drawme(){
    loadPixels();
    for (int i=0; i<img.width; i++){
      for (int j=0; j<img.height; j++){
        if(isblack[i][j]){
        pixels[j*isblack.length + i] = color(0);
        }else {
          pixels[j*isblack.length + i] = color(255);
        } 
      }
    }
    updatePixels();
  }
  
  
  
}
