p/*
# Instructions
 # LEFT RIGHT to move
 # UP to rotate
 # SPACE or DOWN to drop
 
 */
int edge = 50;
int cols=10; //number of colomns
int rows = 20; // number of rows
int bs = 20; //block size
int Grid[][] = new int[cols][rows];
Tetromino t = new Tetromino();
int currentPos[] = new int[2]; //0 is x pos, 1 is y pos
int currentTime = 0;
int score = 0;
int line = 0;
Boolean gameOver = false;
Boolean gameOn = false;
int level = 0;

void setup() {
  size(320, 540);
  textSize(20);
  textAlign(CENTER, CENTER);
  t = new Tetromino();
  currentPos[0]= 4;
  currentPos[1] = 0;
}

void draw() {
  background(0);//black background
  //3 phases
  //welcome page - !gameOn, !gameOver
  //in game - gameOn, !gameOver
  //lost - !gameOn, gameOver
  if (!gameOn) {
    text("Press 'P' to start", 320/2, 540/2);
  }
  if (gameOn) {
    noStroke();
    for (int i=0; i<10; i++) {
      for (int j=0; j<20; j++) {
        if (Grid[i][j]==0) fill(100);
        else if (Grid[i][j]==1) fill(0, 255, 255);
        else if (Grid[i][j]==2) fill(0, 0, 255);
        else if (Grid[i][j]==3) fill(255, 127, 0);
        else if (Grid[i][j]==4) fill(255, 255, 0);
        else if (Grid[i][j]==5) fill(0, 255, 0);
        else if (Grid[i][j]==6) fill(127, 0, 255);
        else if (Grid[i][j]==7) fill(255, 0, 0);
        rect(i*22+edge, j*22+edge, bs, bs);
      }
    }

    displayCurrent();
    currentTime++;
    if (level==0) {
      if (currentTime>40) {
        currentTime = 0;
        currentPos[1]++;
      }
    }
    if (level==1) {
      if (currentTime>30) {
        currentTime = 0;
        currentPos[1]++;
      }
    }
    if (level==2) {
      if (currentTime>20) {
        currentTime = 0;
        currentPos[1]++;
      }
    }
    if (level==3) {
      if (currentTime>10) {
        currentTime = 0;
        currentPos[1]++;
      }
    }
    step();
    fill(255);
    text("Tetris2018", 2*edge, edge/2);
    text("Level : " + level, 320/2+edge, edge/2);
    text("Score : " + score, 2*edge, 540-(edge/2));
    text("Line : " + line, 320/2+edge, 540-(edge/2));
  }
  if (gameOver) {
    fill(0, 200);
    rect(0, 0, width, height);
    fill(255);
    text("You Lost!", 135, 275);
    text("Final Score: "+score, 135, 300);
    //text("Press 'R' to restart", 135, 325);
    noLoop();
  }
}

void keyPressed() {
  if (keyCode == LEFT) {
    boolean stop = false;
    for (int i=0; i<4; i++) {
      if ((t.getTeX(i)+currentPos[0]) > 0) {
        if ((t.getTeX(i)+currentPos[0])<(cols-1) && (t.getTeY(i)+currentPos[1])>0 && (t.getTeY(i)+currentPos[1])<(rows-1)) {
          if (Grid[(t.getTeX(i)+currentPos[0])-1] [(t.getTeY(i)+currentPos[1])]!=0)  stop = true;
        }
      } else stop = true;
    }
    if (!stop)  currentPos[0]--;
  }
  if (keyCode == UP) {
    t.rot();
    if ((t.getMinX()+currentPos[0])<0)  currentPos[0]-=(t.getMinX()+currentPos[0]); // make sure the shape after rotate is within bounds
    if ((t.getMaxX()+currentPos[0])>(cols-1))  currentPos[0]-=(t.getMinX()+currentPos[0]-(cols-1));
    if ((t.getMinY()+currentPos[1])<0)  currentPos[1]-=(t.getMinY()+currentPos[1]);
    if ((t.getMaxY()+currentPos[1])>(rows-1))  currentPos[1]-=(t.getMaxY()+currentPos[1]-(rows-1));
  }
  if (keyCode == RIGHT) {
    boolean stop = false;
    for (int i=0; i<4; i++) {
      if ((t.getTeX(i)+currentPos[0]) < (cols-1)) {
        if ((t.getTeX(i)+currentPos[0])>0 && (t.getTeY(i)+currentPos[1])>0 && (t.getTeY(i)+currentPos[1])<(rows-1)) {
          if (Grid[(t.getTeX(i)+currentPos[0])+1][(t.getTeX(i)+currentPos[0])]!=0) {
            stop = true;
          }
        }
      } else stop = true;
    }
    if (!stop)  currentPos[0]++;
  }
  if (keyCode == 32 || keyCode == DOWN) {//spacebar or DOWN
    currentPos[1]++;
    step();
  }
  if (keyCode == 80) { //p
    gameOver = false;
    gameOn = true;
  }
}


public void step() {
  boolean stop = false;

  for (int i = 0; i < 4; i++) {
    if (t.getTeY(i)+currentPos[1] < (rows-1)) {
      if (Grid[t.getTeX(i)+currentPos[0]][t.getTeY(i)+currentPos[1]+1] != 0) {
        stop = true;
      }
    }
  }

  if (t.getMaxY()+currentPos[1] == (rows-1) || stop) {
    score+=10;
    for (int i = 0; i < 4; i++) {
      if ((t.getTeY(i)+currentPos[1]) < 0) {
        gameOn = false;
        gameOver = true;
      } else Grid[(t.getTeX(i)+currentPos[0])][(t.getTeY(i)+currentPos[1])] = t.getColor();
    }
    int count = 0;
    for (int y = 0; y < 20; y++) {
      boolean destroy = true;
      for (int x = 0; x < 10; x++) {
        if (Grid[x][y] == 0) destroy = false;
      }
      if (destroy) {
        count++;
        line++;
        for (int y2 = y-1; y2 > -1; y2--) {
          for (int x = 0; x < 10; x++) {
            Grid[x][y2+1] = Grid[x][y2];
          }
        }
      }
    }
    if (count > 0) {
      if (count == 1) score+=40; //clear 1 line at a time +50 score
      else if (count == 2) score+=100; //clear 2 line at a time +50 score
      else if (count == 3) score+=200; //clear 3 line at a time +50 score
      else if (count == 4) score+=500; //clear one line at a time +50 score
    }
    if (line>=10 && line<20) {//after clearing 10 lines proceed to level 1
      level=1;
    }
    if (line>=20 && line<30) {//after clearing 20 lines proceed to level 2
      level=2;
    }
    if (line>=30) {//after clearing 30 lines proceed to level 3
      level=3;
    }
    t = new Tetromino();
    currentPos[0] = 4;//new tetromino spowns on the 4th horizontal block
    currentPos[1] = 0;

    displayCurrent();

    for (int i = 0; i < 4; i++) {
      if (t.getTeY(i)+currentPos[1] < (rows-1)) {
        if (Grid[t.getTeX(i)+currentPos[0]][t.getTeY(i)+currentPos[1]+1] != 0) {
          gameOn = false;
          gameOver = true;
        }
      }
    }
  }
}


void displayCurrent() {

  if (t.getColor() == 0) fill(100);
  else if (t.getColor()==1) fill(0, 255, 255);
  else if (t.getColor()==2) fill(0, 0, 255);
  else if (t.getColor()==3) fill(255, 127, 0);
  else if (t.getColor()==4) fill(255, 255, 0);
  else if (t.getColor()==5) fill(0, 255, 0);
  else if (t.getColor()==6) fill(127, 0, 255);
  else if (t.getColor()==7) fill(255, 0, 0);

  for (int i = 0; i < 4; i++) {
    if ((t.getTeY(i)+currentPos[1]) >= 0) {
      rect((t.getTeX(i)+currentPos[0])*22+edge, (t.getTeY(i)+currentPos[1])*22+edge, bs, bs);
    }
  }
}
