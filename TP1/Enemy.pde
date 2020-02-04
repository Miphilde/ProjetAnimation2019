// Classe permettant la création d'un ennemi lors de la phase de jeu

class Enemy
{
  float positionX;
  float positionY;

  boolean active;
  
  PImage sprite;
  
  PVector target;
  float speed = 100.0f;
  float timeElapsed;
  float timeFrame;

  boolean dead;
  boolean crossed;
  boolean flee;


  Enemy(PImage img){
    sprite = img;
  }

  void render()
  {
    if (flee)
      rotate(PI);
    
    image(sprite, positionX, positionY);
  }
  
  void init(){
    active = true;
    crossed = false;
    dead = false;
    flee = false;
    
    positionX = random(0, width);
    positionY = 0;
    target = new PVector (positionX,height);
    
    timeFrame = millis();
  }
  
  void update(){
    timeElapsed = (millis() - timeFrame) / 1000.0f;
    timeFrame = millis();
    
    positionY += speed*timeElapsed;
    
    if (dead || crossed )
      active = false;
  }

  boolean collide( float x, float y){   
    
    if ((x >= positionX - sprite.width/2) && (x <= positionX + sprite.width/2) && (y >= positionY -sprite.height/2) && (y <= positionY + sprite.height/2)){
      return true;
    }
    else {
      return false;
    }
  }
}
