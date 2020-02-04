// Classe permettant le création d'une branche lors de la phase de jeu

class Branch
{
  float positionX;
  float positionY;

  float orientation;
  
  int length = 50;
  int thickness =5;

  float thinFactor = 0.75f;
  float shortFactor = 0.595f;

  boolean isTaken;
  boolean active;
  
  color branchColor = color(91, 60, 40);
  color takenColor;

  PVector target;
  float speed = 300.0f;
  float timeElapsed;
  float timeFrame;
  float timeInit;

  float lifeTime = 20000.0f;

  Branch(color c){
    takenColor = c;
  }

  void render()
  {
    noStroke();
    if (isTaken)
    {
      fill(takenColor);
    } else {
      fill(branchColor);
    }
  
    pushMatrix();

    translate(positionX, positionY);
    rotate(orientation);

    quad(-thickness*thinFactor/2, -(length/2+1), thickness*thinFactor/2, -(length/2+1), thickness/2, length/2, -thickness/2, length/2);
    translate(0, -length/2);
    
    quad(-thickness*thinFactor*thinFactor/2, -(length*shortFactor+1), thickness*thinFactor*thinFactor/2, -(length*shortFactor+1), thickness*thinFactor/2, 0, -thickness*thinFactor/2, 0);
   
    popMatrix();
  }
  
  void init(){
    isTaken = false;
    target = new PVector (positionX,positionY);
    active = true;
    
    orientation = random (-PI, PI);
    positionX = random(0, width);
    positionY = random(0, height);

    timeInit = millis();
  }
  
  void update(){
    timeElapsed = (millis() - timeFrame) / 1000.0f;
    timeFrame = millis();
    
    if (target.x !=0 || target.y !=0){
      positionX += (target.x)*speed*timeElapsed;
      positionY += (target.y)*speed*timeElapsed;
    } 
    if (timeFrame - timeInit > lifeTime)
      active = false;
  }

  boolean isClicked( float clickx, float clicky){  
    
    pushMatrix();
  
    clickx -= positionX;
    clicky -= positionY;
    float clickxr = clickx*cos(orientation) + clicky*sin(orientation);
    float clickyr = -clickx*sin(orientation) + clicky*cos(orientation);
  
    translate(positionX, positionY);
    rotate(orientation);  
    
    if ((clickxr >= - thickness/2) && (clickxr <= thickness/2) && (clickyr >= -(length/2+1 + length*shortFactor+1)) && (clickyr <= length/2)){
      popMatrix();
      return true;
    }
    else {
      popMatrix();
      return false;
    }
  }
  
  void setTarget( float x, float y){
    
    target = new PVector (x-positionX, y-positionY);
    target.normalize();
    orientation = PI+(atan2(y -positionY, x-positionX)-PI/2);
  }

}
