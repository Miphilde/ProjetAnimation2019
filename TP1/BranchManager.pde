// Gestionnaire des branches apparaissant lors de la phase de jeu

class BranchManager
{

  color takenColor;
  
  int index;
  int count;
  int activeBranchCount;

  float timeStart;
  float timeElapsed;
  float timeLastEmission;
  float timeTreshold = 5.0f;

  ArrayList<Branch> system;

  ArrayList<Branch> branchActive;
  ArrayList<Branch> branchReady;

  Branch branch;

  BranchManager(int size, color c)
  {
    count = size;
    takenColor = c;
    init();
  }

  void init()
  {
    
    system = new ArrayList<Branch>();

    branchActive = new ArrayList<Branch>();
    branchReady = new ArrayList<Branch>();

    for (index = 0; index < count; ++index)
    {
      branch = new Branch(takenColor);

      system.add(branch);
      branchReady.add(branch);
    }

    timeStart = millis();
    timeLastEmission = timeStart;
    emiter();
  }

  void update()
  {
    timeElapsed = (millis() - timeLastEmission) / 1000.0f;
    
    if (timeElapsed >= timeTreshold){
      emiter();
      timeLastEmission = millis();
    }

    activeBranchCount = branchActive.size();
    if (activeBranchCount > 0)
    {
      for (index = 0; index < branchActive.size(); ++index)
      {
        branch = branchActive.get(index);

        if (branch.active){
          branch.update();
          branch.render();
        } else
          recycle(branch);
      }
    }
  }

  int clicked (int x, int y){
      activeBranchCount = branchActive.size();
      if (activeBranchCount > 0)
      {
        for (index = 0; index < branchActive.size(); ++index)
        {
          branch = branchActive.get(index);
          if ( branch.isClicked(x, y)){
            branch.isTaken = !branch.isTaken;
            return index;
          } else if (branch.isTaken){
            branch.isTaken = false;
            branch.setTarget(x,y);
            return -index;
          }
        }
      }    
      return 0;
  }

  void emiter()
  {
      if (branchReady.size() > 0)
      {
        branch = branchReady.get(0);

        branch.init();

        branchReady.remove(0);
        branchActive.add(branch);
      }
  }

  void recycle(Branch p)
  {
    branchActive.remove(p);
    branchReady.add(p);
  }

  void print(String tag)
  {
    println("particle system " + tag + " (" + branchActive.size() + " " + branchReady.size() + " " + count + ")");
  }
}
