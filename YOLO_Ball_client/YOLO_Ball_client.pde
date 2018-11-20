ArrayList<Ball> ballList = new ArrayList <Ball>();
int scoreTeam1 = 0;
int scoreTeam2 = 0;
int winCondition = 10;
boolean startScreen = true;
boolean endScreen = false;
String teamStore;

Player startScreenPlayer;
Player player1;
Player player2;
Walls net;
PickUp pickUp;

void settings() {
  int canvasSize = 60;
  size(canvasSize*16, canvasSize*9);
}

void setup() {
  player1 = new Player(0,width/2-20);
  player2 = new Player(width/2+20, width);
  startScreenPlayer = new Player(0,width);
  net = new Walls();
  pickUp = new PickUp();
  noSmooth();
}

void draw() {
  if (endScreen) {
    endScreen(teamStore);
    scoreTeam1 = 0;
    scoreTeam2 = 0;
    startScreenPlayer.movement();
    if(keyPressed && key == ' ') {
      ballList.clear();
      startScreen = false;
      endScreen = false;
      scoreTeam1 = 0;
      scoreTeam2 = 0;
    }
  }
  if (startScreen) {
    startScreen();
    startScreenPlayer.movement();
    if(keyPressed && key == ' ') {
      ballList.clear();
      startScreen = false;
      scoreTeam1 = 0;
      scoreTeam2 = 0;
    }
  }
  else if (!endScreen) {
    background(0);
    fill(255);
    pickUp.drawPickUp();
    player1.movement();
    player2.movement();
    drawInGame();
  }

  //ball calculation
  for (int i = 0; i < ballList.size(); i++) {
    ballList.get(i).movement();
    if (ballList.get(i).outOfBounds()) {
      ballList.remove(i);
    }
  }
  determineWinner();
}

void mousePressed() {
  Ball newBall = new Ball();
  ballList.add(newBall);
}

void determineWinner() {
  if (scoreTeam1 >= winCondition) {
    endScreen("LEFT");
    teamStore = "LEFT";
    endScreen = true;
    scoreTeam1 = 0;
    scoreTeam2 = 0;
  }
  else if (scoreTeam2 >= winCondition) {
    endScreen("RIGHT");
    teamStore = "RIGHT";
    endScreen = true;
    scoreTeam1 = 0;
    scoreTeam2 = 0;
  }
}
