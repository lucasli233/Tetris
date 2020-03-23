class Tetromino {
  int Te[][] = new int [4][2];// a 4x2 grid can fit in all the Tetrominos
  int col = 0;
  public Tetromino() {
    col = int(random(1, 8));
    //col = 7;
    if (col==1) { //I
      Te[1][0] = -2;
      Te[2][0] = -1;
      Te[3][0] = 1;
    } else if (col==2) { //J
      //Te[1][0] = 1;
      //Te[2][0] = -1;
      //Te[3][0] = -1;
      //Te[3][1] = -1;
      Te[1][0] = 1;
      Te[2][0] = -1;
      Te[3][0] = -1;
      Te[3][1] = -1;
    } else if (col==3) { //L
      Te[1][0] = 1;
      Te[2][0] = -1;
      Te[3][0] = 1;
      Te[3][1] = -1;
    } else if (col==4) { //O
      Te[1][0] = 1;
      Te[2][1] = 1;
      Te[3][0] = 1;
      Te[3][1] = 1;
    } else if (col==5) { //S
      Te[1][0] = -1;
      Te[2][1] = -1;
      Te[3][0] = 1;
      Te[3][1] = -1;
    } else if (col==6) { //T
      Te[1][0] = 1;
      Te[2][0] = -1;
      Te[3][1] = -1;
    } else if (col==7) { //Z
      Te[1][0] = 1;
      Te[2][1] = -1;
      Te[3][0] = -1;
      Te[3][1] = -1;
    }
  }

  public void rot() {
    for (int i=0; i<4; i++) {
      int temp = Te[i][0];
      Te[i][0] = Te[i][1];
      Te[i][1] = -temp;
    }
  }

  public int getTeX(int i) {
    return Te[i][0];
  }
  public int getTeY(int i) {
    return Te[i][1];
  }
  public int getMaxX() {
    int i = 0;
    for (int j=0; j<4; j++) {
      if (Te[j][0] > Te[i][0]) i=j;
    }
    return Te[i][0];
  }
  public int getMinX() {
    int i = 0;
    for (int j=0; j<4; j++) {
      if (Te[j][0] < Te[i][0]) i=j;
    }
    return Te[i][0];
  }
  public int getMaxY() {
    int i = 0;
    for (int j=0; j<4; j++) {
      if (Te[j][1] > Te[i][1]) i=j;
    }
    return Te[i][1];
  }
  public int getMinY() {
    int i = 0;
    for (int j=0; j<4; j++) {
      if (Te[j][1] < Te[i][1]) i=j;
    }
    return Te[i][1];
  }
  public int getColor() {
    return col;
  }

  boolean isOccupied(int x, int y) {
    if (y<0 && x<cols && x>=0 ) return false;
    return true;
  }
}
