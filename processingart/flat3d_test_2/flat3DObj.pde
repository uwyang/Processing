class flat3dObj{
  float x, y, z;
  PVector viewerPos = new PVector(width/2, height/2, -311.5);
  float depth;
  float r = viewerPos.z;
  
  flat3dObj(float posx, float posy, float posz){
    this.x = posx;
    this.y = posy;
    this.z = posz;
    this.depth = abs(z - viewerPos.z);
  }
  
  float depthResize(){
    return abs(viewerPos.z/depth);
  }
  
  float xResize(){
    //stereo graphic projection;
    if(x==0){
      return 1;
    }
    float dangle = abs(asin(1/sqrt(depth*depth + 1*1)));
    float xangle = abs(atan(x/depth));
    return (tan(dangle + xangle) - tan(xangle))*depth;
  }
  
  float yResize(){
    if(y==0){
      return 1;
    }
    float dangle = abs(asin(1/sqrt(depth*depth + 1*1)));
    float yangle = abs(atan(y/depth));
    return (tan(dangle + yangle) - tan(yangle))*depth;
  }
  
  //fake integration
  float xRepos(){
    if (this.x==0){
      return 0;
    }
    float currx = 0;
    for (int i=0; i< round(abs(x)); i++){
      flat3dObj obj = new flat3dObj(i, 0, z);
      currx += obj.xResize();
    }
    return currx*x*sign(x)/round(x);
    //float xangle = abs(atan(x/depth));
    //return sign(x)*depth*((float) -Math.log(cos(xangle)));
    //return x*r/((float)Math.sqrt(r*r - x*x));
    
  }
  
  float yRepos(){
    if(this.y ==0){
      return 0;
    }
    
    float curry = 0;
    for (int i=0; i< round(abs(y)); i++){
      flat3dObj obj = new flat3dObj(0, i, z);
      curry += obj.yResize();
    }
    return curry*y*sign(y)/round(y);
  }
  
  int sign(float n){
    if(n>0){
      return 1;
    }else if(n<0){
      return -1;
    }
    return 0;
  }
  
}
