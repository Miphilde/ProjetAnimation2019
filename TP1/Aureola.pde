// Classe permettant le création d'une auréole

class Aureola {
  int initPositionX;
  int initPositionY;
  float currentPositionX;
  float currentPositionY;

  PVector size;
  int agitation;
  int stroke;
  color halo;
  
  Aureola( int x, int y, PVector s, int a, int w, color c){
    initPositionX =x;
    initPositionY = y;
    currentPositionX = x;
    currentPositionY = y;
    size = s;
    agitation =a ;
    stroke = w;
    halo =c;
  }
 
  void render(){
   noFill();
   stroke(halo);
   strokeWeight(stroke);
   
   float randomX = random(-agitation, agitation);
   float randomY = random(-agitation,agitation);
   
   if (abs(currentPositionX + randomX - initPositionX) <stroke && abs(currentPositionY + randomY - initPositionY) < stroke){
     currentPositionX += randomX;
     currentPositionY += randomY;
   }
   
   ellipseMode(CENTER);
   ellipse( currentPositionX, currentPositionY, size.x, size.y);
  }
  
}
