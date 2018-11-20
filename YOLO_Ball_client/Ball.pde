class Ball {
  float x = width/2;
  float y = height/2;
  float size = random(20,45);
  float radius = size / 2;
  float grav = size/60;
  float airFriction = size/300;
  float jumpForce;
  int random = -1 + (int)random(2) * 2;

  float xSpeed = -7 * random;
  float ySpeed = -10;

  PVector position = new PVector(x, y);
  PVector velocity = new PVector(xSpeed, ySpeed);


  void movement() {
    //border check
    if (position.x - radius < 0) {
      position.x = radius;
      velocity.x *= -1;
    }
    if (position.x + radius > width) {
      position.x = width - radius;
      velocity.x *= -1;
    }
    colisionWithNet();
    
    // xSpeed reduction
    if (velocity.x < 0) {
      velocity.x += airFriction;
    }
    
    else if (velocity.x > 0) {
      velocity.x -= airFriction;
    }
    if (velocity.x > -0.09 && velocity.x < 0.09){
      velocity.x = 0;
    }

    velocity.y += grav;
    position.add(velocity);
    display();
  }

  void display() {
    stroke(0);
    fill(255);
    ellipse(position.x, position.y, size, size);
    offScreenDisplay();
  }
  
  void offScreenDisplay() {
    if (position.y < 0) {
      noStroke();
      fill(255, 100-position.y*2);
      triangle(position.x, 11, position.x+5, 20,position.x-5, 20);
    }
  }

  void jump(float jumpForce) {
    velocity.y = 0;
    velocity.y -= jumpForce;
  }

  boolean outOfBounds() {
    if (position.y > height) {
      if (position.x > width/2 && !startScreen) {
        scoreTeam1++;
      }
      else if (position.x < width/2 && !startScreen) {
        scoreTeam2++;
      }
      return true;
    } 
    else {
      return false;
    }
  }
  void colisionWithNet() {
    if (position.x+radius > net.x && position.x-radius < net.x+net.xWidth && position.y+radius > net.y && startScreen == false) {
      //horicontal Bounce
      if (velocity.y > 0 && position.y+radius < net.y+20) {
        jump(10);
        //check if on net and slow
        if (velocity.x < 1 && velocity.x > -1) {
          if (position.x > width/2){ 
            velocity.x += 3;
          }
          else {
            velocity.x -= 3;
          }
        }
      }
      else if (velocity.x > 0) {
        velocity.x *= -1;
        position.x -= 1;
      }
      
      else if (velocity.x < 0) {
        velocity.x *= -1;
        position.x += 1;
      }
    }
  }
}
