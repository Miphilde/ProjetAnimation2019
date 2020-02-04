// Gestionnaire de la phase de jeu

class GameManager{
  
  BranchManager branches;
  EnemyManager enemies;
 
  int lives;
  int enemiesNumber;
  
  Enemy enemy;
  Branch branch;

  int end;
  
  GameManager (BranchManager b, EnemyManager e, int l, int n){
    branches = b;
    enemies = e;
    lives = l;
    enemiesNumber = n;    
    
    end = 0;
  }
  
  void update(){
    
    branches.update();
    enemies.update(end);
    if (enemies.enemyActive.size() !=0){
    
      for( int i = 0; i< branches.branchActive.size(); i++){
         branch = branches.branchActive.get(i);
         if (branch.target.x != 0 || branch.target.y !=0){
           for ( int j = 0; j< enemies.enemyActive.size(); j++){
             enemy = enemies.enemyActive.get(j);
             if (enemy.collide(branch.positionX, branch.positionY)){
               branch.active = false;
               enemy.dead =true;
               enemiesNumber--;
             }
           }
          }
       }
       for ( int j = 0; j< enemies.enemyActive.size(); j++){
           enemy = enemies.enemyActive.get(j);
           if (enemy.target.y -enemy.positionY <5){
              enemy.crossed = true;
              lives--;
           } 
       }
    }
    
    if (lives ==0&& end ==0){
      nextScene(1);
      end = -1;
    } else if (enemiesNumber ==0 && end ==0){
      nextScene(2);
      happyEnding();
      end = 1;
    }
  }
  
  void happyEnding(){
    for ( int j = 0; j< enemies.enemyActive.size(); j++){
       enemy = enemies.enemyActive.get(j);
       enemy.target = new PVector(enemy.positionX, 0); 
       enemy.flee = true;
    }
  }
}
