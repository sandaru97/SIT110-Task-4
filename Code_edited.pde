//Variables used to store values

float backColor1 = 255, backColor2 = 255, backColor3 = 255; 
float circleColor1 = 0, circleColor2 = 0, circleColor3 = 0;
float xLoc = 640, yLoc = 360, xSpeed = 3, ySpeed = 3, ballSize = 50, LocalballSize = 50;
float sx1 = 0, sy1 = 0, sw1 = 1280, sh1 = 50;
float sx2 = 0, sy2 = 0, sw2 = 50, sh2 = 720;
float sx3 = 1230, sy3 = 0, sw3 = 50, sh3 = 720;
float sx4  = 0, sy4 = 670, sw4 = 1280, sh4 = 50;
long lastTime;
//Stores framerate 
int Frate=60;
//------------------------------------------------------------------
//setup th edrawing
void setup(){
  size(1280, 720);
  lastTime = millis();
  noStroke();
} //<>//

//------------------------------------------------------------------

void changeBallSize()
{
  //Discrete Input
  
  if ((keyPressed == true) && (key == 's'))  //Decrease ball size
  {
   // if (millis() - lastTime > 500)    //Set timer
   // {
      ballSize = ballSize - 10;
      LocalballSize=LocalballSize-10;
      lastTime = millis();
   // }
  }
  if ((keyPressed == true) && (key == 'w'))  //Increase ball size
  {
    //if (millis() - lastTime > 500)  //Set timer
    //{
      ballSize = ballSize + 10;
            LocalballSize=LocalballSize+10;

      lastTime = millis();
   // }
  }
  if ((keyPressed == true) && (key == 'a'))  //Deccrease speed
  {
    
      Frate-=1;
      frameRate(Frate); // }
  }
  if ((keyPressed == true) && (key == 'd'))  //Inccrease speed
  {
    
      Frate+=1;
      frameRate(Frate); // }
  }
}

//------------------------------------------------------------------

void drawBackground()
{
  //Discrete Input
  
  if ((keyPressed == true) && (key == 'c'))  //Change background colour
  {
     if (millis() - lastTime > 500)   //Set timer
     {
      backColor1 = random(255);
      backColor2 = random(255);
      backColor3 = random(255);
      lastTime = millis();
     }
  }
  background(backColor1,backColor2,backColor3);    //Set background color
}

//------------------------------------------------------------------

void changeCircleColor()

  //Discrete Input
{
  if ((keyPressed == true))    //Change circle color
  {
     if (millis() - lastTime > 500)  //Set timer
     {
      circleColor1 = random(255);
      circleColor2 = random(255);
      circleColor3 = random(255);
      lastTime = millis();
     }
  }
  fill(circleColor1,circleColor2,circleColor3);    //Set circle color
}

//------------------------------------------------------------------

void spawnBall(float xBall, float yBall) 
{
  changeCircleColor();    //Call ball color function
  ellipse(xBall, yBall, LocalballSize, LocalballSize);  //Set ball at mouse location with model size
}

//------------------------------------------------------------------
  
void drawScreen()
{
  fill(255);
    for(int x=0;x<width;x=x+10){
      for(int y=0;y<height;y=y+10){
      ellipse(x,y,10,10);
  }
  }
}
//------------------------------------------------------------------

void mousePressed()
{
  yLoc = mouseY; 
  xLoc = mouseX;  
  LocalballSize = ballSize;   //Set moving ball size to mouse cursor ball size
}

//------------------------------------------------------------------

void Movement() 
{
  //Continuous Input
  
  xLoc = xLoc + xSpeed;  //X movement per tick
  yLoc = yLoc + ySpeed;  //Y movement per tick
  boolean hit1 = circleRect(xLoc,yLoc,(LocalballSize/2),sx1,sy1,sw1,sh1);
  boolean hit2 = circleRect(xLoc,yLoc,(LocalballSize/2),sx2,sy2,sw2,sh2);
  boolean hit3 = circleRect(xLoc,yLoc,(LocalballSize/2),sx3,sy3,sw3,sh3);
  boolean hit4 = circleRect(xLoc,yLoc,(LocalballSize/2),sx4,sy4,sw4,sh4);
  if (hit4)
  {
    ySpeed = ySpeed * -1;  //Reverse Y
  }
  if (hit1)
  {
    ySpeed = 3;  //Reset Y
  }
  if (hit3)
  { 
    xSpeed = xSpeed * -1; //Reverse X
  }
  if (hit2)
  {
    xSpeed = 3; //Reset X
  }
}

//------------------------------------------------------------------

boolean circleRect(float cx, float cy, float radius, float rx, float ry, float rw, float rh) 
{
  
  //Continuous Input
  float testX = cx;
  float testY = cy;


  if (cx < rx)         testX = rx;      // test left edge
  else if (cx > rx+rw) testX = rx+rw;   // right edge
  if (cy < ry)         testY = ry;      // top edge
  else if (cy > ry+rh) testY = ry+rh;   // bottom edge

  float distX = cx-testX;
  float distY = cy-testY;
  float distance = sqrt( (distX*distX) + (distY*distY) );   //distance between middle of circle and rectangle edge

  if (distance <= radius) {
    return true;
  }
  return false;
}

//------------------------------------------------------------------

void draw(){
  //change circle colour
  changeCircleColor();
//draw bg
  drawBackground();
  //draw a circle at mouse x and y
  ellipse(mouseX,mouseY, ballSize, ballSize);  //Circle size model
  changeBallSize();
  //new ball

  spawnBall(xLoc,yLoc);
  //move ball
  Movement();
  //darw screen 
  drawScreen();
  //call new border
    //display instructions

drawScreen();
    newBorder();

        displaytext("Press any key to change color!\nPress W or S to change size!\nPress A or D to change speeed!");

}

//function displaytext takes string text as an argument and displays th etext.
//------------------------------------------------------------------
void displaytext(String text){
  textSize(32);
text(text, 100, 100); 
fill(0, 102, 153);
}

//function new border draws the borders
void newBorder(){
fill(circleColor1,circleColor2,circleColor3);
  rect(sx1,sy1,sw1,sh1);    //Top border
  rect(sx2,sy2,sw2,sh2);    //Left border
  rect(sx3,sy3,sw3,sh3);    //Right border
  rect(sx4,sy4,sw4,sh4);    //Bottom border
  
}