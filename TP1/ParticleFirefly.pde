// Classe de type ParticleFirefly, qui hérite de la classe Particle
// Défini les particules spécifiques qui interviennent lors de la phase d'animation

import processing.sound.*;

class ParticleFirefly extends Particle
{
  final static float probabilitySpawn = 0.25f;
  
  boolean clicked;
  int clickedRadius = 50;
  color colorClicked = color(255,200,10);
  float agitation;

  ParticleFirefly(color c)
  {
    super(c);
    
    clicked =false;

    lifetime = 5.0f;
    radius = 40;
  }

  void init()
  {
    super.init();

    ps.space.x = width;
    ps.space.y = height;

    position.x = ps.origin.x + random(0.0f, 1.0f) * ps.space.x - ps.space.x / 2.0f;
    position.y = ps.origin.y + random(0.0f, 1.0f) * ps.space.y - ps.space.y / 2.0f;
  }

  void update()
  {
    super.update();
    
    if (clicked){ 
      agitation = 1;
    }
    else
      agitation = 0.5f;
    
    position.x += agitation*(random(-1.0f, 1.0f) * 512.0f) * timeElapsed;
    position.y += agitation*(random(-1.0f, 1.0f) * 512.0f) * timeElapsed;
  }

  void render()
  {
    noStroke();
    if (clicked){
      fill(colorClicked, 127);
      ellipse(position.x, position.y, clickedRadius, clickedRadius);
      clicked = false;
    } else {
      fill(colorDiffuse, 127);
      ellipse(position.x, position.y, radius, radius);
    }
  }
  
  void setClicked(boolean value){
    clicked = value; 
  }
  
}
