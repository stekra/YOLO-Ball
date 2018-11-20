void drawInGame() {
  color netColor = 255; 

  netWalls();
  textAlign(CENTER);
  noStroke();
  fill(netColor);
  textSize(15);
  text("Y\nO\nL\nO\n \nB\nA\nL\nL", width/2, height-224);
  drawScore();
}

void netWalls() {
  stroke(255);
  noFill();
  rect(net.x, net.y, net.xWidth, net.yHeight);
}

void drawScore() {
  color scoreColor = 255;

  textAlign(CENTER);
  noStroke();
  fill(scoreColor);
  textSize(200);
  text(scoreTeam1, width/4, height/2);
  text(scoreTeam2, width*3/4, height/2);
}

void startScreen() {
  color startScreenColor = 255;
  background(0);
  textAlign(CENTER);
  noStroke();
  fill(startScreenColor);
  textSize(150);
  text("YOLO BALL", width/2, 200);

  textSize(25);
  text("a Game Frame I Project\nby Stefan Kraft && Moreno Vogel", width/2, 300);

  text("Press [SPACE] to Start", width/2, 410);
}

void endScreen(String team) {
  color startScreenColor = 255;
  background(0);
  textAlign(CENTER);
  noStroke();
  fill(startScreenColor);
  textSize(150);
  text(team +" WON", width/2, 200);

  textSize(25);
  text("a Game Frame I Project\nby Stefan Kraft && Moreno Vogel", width/2, 300);

  text("Press [SPACE] to Restart", width/2, 410);
}
