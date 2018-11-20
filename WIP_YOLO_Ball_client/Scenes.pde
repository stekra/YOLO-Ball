void drawNet() {
  color netColor = 255; 
  
  netWalls();
  textAlign(CENTER);
  noStroke();
  fill(netColor);
  textSize(15);
  text("Y\nO\nL\nO\n \nB\nA\nL\nL",width/2,height-224);
  drawScore();
}

void netWalls() {
  stroke(255);
  noFill();
  rect(net.x,net.y,net.xWidth,net.yHeight);
}

void drawScore() {
  color scoreColor = 255;
  
  textAlign(CENTER);
  noStroke();
  fill(scoreColor);
  textSize(200);
  text(scoreTeam1,width/4,height/2);
  text(scoreTeam2,width*3/4,height/2);
}

void startScreen() {
  
}
