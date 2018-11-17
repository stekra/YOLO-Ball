import processing.net.*; 

//object setup suggestion:
//Board > Square/Spot > Piece
//maybe a Player object which has a list of all Pieces of the player?
//maybe unnecessary
//idk
//pls respond

Client c; 
String input;
int data[];
int canvasSize = 480;
int boardPieceWidth = canvasSize/8;
int boardPieceHeight = canvasSize/8;

void setup() { 
  size(480, 480); 
  
  for(int l = 0; l < 8; l++){
    for(int b = 0; b < 8; b++){
      if((l + b + 1) % 2 == 0){
        fill(0);
      } else{
        fill(255);
      }
      rect(l * boardPieceWidth, b * boardPieceHeight, (l + 1) * boardPieceWidth,(b + 1) * boardPieceHeight);
    }
  } 
  stroke(0);
  frameRate(60);
  c = new Client(this, "10.128.136.193", 8080);
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
