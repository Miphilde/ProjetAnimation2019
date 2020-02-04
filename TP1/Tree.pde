// Classe permettant la construction d'un arbre fractal généré dynamiquement (génération procédurale)

class Tree {
  
  color trunkColor = color(91, 60, 40);
  color leafColor = color(9, 82, 40);
  float thinFactor = 0.75;
  
  PVector position;
  float angle;  
  float trunkLength;
  float trunkWidth;
  
  int depthMax;
  float aux;
  float junction;
  
  Tree( float a, PVector p, float l, float w){
   angle = a;
   position = p;
   trunkLength =l;
   trunkWidth =w;
   depthMax =0;
  }
  
  void render(int decay)
  {
  
    pushMatrix();
    // position initiale
    translate(position.x, position.y);
  
    // appel de la fonction récursive qui dessine chacune des branches de l'arbre
    tree(trunkLength, trunkWidth, 1, 0, 0, decay);
    popMatrix();
  
  }
  
  // fonction récursive qui dessine l'arbre branche par branche
  void tree(float segment, float width, int level, int side, int shadow, int decay)
  {
  
    noStroke();
    if ( depthMax == 0)
      fill(trunkColor, decay/4);
    else
      fill(color( map(level, 0, depthMax, 91,9)-shadow, map(level, 0, depthMax, 60, 82)-shadow, 40-shadow, decay));
    
    if (side ==0){
      quad(-width/2, -(segment+1), width/2, -(segment+1), width/(2*thinFactor), 0, -width/(2*thinFactor), 0);
      translate(0, -segment);
    }
    else if ( side> 0) {
      aux = sin(side*angle)*(width/(2*thinFactor));
      junction = cos(side*angle)*(width/(2*thinFactor));
      
      quad(-(width-junction), -(segment+aux+1), junction, -(segment+aux+1), junction, -aux, -(width-junction), tan(side*angle)*(width-junction));
      translate(width/2 - (width-junction), -(segment+aux));
    }
    else if (side <0){
      aux = sin(-side*angle)*(width/(2*thinFactor));
      junction = cos(-side*angle)*(width/(2*thinFactor));
      
      quad(width-junction, -(segment+aux+1), width-junction, tan(-side*angle)*(width-junction), -junction, -aux, -junction, -(segment+aux+1));
      translate(-width/2 + (width-junction), -(segment+aux));  
    }
  
  
    // appliquer le facteur de décroissance de la taille
    segment *= 0.595f;
    // valider la condition d'arrêt
    if (level <= depthMax)
    {
  
      level++;
      
      // dessiner la branche de très gauche
      pushMatrix();
      rotate(-2*angle);
      tree(segment, width*thinFactor, level, -2, 20, decay);
      popMatrix();    
      
      
      // dessiner la branche de droite
      pushMatrix();
      rotate(angle);
      tree(segment, width*thinFactor, level, 1,20, decay);
      popMatrix();
      
      // dessiner la branche de très droite
      pushMatrix();
      rotate(2*angle);
      tree(segment, width*thinFactor, level, 2, 10, decay);
      popMatrix();
  
      // dessiner la branche de gauche
      pushMatrix();
      rotate(-angle);
      tree(segment, width*thinFactor, level, -1, 10, decay);
      popMatrix();
  
      // dessiner la branche du centre
      pushMatrix();
      tree(segment*0.7, width*thinFactor, level, 0, 0, decay);
      popMatrix();
  
    }
  }

  boolean grow(){
    if (depthMax <4){
      depthMax++;
    }   
    if (depthMax == 4)
      return true;
    else
      return false;
  }   
}
