import processing.net.*;

Server s;
Client c;
int port = 8080;
int connected = 0;
String input;
int[] data;

void setup() {
  size(300, 300);

  s = new Server(this, port);
}

void draw() {
  c = s.available();
  if (c != null) {
    data = readFromClient();
  }

  s.write(connected + "\n");

  background(200);
  textAlign(CENTER, CENTER);
  fill(50);
  text("Y\nO\nL\nO\n\nB\nA\nL\nL\n\n\nSERVER STARTED @\n" + Server.ip() + "\nON PORT " + port + "\n\nCLIENTS CONNECTED:\n" + connected + "/2", width / 2, height / 2.1);
}

int[] readFromClient() {
  input = c.readString(); 
  input = input.substring(0, input.indexOf("\n"));
  int[] array = int(split(input, ' '));
  
  return array;
}

void serverEvent(Server serv, Client clie) {
  println("client connected: " + clie.ip());
  connected++;
}

void disconnectEvent(Client clie) {
  println("client disconnected: " + clie.ip());
  connected--;
}
