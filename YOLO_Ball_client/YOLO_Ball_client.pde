ArrayList<Ball> ballList = new ArrayList <Ball>();

Player player1 = new Player();

void settings() {
  int canvasSize = 60;
  size(canvasSize*16, canvasSize*9);
}

void setup() {
}

void draw() {
  background(0);
  player1.movement();

  //ball calculation
  for (int i = 0; i < ballList.size(); i++) {
    ballList.get(i).movement();
  }
}
void mousePressed() {
  Ball newBall = new Ball();
  ballList.add(newBall);
}
