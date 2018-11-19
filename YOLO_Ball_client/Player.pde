class Player {
  float moveSpeed = 10f;
  float lerpAmount = 0.25f;
  
  float x = width/2;
  float y =  6*90 -40;
  float xWidth = 50;
  float yHeight = 10;
  
  
  void movement(){
    x = lerp(x,mouseX - (xWidth/2),lerpAmount);
    display();
    colisionBall();
  }
  
  void display(){
    rect(x, y, xWidth,yHeight);
  }
  void colisionBall (){
    for (Ball newBall : ballList){
      if (newBall.position.x + newBall.size/2 > x && newBall.position.y + newBall.size/2 > y &&
      newBall.position.x - newBall.size/2 < x + xWidth && newBall.position.y - newBall.size/2 < y + yHeight){
      println("collision");
      newBall.jump();
      }
    }
  }
}
