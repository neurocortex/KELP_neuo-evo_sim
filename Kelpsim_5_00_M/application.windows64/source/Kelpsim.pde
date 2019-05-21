import java.io.Serializable;
import java.math.*;
import fisica.*;



FWorld physics;
int foodTime = 500;
int metTime = 100;
int curentTimeF = 0;
int curentTimeA = 0;
boolean started = false;
ArrayList<Nutrients> food;
ArrayList<Agent> population;

void setup()
{
  size(1000,650);
  Fisica.init(this);
  food = new ArrayList<Nutrients>();
  population = new ArrayList<Agent>();
  
  physics = new FWorld();
  physics.setEdges();
  physics.setEdgesRestitution(0.8);
  physics.setGravity(0,10);
  
  //initial population size decided here
  for(int i=0;i<5;i++){
    population.add(new Agent());
  }
}

void draw()
{
  background(0);
  started = true;
  
  int passedTimeF = millis() - curentTimeF;
  
  if (passedTimeF > foodTime)
  {
    food.add(new Nutrients());
    curentTimeF = millis();
  }
  
  if (food.size() >  60)
  { 
    FCircle n = food.get(0).nu;
    physics.remove(n);
    food.remove(0);
  }
  
  /* step through all agents and deal with their eating/metabolism/breeding */
  int passedTimeA = millis() - curentTimeA;
  if (passedTimeA > metTime)
  {
    for (int i = 0; i < population.size(); i++)
    {
      Agent a = population.get(i);
      
      //eat any food in contact with the agent
      ArrayList contacts = a.agt.getContacts();
      for (int k = 0; k < contacts.size();k++)
      {
        FContact c = (FContact)contacts.get(k);
        FBody b1 = c.getBody1();
        FBody b2 = c.getBody2();
        
        if (b1.getName() == "morsel")
        {
          /*if(b1.getX() > b2.getX()-5 & b1.getX() < b2.getX()+5
             & b1.getY() > b2.getY()-5 & b1.getY() < b2.getY()+5)
          {*/
            physics.remove(b1);
            a.energy += 60;
            ellipse(c.getX(), c.getY(), 50, 50);
          //}
        }
        else if(b2.getName()=="morsel")
        {
          /*if(b2.getX() > b1.getX()-5 & b2.getX() < b1.getX()+5
             & b2.getY() > b1.getY()-5 & b2.getY() < b1.getY()+5)
          {*/
            physics.remove(b2);
            a.energy += 60;
            ellipse(c.getX(), c.getY(), 50, 50);
          //}
        }
      }
      
      a.metabolism();
      a.sense();
      a.move();
      
      //remove Agents from sim if they are dead
      if (a.alive == false)
      {
        a.die();
        population.remove(a);
      }
      
      //if they are ready to lay an egg, add a new agent to the population
      if (a.layEgg == true)
      {
        population.add(new Agent(70,a));
        a.layEgg = false;
      }
    }
    curentTimeA = millis();
  }
  physics.step();
  physics.draw();
  
}
 
 
void contactStarted(FContact cont)
{
  
  println(cont.getBody1().getName());
  println(cont.getBody2().getName());
  fill(50, 170, 200);
  ellipse(cont.getX(), cont.getY(), 20, 20);
} 
