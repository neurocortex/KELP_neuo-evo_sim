
class Nutrients
{
  int calories;
  float initialX;
  float initialY;
  FCircle nu;
  
  Nutrients()
  {
    calories = int(random(10,50));
    initialX = (int)random(10,990);
    initialY = (int)random(10,50);
    nu = new FCircle(10);
    nu.setPosition(initialX,initialY);
    nu.setName("morsel");
    nu.setFill(75,240,39);
    physics.add(nu);
  }
}
