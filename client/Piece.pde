class Piece {
  //define position either through x, y
  //or by assigning the piece to a Square/Spot object
  
  //Individual pieces are own classes? idk

  boolean isValidMove(/* Square/Spot or coord*/) {
    //check if move is valid
    //i.e. if:
    //- spot is in range
    //- spot is not occupied by own color
    //- path is not blocked
    //use this to highlight possible moves too
    
    return true;
  }

  void move(/* Square/Spot or coord*/) {
    //change piece x, y;
  }

  void remove() {
    //remove piece from board
  }
}
