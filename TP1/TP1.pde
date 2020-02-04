// Programme principal de l'animation
import processing.sound.*;
import java.util.Iterator;

//paramètres
int decay =20;
color globalColor = color(255,255,0);

int count = 8;

float amplitude = 0.618f;
float panning= 0;
int noteDuration = 1000;

String file1 = "Ambre_1.png";
String file2 = "Ambre_2.png";
String file3 = "Ennemi.png";

int textBoxHeight = 100;
color textBoxColor = 20;
int textBoxTransparency = 200;
color textColor =255;
String font1 = "ARBERKLEY-48.vlw";
String font2 = "ARDECODE-48.vlw";
String font3 = "Creepsville-48.vlw";
String[] text1 = {"Les esprits de la forêt sont agités, cette nuit.", 
"Des intrus seraient-ils entrés ?", 
"Je ne les laisserai pas atteindre le manoir.", "Je protègerai mes amis à tout prix !"};
String[] audioPath = { "dub1.mp3", "dub2.mp3", "dub3.mp3", "dub4.mp3"};
SoundFile[] audio;

String[] text2 = {"Les ennemis etaient bien trop nombreux.", "Ils ont pris le manoir, tout est perdu."};
String [] text3 = {"Les ennemis s'enfuient !", "Le manoir est sauvé !"};

color groundColor = color(19, 92, 50);


//variables
ParticleSystem system;

int fondu;

int clicked;
float frequency;
SinOsc oscillator;
int noteStart;


PImage sprite1;
PImage sprite2;
Aureola aureola1;
Aureola aureola2;

TextBox textBox;

Tree firstTree;
Tree secondTree;
Tree thirdTree;
boolean fullyGrown;

BranchManager branchManager;
EnemyManager enemyManager;
PImage sprite3;
GameManager manager;
//scene 1 : fond noir, text 1&2, particules clickables et musique
//scene 2 : ambre1, ajout arbres agrandissables, texte 3, particules clickables et musique, auréole1
//scene 3 : ambre2, teinte jaune, auréole2, particules clickables et musiques

int scene;

void setup()
{
  size(800, 800);
  frameRate(60);
  
  sprite1 = loadImage(file1);
  sprite2 = loadImage(file2);
  imageMode(CENTER);

  aureola1 = new Aureola (width/2, 290, new PVector (100, 10), 2, 5, globalColor);
  aureola2 =new Aureola(width/2, 50, new PVector(400, 50), 15, 15, globalColor);

  sprite1.resize(250,0);
  sprite2.resize(800,0);
  
  system = new ParticleSystem(count, globalColor);

  audio = new SoundFile [4];
  audio[0] = new SoundFile(this, audioPath[0]);
  audio[1] = new SoundFile(this, audioPath[1]);
  audio[2] = new SoundFile(this, audioPath[2]); 
  audio[3] = new SoundFile(this, audioPath[3]);
  textBox = new TextBox(new PVector(0, height-textBoxHeight), textBoxColor, textBoxTransparency, textColor, font1, audio);
  textBox.setText(text1);

  panning =0;
  noteStart =0;
  oscillator = new SinOsc(this);

  scene = 1;
  fondu = 255;
  
  firstTree = new Tree(PI / 8.0f, new PVector (width/4.0f-10, 3*height/5.0f+50),  height/5.0f, width/40.0f);
  secondTree = new Tree(PI / 6.0f, new PVector (width/2.0f, height/2.0f+70), height/4.0f, width/30.0f);
  thirdTree = new Tree(PI / 10.0f, new PVector (3*width/4.0f+10, 3*height/5.0f+50),  height/5.0f, width/40.0f);
  fullyGrown = false;
  
  branchManager = new BranchManager(10, globalColor);
  sprite3 = loadImage(file3);
  sprite3.resize(150,0);
  enemyManager = new EnemyManager(10, sprite3);
  manager = new GameManager (branchManager, enemyManager, 3,10);
}

void draw()
{
  switch(scene){
    case 1: 
      drawScene1();
      break;
    case 2:
      drawScene2();
      break;
    case 3:
      drawScene3();
      break;
    case 4:
      drawScene4();
      break;
    case 5:
      drawScene5();
      break;
    case 6:
      drawScene6();
      break;
  }
}

void playNote (int index){
  switch(index+1){
     case 1:
       frequency = 261.63f;
       break;
     case 2:
       frequency = 293.66f;
       break;
     case 3:
       frequency = 329.63f;
       break;
     case 4:
       frequency = 349.23f;
       break;       
     case 5:
       frequency = 392.0f;
       break;        
     case 6:
       frequency = 440.0f;
       break;         
     case 7:
       frequency = 493.88f;
       break;         
     case 8:
       frequency = 523.25f;
       break;         
    }    
    oscillator.freq(frequency);
    oscillator.amp(amplitude);
    oscillator.pan(panning);
  
    oscillator.play();   
    noteStart = millis();
}

void keyReleased(){
  if (key == ' '){
    if (scene !=4 &&(scene !=2 || fullyGrown == true))
      textBox.nextString();
  }
  if (keyCode == UP && scene == 2){
    fullyGrown = firstTree.grow();
    secondTree.grow();
    thirdTree.grow();
  }
  
  if(key == 's'){
    saveFrame("captune###.png"); 
  }
}

void mouseClicked(){
   if (scene >3 && scene != 5)
     branchManager.clicked(mouseX, mouseY); 
}


void fade(float decay)
{
    noStroke();
    fill(0, decay);
    rect(0, 0, width, height);
}

void fondu(){
    noStroke();
    fill(0, fondu);
    rect(0, 0, width, height);
    fondu = fondu-2;
}

void nextScene(int up){
  scene+= up; 
  if (scene ==2)
    fondu= 255;
  else if (scene == 5){
    textBox.setText(text2);
    textBox.setFont(font3);
  }
  else if (scene == 6){
    textBox.setText(text3);
    textBox.setFont(font2);
  }
}

void drawScene1(){
    if ( fondu > 0)
      fondu();
      
    drawParticleSystem();
    textBox.render();
}

void drawScene2(){
    firstTree.render(decay*2);
    secondTree.render(decay*2);
    thirdTree.render(decay*2);
    tint(150);
    image (sprite1, width/2,height/2+50);
    aureola1.render();    
    
    if (fondu >0)
      fondu();
      
    drawParticleSystem();
    textBox.render();
}

void drawScene3(){
   tint(150);
   drawParticleSystem();
   image(sprite2, width/2, height/2);
   aureola2.render();
   textBox.render();
  
}

void drawScene4(){
  noStroke();
  fill(groundColor);
  rect(0, 0, width, height);    
  manager.update();
  
}

//Game Over
void drawScene5(){
  background(groundColor);    
  manager.update();
  textBox.render();
  
}

//Happy ending
void drawScene6(){
  background(groundColor);    
  manager.update();
  textBox.render();  
}

void drawParticleSystem(){
  
  fade(decay);
  system.update();

  if (mousePressed == true)
  {
      clicked = system.clicked(mouseX, mouseY); 
      playNote(clicked);
  }
  
  if( noteStart !=0 && millis()-noteStart > noteDuration)
    oscillator.stop();
 
}
