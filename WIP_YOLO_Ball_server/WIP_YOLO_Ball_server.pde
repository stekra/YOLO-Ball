import processing.net.*;

//<network stuff>
Client c;
Server s;
int port = 8080;
String input;
float[] data = {0, width/2+20, width/2, height/2};  //content: [player1X, player2X ballX, ballY]
float[] inputData = {0, 0};
ArrayList<String> clients = new ArrayList<String>();
int connected;
//</network stuff>

ArrayList<Ball> ballList = new ArrayList <Ball>();
Ball activeBall;
int scoreTeam1 = 0;
int scoreTeam2 = 0;
boolean started = false;

Player player1;
Player player2;
Walls net;

void setup() {
  size(960, 540);
  pixelDensity(displayDensity());

  player1 = new Player(0, width/2-20);
  player2 = new Player(width/2+20, width);
  net = new Walls();

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
    started = true;
    println("received start cmd");
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

  //GAME LOGIC
  if (c != null) {
    if (clients.indexOf(c.ip()) == 0)
      player1.movement(inputData[0]);
    else
      player2.movement(inputData[0]);
  }

  //ball calculation
  if (started) {
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

  //data to server
  data[2] = activeBall.position.x;
  data[3] = activeBall.position.y;

  s.write(player1.x + " " + player2.x + " " + data[2] + " " + data[3] + "\n");
}

float[] readFromClient() {
  input = c.readString(); 
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
