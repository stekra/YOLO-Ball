class PickUp {
  float xWidth = 20;
  float yHeight = 20;
  float x = width/2-xWidth/2;
  float y = random(100,230);
  int alpha = 255;
  int cd = 2;
  
  void drawPickUp() {
    stroke(255,alpha);
    noFill();
    rect(x,y,xWidth,yHeight);
    alphaAnimation();
  }
  
  void alphaAnimation() {
    alpha += cd;
    if (alpha < 50 || alpha > 255) {
      cd*= -1;
    }
  }
}
