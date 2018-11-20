class Player {
  
  float moveSpeed = 10f;
  float lerpAmount = 0.25f;

  float x = width/2;
  float y = 6*90 - 40;
  float xWidth = 100;
  float yHeight = 10;
  float px;
  float constrainLeft;
  float constrainRight;
  
  public Player(float cL, float cR) {
    this.constrainLeft = cL;
    this.constrainRight = cR;
  }

  void movement(float mousePos) {
    x = lerp(x, mousePos - (xWidth/2), lerpAmount);
    x = constrain(x,constrainLeft, constrainRight-xWidth);
    display();
    //colisionBall();
    px = x;
  }

  void display() {
    rect(x, y, xWidth, yHeight);
  }

  void colisionBall() {
    for (Ball newBall : ballList) {
      if (newBall.position.x + newBall.radius > x
       && newBall.position.y + newBall.radius > y
       && newBall.position.x - newBall.radius < x + xWidth
       && newBall.position.y - newBall.radius < y + yHeight) {
        newBall.velocity.x += playerSpeed() * 0.5;
        newBall.jump(20);
      }
    }
  }
  
  float playerSpeed () {
    return x - px;    
  }
}
