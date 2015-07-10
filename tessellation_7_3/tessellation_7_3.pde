float[] px = new float[0]; //mouse pressed marks
float[] py = new float[0];
float[] distance = new float[0]; //pixel distance to marked point
int[] idx = new int[0]; //used for sorting the pixels

PImage  myimg;
void setup() {
  size(400, 400);
  myimg = createImage(width, height, RGB);
  image(myimg, 0, 0);
  /*
  float[] arr1 = {1., 2., 10., 5., 7.};
  sortArrayDown(arr1, new int[] {0, 1, 2, 3, 4});
  println(arr1);
  */
}

void draw() {
  stroke(0);
  for (int i=0; i< px.length; i++) {
    rect(px[i], py[i], 3, 3); //draw the mark as tiny rectangle
  }
}

void mousePressed() { 
  px = append(px, mouseX); //add clicked point
  py = append(py, mouseY);
  distance = append(distance, 0); // memory for the distance
  idx = append(idx, 0); //add the id
  for (int x=0; x< width; x++) {
    for (int y=0; y<height; y++) {

      //initiate distance
      for (int i=0; i<px.length; i++) //distance to all other marks
        distance[i] = dist(x, y, px[i], py[i]);
      for (int i=0; i<idx.length; i++)
        idx[i] = i;

      //sorting distance -- closest to furthest
      sortArrayDown(distance, idx);

      int n = idx.length -1;
      set(x, y, color((idx[n]*126)%255, (idx[n]*133)%255, (idx[n]*144)%255));
    }
  }
  getEdge();
}

void getEdge() {
  for (int x=0; x<width-1; x++) {
    for (int y=0; y<height-1; y++) {
      if (abs(red(get(x, y)) - red(get(x+1, y)))>0 || abs(red(get(x, y)) - red(get(x, y+1)))>0)
        set(x, y, color(0));
      else
        set(x, y, color(255));
    }
  }
}

void sortArrayDown(float[] arr, int[] idx) {
  for (int i=0; i<arr.length; i++) {
    for (int j=0; j<arr.length-1; j++) {
      if (arr[i]> arr[j]) { //if big, then swap down. 
        float t = arr[i]; //swap in descending order
        arr[i] = arr[j];
        arr[j]  = t;
        int tr = idx[i];
        idx[i] = idx[j];
        idx[j] = tr;
      }
    }
  }
}

