import processing.net.*;

Server s;
Client c;
int port = 8080;
String input;
int[] data = {0, width/2+20, width/2, height/2};
ArrayList<String> clients = new ArrayList<String>();
int connected;
int x;
int y = 500;

void setup() {
  size(400, 400);
  pixelDensity(displayDensity());

  s = new Server(this, port);
}

void draw() {
  c = s.available();
  
  if (c != null) {
    data = readFromClient();
  }

  s.write(data[0] + " " + y + " 480 270" + "\n");

  connected = clients.size();

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
}

int[] readFromClient() {
  input = c.readString(); 
  input = input.substring(0, input.indexOf("\n"));
  int[] array = int(split(input, ' '));

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
