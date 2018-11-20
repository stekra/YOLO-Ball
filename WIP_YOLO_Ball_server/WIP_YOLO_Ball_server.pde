import processing.net.*;

//<network stuff>
Client c;
Server s;
int port = 8080;
String output;
float[] inputData = {0, 0};
ArrayList<String> clients = new ArrayList<String>();
int connected;
//</network stuff>

ArrayList<Ball> ballList = new ArrayList <Ball>();
Ball activeBall;
int scoreTeam1 = 0;
int scoreTeam2 = 0;
int winCondition = 10;
float leftWon = 0;
boolean startScreen = true;
boolean endScreen = false;
boolean started = false;
int state = 0;  //0: start, 1: game, 2: end

Player player1;
Player player2;
Walls net;
PickUp pickUp;

void setup() {
  size(960, 540);
  pixelDensity(displayDensity());

  player1 = new Player(0, width/2-20);
  player2 = new Player(width/2+20, width);
  net = new Walls();
  pickUp = new PickUp();

  Ball newBall = new Ball();
  activeBall = newBall;
  ballList.add(newBall);

  s = new Server(this, port);
}

void draw() {
  c = s.available();

  if (c != null) {
    inputData = readFromClient();
  }

  if (inputData[1] == 1f) {
    if (state == 0)
      state++;
    if (state == 2)
      state--;
  }

  connected = clients.size();

  //server interface
  background(0);
  textSize(12);
  textAlign(CENTER, CENTER);
  fill(255);
  text("Y\nO\nL\nO\n\nB\nA\nL\nL\n\n\nSERVER STARTED @\n" + Server.ip()
    + "\nON PORT " + port
    + "\n\nCLIENTS CONNECTED:\n" + connected + "/2", width / 2, height / 2.05);
  noFill();
  stroke(255);
  rect(10, 10, width - 20, height - 20);

  if (state == 0) {
    startScreen = true;
    endScreen = false;
  } else if (state == 1) {
    startScreen = false;
    endScreen = false;
  } else if (state == 2) {
    startScreen = false;
    endScreen = true;
  }

  gaem();

  //data to clients
  output  = player1.x + " ";
  output += player2.x + " ";
  output += activeBall.position.x + " ";
  output += activeBall.position.y + " ";
  output += scoreTeam1 + " ";
  output += scoreTeam2 + " ";
  output += state + " ";
  output += pickUp.y + " ";
  output += leftWon + " ";
  output += activeBall.size;

  s.write(output + "\n");
}

void gaem() {
  if (c != null) {
    if (clients.indexOf(c.ip()) == 0)
      player1.movement(inputData[0]);
    else
      player2.movement(inputData[0]);
  }

  //ball calculation
  if (state == 1) {
    for (int i = 0; i < ballList.size(); i++) {
      ballList.get(i).movement();

      if (ballList.get(i).outOfBounds()) {
        ballList.remove(i);

        Ball newBall = new Ball();
        activeBall = newBall;
        ballList.add(newBall);
      }
    }
  }

  determineWinner();
}

void determineWinner() {
  if (scoreTeam1 >= winCondition) {
    leftWon = 1;

    state++;
    scoreTeam1 = 0;
    scoreTeam2 = 0;
  } else if (scoreTeam2 >= winCondition) {
    leftWon = 0;

    state++;
    scoreTeam1 = 0;
    scoreTeam2 = 0;
  }
}

float[] readFromClient() {
  String input = c.readString(); 
  if (input != null)
    input = input.substring(0, input.indexOf("\n"));
  float[] array = float(split(input, ' '));

  return array;
}

void serverEvent(Server serv, Client clie) {
  println("client connected: " + clie.ip());

  if (!clients.contains(clie.ip()))
    clients.add(clie.ip());
}

void disconnectEvent(Client clie) {
  println("client disconnected: " + clie.ip());

  if (clients.contains(clie))
    clients.remove(clie);
}
