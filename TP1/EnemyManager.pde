// Gestionnaire des ennemis apparaissant dans la phase de jeu

class EnemyManager
{

  PImage sprite;
  
  int index;
  int count;
  int activeEnemyCount;

  float timeStart;
  float timeElapsed;
  float timeLastEmission;
  float timeTreshold = 5.0f;

  ArrayList<Enemy> system;

  ArrayList<Enemy> enemyActive;
  ArrayList<Enemy> enemyReady;

  Enemy enemy;

  EnemyManager(int size, PImage img)
  {
    count = size;
    sprite = img;
    init();
  }

  void init()
  {
    
    system = new ArrayList<Enemy>();

    enemyActive = new ArrayList<Enemy>();
    enemyReady = new ArrayList<Enemy>();

    for (index = 0; index < count; ++index)
    {
      enemy = new Enemy(sprite);

      system.add(enemy);
      enemyReady.add(enemy);
    }

    timeStart = millis();
    timeLastEmission = timeStart;
  }

  void update(int end)
  {
    timeElapsed = (millis() - timeLastEmission) / 1000.0f;
    
    if (timeElapsed >= timeTreshold && end != 1){
      emiter();
      timeLastEmission = millis();
    }

    if (enemyActive.size() > 0)
    {
      for (index = 0; index < enemyActive.size(); ++index)
      {
        enemy = enemyActive.get(index);

        if (enemy.active){
          enemy.update();
          enemy.render();
        } else
          recycle(enemy);
      }
    }
  }

  void emiter()
  {
      if (enemyReady.size() > 0)
      {
        enemy = enemyReady.get(0);

        enemy.init();

        enemyReady.remove(0);
        enemyActive.add(enemy);
      }
  }

  void recycle(Enemy p)
  {
    enemyActive.remove(p);
    enemyReady.add(p);
  }

  void print(String tag)
  {
    println("particle system " + tag + " (" + enemyActive.size() + " " + enemyReady.size() + " " + count + ")");
  }
}
