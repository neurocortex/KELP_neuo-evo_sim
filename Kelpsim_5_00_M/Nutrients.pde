
class Nutrients
{
  int calories;
  float size;
  float initialX;
  float initialY;
  FCircle nu;
  
  
  Nutrients()
  {
    size = random(0.5,3.0);
    calories = int(random(10,30)*size);
    initialX = (int)random(30,1640);
    initialY = (int)random(15,300);
    nu = new FCircle(11*size*1.5);
    nu.setPosition(initialX,initialY);
    nu.setName("morsel");
    nu.setFill(random(240),240,39);
    physics.add(nu);
    nu.setDamping(0.1*size);
    nu.addForce(random(60,-60),random(-60,60));
  }
}
