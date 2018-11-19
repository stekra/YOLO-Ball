import processing.net.*;

Client c;
String input;
int[] data;

void setup() {
  c = new Client(this, "10.128.136.193", 8080);
}

void draw() {
  if (c.available() > 0) {
    data = readFromServer();
    println(data);
  }
}

int[] readFromServer() {
  input = c.readString(); 
  input = input.substring(0, input.indexOf("\n"));
  int[] array = int(split(input, ' '));
  
  return array;
}
