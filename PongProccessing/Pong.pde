import ddf.minim.*;

Minim minim;
AudioPlayer main;
//images
PImage backImg;
PImage startImg;
PImage OtherImg;
//font
PFont font;
//the integers
int gamerunning = 1;
int x,y,w,h,speedx,speedy;
int tempSpeedX, tempSpeedY, pausePaddle, tempPaddle;
int RightPaddleX, RightPaddleY, LeftPaddleX, LeftPaddleY, paddlew, paddleh, paddleS;
boolean UpR, DownR, UpL, DownL, pause;
color colorL=color(0,255,0), colorR=color(255,0,0);
int ScoreL = 0, ScoreR = 0;
int winscore = 6;

void setup(){
  //sound
  minim = new Minim(this);
  main = minim.loadFile("looperman-l-0630386-0114602-josephfunk-lo-fi-funk1-dirty-bass1-105.wav");
  //background size:
  size(800,600);
  backImg = loadImage("PongBackground.png");
  startImg = loadImage("StartImg.png");
  OtherImg = loadImage("OtherImg.png");
  //declaring integers values:
  //ball
  x=width/2;
  y=height/2;
  w=25; 
  h=25;
  speedx=6;
  speedy=4;
  //font
  font = loadFont ("BNMachine-40.vlw");
  textFont(font);
  //paddles
  rectMode(CENTER);
  LeftPaddleX = 30;
  LeftPaddleY=height/2;
  
  RightPaddleX = width -30;
  RightPaddleY=height/2;
  
  paddlew = 22;
  paddleh= 120;
  paddleS= 8;
  
  
}

void draw(){
  /*
  these are placed in draw instead of setup so that
  the objects do not leave a trail  by creating a new 
  frame each time
  */
  //background(0);
  if (gamerunning ==1){
    imageMode(CORNER);
    image(startImg, 0, 0);
    fill(255);
    textAlign(CORNER);
    text ("Press Enter to play",width/2-30,height/2- 40);
    text ("Press Ctrl for Controls",width/2-30,height/2+ 20);
    text ("Press Esc to exit",width/2-30,height/2+ 80);
    if (keyCode == ENTER){
      gamerunning = 2;
    }
    if (keyCode == CONTROL){
      gamerunning = 3;
    }
  }
  if (gamerunning ==2){ 
    imageMode(CORNER);
    image(backImg, 0, 0);
    drawBall();
    bounce();
    moveBall(); 
  
    drawPaddle();
    movePaddle();
    boundryPaddle();
    collisionPaddle();
  
    if (pause == true){
      paused();
      }
    Scores();
    endGame();
  }
  if (gamerunning ==3){ 
    image(OtherImg, 0, 0);
    fill(255);
    textAlign(CORNER);
    text ("To pause press P  ",width/2-200,height/2 -160);
    text ("Player 1,",width/2-200,height/2 - 110);
    text ("W,A,S,D",width/2-200,height/2 - 70);
    text ("Player 2,",width/2 + 70,height/2 - 110);
    text ("Arrow keys",width/2 + 70,height/2 - 70);
    text ("Press B to return to main menu",width-width + 10 ,height- 30);
    if (key == 'b' || key == 'B'){
        gamerunning = 1;
      }
  }
  
}
  
  

/*
these are methods that are helpful to organise my code,
this may not be useful for efficency however it makes 
the code much more appealing and clearer to read.
*/
void paused(){
  fill(5,100,255);
  textAlign(CENTER,CENTER);
  text("Paused, press C to continue.",width/2,height/3-20);
  text("or Esc to exit", width/2, height/3 +20);
  }

void drawBall(){
  fill(5,100,255);
  ellipse(x,y,w,h);
}


void moveBall(){
  x = x + speedx;
  y = y + speedy;
}

void bounce(){
  //the X-axis for the ball:
  if( x > width-w/2){
    setup();
    speedx = -speedx;
    ScoreL = ScoreL+1;
  }
  else if (x < 0+w/2){
    speedx= -speedx;
    ScoreR = ScoreR+1;
    setup();
    
  }
  // The Y-axis for the ball:
  if (y > height -h/2){
    speedy=-speedy;
  }
  else if (y < 0+h/2){
    speedy= -speedy;
  }
}  

void drawPaddle(){
  fill(colorL);
  //leftpaddle
  rect(LeftPaddleX,LeftPaddleY,paddlew,paddleh);
  //rightpaddle
  fill(colorR);
  rect(RightPaddleX,RightPaddleY,paddlew,paddleh);
}

void movePaddle(){
  //"if(UpL)" is equivelent to "if(UpL= true)"
  if(UpL){
    LeftPaddleY = LeftPaddleY -paddleS;
  }
  if(DownL){
    LeftPaddleY = LeftPaddleY +paddleS;
  }
  if(UpR){
    RightPaddleY = RightPaddleY -paddleS;
  }
  if(DownR){
    RightPaddleY = RightPaddleY +paddleS;
  }
}

void boundryPaddle(){
  if(LeftPaddleY - paddleh/2 <0)  {
    LeftPaddleY = LeftPaddleY + paddleS;
  }
  if(LeftPaddleY + paddleh/2 >height){
    LeftPaddleY = LeftPaddleY - paddleS;
  }
  if(RightPaddleY - paddleh/2 <0)  {
    RightPaddleY = RightPaddleY + paddleS;
  }
  if(RightPaddleY + paddleh/2 >height){
    RightPaddleY = RightPaddleY - paddleS;
  }
}

void collisionPaddle(){
  if(x - w/2 < LeftPaddleX+paddlew/2 
  && y - h/2 < LeftPaddleY+paddleh/2 
  && y + h/2 > LeftPaddleY-paddleh/2 ){
    if(speedx<0){
      speedx = speedx-1;
      speedx=-speedx;
    }
  }
  
  else if(x + w/2 > RightPaddleX-paddlew/2 
  && y - h/2 < RightPaddleY+paddleh/2 
  && y + h/2 > RightPaddleY-paddleh/2 ){
    if(speedx>0){
      speedx=speedx+1;
      speedx=-speedx;
    }
  }
  
}

void Scores(){
  textAlign(CENTER,CENTER);
  fill(colorL);
  text(ScoreL,350,50);
  fill(colorR);
  text(ScoreR,width-350,50);
}

void endGame(){
  if(ScoreL==winscore){
    endScreen("Green Wins!", colorL);
  }
  if(ScoreR==winscore){
    endScreen("Red Wins!", colorR);
  }
}

void endScreen(String text, color c){
  
  speedx=0;
  speedy=0;
  
  fill(c);
  text(text,width/2,height/3);
  fill(5,100,255);
  text ("Game Over",width/2,height/3- 40);
  text("Click to play again or Esc to exit", width/2, height/3 + 40);
  
  if (mousePressed){
    ScoreL = 0;
    ScoreR = 0;
    speedx=8;
    speedy=5;
  }
  
}

void keyPressed(){
  if(key == 'w' || key == 'W' ){
    UpL = true;
  }
  if(key == 's' || key == 'S' ){
    DownL = true;
  }
  if(keyCode == UP){
    UpR = true;
  }
  if(keyCode == DOWN){
    DownR = true;
  }
  if(keyCode == ESC){
    exit();
  }
  
  //pause
  if(key == 'p' ||key == 'P'){
    while (speedx !=0){
      pause = true;
      tempSpeedX = speedx;
      tempSpeedY = speedy;
      tempPaddle = paddleS;
      paddleS = 0;
      speedx = 0;
      speedy= 0;
    }
  }
  //continue
  if(key == 'c' || key =='C'){
    if (speedx == 0){
      speedx = tempSpeedX ;
      speedy= tempSpeedY ;
      paddleS = tempPaddle;
      tempPaddle = 0;
      tempSpeedX = 0;
      tempSpeedY = 0;
      pause=false;
      }
    }
  }


void keyReleased(){
  if(key == 'w' || key == 'W' ){
    UpL = false;
  }
  if(key == 's' || key == 'S' ){
    DownL = false;
  }
  if(keyCode == UP){
    UpR = false;
  }
  if(keyCode == DOWN){
    DownR = false;
  }
}