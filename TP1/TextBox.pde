// Classe permettant la création d'une boîte de texte à l'usage de la narration

class TextBox{
  
  PVector position;
  color background;
  int transparency;
  color textColor;
  PFont font;
  String[] text;
  
  AudioPlayer[] audioMimic;
  SoundFile[] audioSound;
  boolean mimic;
  
  int fontSize = 48;
  int padding = 20;
  int currentDisplay;
  
  TextBox( PVector p, color cb, int a, color ct, String f, SoundFile[] s){
    position = p;
    background = cb;
    transparency = a;
    textColor = ct;
    font = loadFont(f);
    currentDisplay = 0;
    audioSound =s;
    mimic = false;
  }
  
  TextBox( PVector p, color cb, int a, color ct, String f, AudioPlayer[] s){
    position = p;
    background = cb;
    transparency = a;
    textColor = ct;
    font = loadFont(f);
    currentDisplay = 0;
    audioMimic = s;
    mimic = true;
  }
  
  void setText(String [] t){
    text = new String [t.length];
    for (int i =0; i<t.length; i++){
      text[i] = t[i];    
    }
    currentDisplay =0;
  }
  
  void nextString(){
    if (currentDisplay < text.length-1){
      currentDisplay++;
      if ((currentDisplay == 1 || currentDisplay ==2)&& scene <4){
        nextScene(1);
      }
    }
    else if (scene == 3)
      nextScene(1);
  }
  
  void setFont( String s){
    font = loadFont(s);
  }
  
  
  void render(){
    noStroke();
    fill(background, transparency);
    rect(position.x, position.y, width, height-position.y);
    
    fill(textColor);
    textSize(fontSize);
    textFont(font);
    //text(text[currentDisplay], position.x + padding, position.y+padding+fontSize);   
    textAlign(CENTER,CENTER);
    text(text[currentDisplay], width/2, height -(height-position.y)/2);
    
    if (mimic){
      if(audioMimic.length > currentDisplay)
        audioMimic[currentDisplay].play();
    }else{
      if(audioSound.length > currentDisplay)
        audioSound[currentDisplay].play();
    }
  }
  
  
}
