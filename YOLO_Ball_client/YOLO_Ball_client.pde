import processing.net.*;

//network stuff
Client c;
String output;
float[] data = {0, width/2+40, width/2, height/2, 0, 0, 0, 100}; //content: [player1X, player2X, ballX, ballY]

ArrayList<Ball> ballList = new ArrayList <Ball>();
int state = 0;
boolean startScreen = true;
boolean endScreen = false;
int scoreTeam1 = 0;
int scoreTeam2 = 0;
String winner = "";
boolean send1 = false;
int isPressed = 0;

Player startScreenPlayer;
Player player1;
Player player2;
Walls net;
PickUp pickUp;
Ball ball;

void settings() {
  int canvasSize = 60;
  size(canvasSize*16, canvasSize*9);
  pixelDensity(displayDensity());
}

void setup() {
  player1 = new Player(0, width/2-20);
  player2 = new Player(width/2+20, width);
  startScreenPlayer = new Player(0, width);
  net = new Walls();
  pickUp = new PickUp();
  ball = new Ball();

  c = new Client(this, "10.128.136.193", 8080);
}

void draw() {
  //write to server
  output = mouseX + " ";
  if (isPressed <= 0) {
    if (keyPressed && key == ' ') {
      output += "1 ";
      isPressed = 300;
    }
  } else {
    output += "0 ";
    isPressed--;
  }
  c.write(output + "\n");

  //read from server
  if (c.available() > 0) {
    data = readFromServer();
  }

  background(0);
  fill(255);

  state = int(data[6]);

  if (state == 0) {
    startScreen();

    ballList.clear();

    scoreTeam1 = 0;
    scoreTeam2 = 0;

    startScreenPlayer.movement(mouseX);

    startScreen = true;
    endScreen = false;
  } else if (state == 1) {
    player1.x = data[0];
    player2.x = data[1];
    player1.display();
    player2.display();

    ball.position.x = data[2];
    ball.position.y = data[3];
    ball.size = data[9];
    ball.display();

    scoreTeam1 = int(data[4]);
    scoreTeam2 = int(data[5]);

    pickUp.y = data[7];
    pickUp.drawPickUp();

    drawInGame();

    startScreen = false;
    endScreen = false;
  } else if (state == 2) {
    if (data[8] == 0.)
      winner = "RIGHT";
    else
      winner = "LEFT";
    endScreen(winner);

    ballList.clear();

    scoreTeam1 = 0;
    scoreTeam2 = 0;

    startScreenPlayer.movement(mouseX);

    startScreen = false;
    endScreen = true;
  }
}

float[] readFromServer() {
  String input = c.readString(); 
  input = input.substring(0, input.indexOf("\n"));
  float[] array = float(split(input, ' '));

  return array;
}
