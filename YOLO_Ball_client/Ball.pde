class Ball {
  float x = width/2;
  float y = height/2;
  float size = 30;
  float radius = size / 2;
  float grav = 0.5;
  float jumpForce = 15;
  
  float xSpeed = -10;
  float ySpeed;
  
  PVector position = new PVector(x,y);
  PVector velocity = new PVector(xSpeed,ySpeed);
  
  
  void movement() {
    if (position.x - radius < 0){
    position.x = radius;
    velocity.x *= -1;
    }
    if (position.x + radius > width){
    position.x = width - radius;
    velocity.x *= -1;
    }
    
    velocity.y += grav;
    position.add(velocity);
    display();
  }
  void display() {
    ellipse(position.x,position.y,size,size);
  }
  void jump() {
    velocity.y = 0;
    velocity.y -= jumpForce;
  }
  boolean outOfBounds(){
    if (position.y > height){
    return true;
    }
    else return false;
  }
}
