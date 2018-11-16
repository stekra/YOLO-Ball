import processing.net.*; 

//hello github!

Client c; 
String input;
int data[]; 

void setup() { 
  size(450, 255); 
  background(204);
  stroke(0);
  frameRate(60); // Slow it down a little
  // Connect to the server’s IP address and port­
  c = new Client(this, "10.128.136.193", 8080); // Replace with your server’s IP and port
} 

void draw() {         
  if (mousePressed == true) {
    // Draw our line
    stroke(255);
    line(pmouseX, pmouseY, mouseX, mouseY); 
    // Send mouse coords to other person
    c.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");
  }

  // Receive data from servers
  if (c.available() > 0) { 
    input = c.readString(); 
    input = input.substring(0,input.indexOf("\n"));  // Only up to the newline
    data = int(split(input, ' '));  // Split values into an array
    // Draw line using received coords
    stroke(0);
    line(data[0], data[1], data[2], data[3]); 
  } 
}
