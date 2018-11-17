class Board {
  Square[][] squares = new Square[8][8];
  
  //fill board w squares
  Board() {
    for (int i = 0; i < squares.length; i++)
      for (int j = 0; j < squares.length; j++)
        squares[i][j] = new Square(i, j);
  }
}
