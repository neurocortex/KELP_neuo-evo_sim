import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.io.Serializable; 
import java.math.*; 
import fisica.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Kelpsim extends PApplet {







FWorld physics;
int foodTime = 500;
int metTime = 100;
int curentTimeF = 0;
int curentTimeA = 0;
boolean started = false;
ArrayList<Nutrients> food;
ArrayList<Agent> population;

public void setup()
{
  size(1000,650);
  Fisica.init(this);
  food = new ArrayList<Nutrients>();
  population = new ArrayList<Agent>();
  
  physics = new FWorld();
  physics.setEdges();
  physics.setEdgesRestitution(0.8f);
  physics.setGravity(0,10);
  
  //initial population size decided here
  for(int i=0;i<5;i++){
    population.add(new Agent());
  }
}

public void draw()
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
 
 
public void contactStarted(FContact cont)
{
  
  println(cont.getBody1().getName());
  println(cont.getBody2().getName());
  fill(50, 170, 200);
  ellipse(cont.getX(), cont.getY(), 20, 20);
} 
class Agent
{
  int x;
  int y;
  float energy;
  int eggCounter;
  boolean layEgg;
  boolean alive;
  NN brain;
  Genome dNA;
  FBox agt;
  FBox sensor1;
  FBox sensor2;
  FBox sensor3;
  FBox sensor4;
  FBox sensor5;
  FBox sensor6;
  FBox sensor7;
  FBox sensor8;
  FBox sensor9;
  FBox sensor10;
  FBox sensor11;
  FBox sensor12;
  FBox sensor13;
  FRevoluteJoint j1;
  FRevoluteJoint j2;
  FRevoluteJoint j3;
  FRevoluteJoint j4;
  FRevoluteJoint j5;
  FRevoluteJoint j6;
  FRevoluteJoint j7;
  FRevoluteJoint j8;
  FRevoluteJoint j9;
  FRevoluteJoint j10;
  FRevoluteJoint j11;
  FRevoluteJoint j12;
  FRevoluteJoint j13;
  FCompound agtComp;
  
  //basic constructor, only for first generation individuals
  Agent()
  {
    x = (int)random(400, 600);
    y = (int)random(300, 500);
    energy = 90.0f;
    eggCounter = 0;
    layEgg = false;
    alive = true;
    brain = new NN(200);
    dNA = brain.genome;
    //agent body block
    agt = new FBox(20,20);
    agt.setName("agent");
    agt.setPosition(x,y);
    agt.setFill(166,51,240);
    agt.setStroke(124,38,29);
    
    //sensor 'ray' blocks, if in contact with something other than
    //this agent's body block (or other agent's sensors) then
    //pass '1' to corrosponding network input, otherwise pass '0'
    //sensor 1
    sensor1 = new FBox(2,100);
    sensor1.setName("sensor1");
    sensor1.setGroupIndex(-1);
    sensor1.setSensor(true);
    sensor1.setPosition(x,y-50);
    sensor1.setRotation(0);
    sensor1.setStroke(222,255,15);
    //sensor 2
    sensor2 = new FBox(2,100);
    sensor2.setName("sensor2");
    sensor2.setGroupIndex(-1);
    sensor2.setSensor(true);
    sensor2.setPosition(x+13,y-47);
    sensor2.setRotation(PI/12);
    sensor2.setStroke(222,255,15);
    //sensor 3
    sensor3 = new FBox(2,100);
    sensor3.setName("sensor3");
    sensor3.setGroupIndex(-1);
    sensor3.setSensor(true);
    sensor3.setPosition(x+25,y-43);
    sensor3.setRotation(PI/6);
    sensor3.setStroke(222,255,15);
    //sensor 4
    sensor4 = new FBox(2,100);
    sensor4.setName("sensor4");
    sensor4.setGroupIndex(-1);
    sensor4.setSensor(true);
    sensor4.setPosition(x+37,y-35);
    sensor4.setRotation(PI/4);
    sensor4.setStroke(222,255,15);
    //sensor 5
    sensor5 = new FBox(2,100);
    sensor5.setName("sensor5");
    sensor5.setGroupIndex(-1);
    sensor5.setSensor(true);
    sensor5.setPosition(x+46,y-25);
    sensor5.setRotation(PI/3);
    sensor5.setStroke(222,255,15);
    //sensor 6
    sensor6 = new FBox(2,100);
    sensor6.setName("sensor6");
    sensor6.setGroupIndex(-1);
    sensor6.setSensor(true);
    sensor6.setPosition(x+49,y-13);
    sensor6.setRotation(1.3089f);
    sensor6.setStroke(222,255,15);
    //sensor 7
    sensor7 = new FBox(2,100);
    sensor7.setName("sensor7");
    sensor7.setGroupIndex(-1);
    sensor7.setSensor(true);
    sensor7.setPosition(x+50,y);
    sensor7.setRotation(PI/2);
    sensor7.setStroke(222,255,15);
    //sensor 8
    sensor8 = new FBox(2,100);
    sensor8.setName("sensor8");
    sensor8.setGroupIndex(-1);
    sensor8.setSensor(true);
    sensor8.setPosition(x+49,y+13);
    sensor8.setRotation(1.8325f);
    sensor8.setStroke(222,255,15);
    //sensor 9
    sensor9 = new FBox(2,100);
    sensor9.setName("sensor9");
    sensor9.setGroupIndex(-1);
    sensor9.setSensor(true);
    sensor9.setPosition(x+46,y+25);
    sensor9.setRotation(2.0943f);
    sensor9.setStroke(222,255,15);
    //sensor 10
    sensor10 = new FBox(2,100);
    sensor10.setName("sensor10");
    sensor10.setGroupIndex(-1);
    sensor10.setSensor(true);
    sensor10.setPosition(x+37,y+35);
    sensor10.setRotation(2.3561f);
    sensor10.setStroke(222,255,15);
    //sensor 11
    sensor11 = new FBox(2,100);
    sensor11.setName("sensor11");
    sensor11.setGroupIndex(-1);
    sensor11.setSensor(true);
    sensor11.setPosition(x+25,y+43);
    sensor11.setRotation(2.6179f);
    sensor11.setStroke(222,255,15);
    //sensor 12
    sensor12 = new FBox(2,100);
    sensor12.setName("sensor12");
    sensor12.setGroupIndex(-1);
    sensor12.setSensor(true);
    sensor12.setPosition(x+13,y+47);
    sensor12.setRotation(2.8797f);
    sensor12.setStroke(222,255,15);
    //sensor 13
    sensor13 = new FBox(2,100);
    sensor13.setName("sensor13");
    sensor13.setGroupIndex(-1);
    sensor13.setSensor(true);
    sensor13.setPosition(x,y+50);
    sensor13.setRotation(0);
    sensor13.setStroke(222,255,15);
    
    //add bodies to agent compound object
    //agtComp = new FCompound();
    
    //agtComp.addBody(sensor1);
    physics.add(sensor1);
    //agtComp.addBody(sensor2);
    physics.add(sensor2);
    //agtComp.addBody(sensor3);
    physics.add(sensor3);
    //agtComp.addBody(sensor4);
    physics.add(sensor4);
    //agtComp.addBody(sensor5);
    physics.add(sensor5);
    //agtComp.addBody(sensor6);
    physics.add(sensor6);
    //agtComp.addBody(sensor7);
    physics.add(sensor7);
    //agtComp.addBody(sensor8);
    physics.add(sensor8);
    //agtComp.addBody(sensor9);
    physics.add(sensor9);
    //agtComp.addBody(sensor10);
    physics.add(sensor10);
    //agtComp.addBody(sensor11);
    physics.add(sensor11);
    //agtComp.addBody(sensor12);
    physics.add(sensor12);
    //agtComp.addBody(sensor13);
    physics.add(sensor13);
    //agtComp.addBody(agt);
    
    physics.add(agt);
    
    //agtComp.setPosition(x,y);
    //agtComp.setName("critter");
    //physics.add(agtComp);
    
    //rigid joints attaching sensory 'whiskers' to the agent's body
    j1 = new FRevoluteJoint(sensor1,agt);
    j1.setAnchor(x,y);
    j1.setCollideConnected(false);
    j1.setEnableLimit(true);
    
    j2 = new FRevoluteJoint(sensor2,agt);
    j2.setAnchor(x,y);
    j2.setCollideConnected(false);
    j2.setEnableLimit(true);
    
    j3 = new FRevoluteJoint(sensor3,agt);
    j3.setAnchor(x,y);
    j3.setCollideConnected(false);
    j3.setEnableLimit(true);
    
    j4 = new FRevoluteJoint(sensor4,agt);
    j4.setAnchor(x,y);
    j4.setCollideConnected(false);
    j4.setEnableLimit(true);
    
    j5 = new FRevoluteJoint(sensor5,agt);
    j5.setAnchor(x,y);
    j5.setCollideConnected(false);
    j5.setEnableLimit(true);
    
    j6 = new FRevoluteJoint(sensor6,agt);
    j6.setAnchor(x,y);
    j6.setCollideConnected(false);
    j6.setEnableLimit(true);
    
    j7 = new FRevoluteJoint(sensor7,agt);
    j7.setAnchor(x,y);
    j7.setCollideConnected(false);
    j7.setEnableLimit(true);
    
    j8 = new FRevoluteJoint(sensor8,agt);
    j8.setAnchor(x,y);
    j8.setCollideConnected(false);
    j8.setEnableLimit(true);
    
    j9 = new FRevoluteJoint(sensor9,agt);
    j9.setAnchor(x,y);
    j9.setCollideConnected(false);
    j9.setEnableLimit(true);
    
    j10 = new FRevoluteJoint(sensor10,agt);
    j10.setAnchor(x,y);
    j10.setCollideConnected(false);
    j10.setEnableLimit(true);
    
    j11 = new FRevoluteJoint(sensor11,agt);
    j11.setAnchor(x,y);
    j11.setCollideConnected(false);
    j11.setEnableLimit(true);
    
    j12 = new FRevoluteJoint(sensor12,agt);
    j12.setAnchor(x,y);
    j12.setCollideConnected(false);
    j12.setEnableLimit(true);
    
    j13 = new FRevoluteJoint(sensor13,agt);
    j13.setAnchor(x,y);
    j13.setCollideConnected(false);
    j13.setEnableLimit(true);
    
    physics.add(j1);
    physics.add(j2);
    physics.add(j3);
    physics.add(j4);
    physics.add(j5);
    physics.add(j6);
    physics.add(j7);
    physics.add(j8);
    physics.add(j9);
    physics.add(j10);
    physics.add(j11);
    physics.add(j12);
    physics.add(j13);
  } //<>//
  
  
  
  //constructor for G2 and onwards, requires starting energy and parent's genome
  Agent(float energySt, Agent parent)
  {
    brain = new NN(parent.brain.gCopy());
    x = (int)random(400, 600);
    y = (int)random(300, 500);
    energy = energySt;
    layEgg = false;
    alive = true;
    //agent body box
    agt = new FBox(20,20);
    agt.setName("agent");
    agt.setPosition(x,y);
    agt.setFill(166,51,240);
    agt.setStroke(255,0,0);
    
    //sensor 'ray' blocks, if in contact with something other than
    //this agent's body block (or other agent's sensors) then
    //pass '1' to corrosponding network input, otherwise pass '0'
    //sensor 1
    sensor1 = new FBox(2,100);
    sensor1.setName("sensor1");
    sensor1.setGroupIndex(-1);
    sensor1.setSensor(true);
    sensor1.setPosition(x,y-50);
    sensor1.setRotation(0);
    sensor1.setStroke(222,255,15);
    //sensor 2
    sensor2 = new FBox(2,100);
    sensor2.setName("sensor2");
    sensor2.setGroupIndex(-1);
    sensor2.setSensor(true);
    sensor2.setPosition(x+13,y-47);
    sensor2.setRotation(PI/12);
    sensor2.setStroke(222,255,15);
    //sensor 3
    sensor3 = new FBox(2,100);
    sensor3.setName("sensor3");
    sensor3.setGroupIndex(-1);
    sensor3.setSensor(true);
    sensor3.setPosition(x+25,y-43);
    sensor3.setRotation(PI/6);
    sensor3.setStroke(222,255,15);
    //sensor 4
    sensor4 = new FBox(2,100);
    sensor4.setName("sensor4");
    sensor4.setGroupIndex(-1);
    sensor4.setSensor(true);
    sensor4.setPosition(x+37,y-35);
    sensor4.setRotation(PI/4);
    sensor4.setStroke(222,255,15);
    //sensor 5
    sensor5 = new FBox(2,100);
    sensor5.setName("sensor5");
    sensor5.setGroupIndex(-1);
    sensor5.setSensor(true);
    sensor5.setPosition(x+46,y-25);
    sensor5.setRotation(PI/3);
    sensor5.setStroke(222,255,15);
    //sensor 6
    sensor6 = new FBox(2,100);
    sensor6.setName("sensor6");
    sensor6.setGroupIndex(-1);
    sensor6.setSensor(true);
    sensor6.setPosition(x+49,y-13);
    sensor6.setRotation(1.3089f);
    sensor6.setStroke(222,255,15);
    //sensor 7
    sensor7 = new FBox(2,100);
    sensor7.setName("sensor7");
    sensor7.setGroupIndex(-1);
    sensor7.setSensor(true);
    sensor7.setPosition(x+50,y);
    sensor7.setRotation(PI/2);
    sensor7.setStroke(222,255,15);
    //sensor 8
    sensor8 = new FBox(2,100);
    sensor8.setName("sensor8");
    sensor8.setGroupIndex(-1);
    sensor8.setSensor(true);
    sensor8.setPosition(x+49,y+13);
    sensor8.setRotation(1.8325f);
    sensor8.setStroke(222,255,15);
    //sensor 9
    sensor9 = new FBox(2,100);
    sensor9.setName("sensor9");
    sensor9.setGroupIndex(-1);
    sensor9.setSensor(true);
    sensor9.setPosition(x+46,y+25);
    sensor9.setRotation(2.0943f);
    sensor9.setStroke(222,255,15);
    //sensor 10
    sensor10 = new FBox(2,100);
    sensor10.setName("sensor10");
    sensor10.setGroupIndex(-1);
    sensor10.setSensor(true);
    sensor10.setPosition(x+37,y+35);
    sensor10.setRotation(2.3561f);
    sensor10.setStroke(222,255,15);
    //sensor 11
    sensor11 = new FBox(2,100);
    sensor11.setName("sensor11");
    sensor11.setGroupIndex(-1);
    sensor11.setSensor(true);
    sensor11.setPosition(x+25,y+43);
    sensor11.setRotation(2.6179f);
    sensor11.setStroke(222,255,15);
    //sensor 12
    sensor12 = new FBox(2,100);
    sensor12.setName("sensor12");
    sensor12.setGroupIndex(-1);
    sensor12.setSensor(true);
    sensor12.setPosition(x+13,y+47);
    sensor12.setRotation(2.8797f);
    sensor12.setStroke(222,255,15);
    //sensor 13
    sensor13 = new FBox(2,100);
    sensor13.setName("sensor13");
    sensor13.setGroupIndex(-1);
    sensor13.setSensor(true);
    sensor13.setPosition(x,y+50);
    sensor13.setRotation(0);
    sensor13.setStroke(222,255,15);
    
    //add bodies to agent compound object
    //agtComp = new FCompound();
    
    //agtComp.addBody(sensor1);
    physics.add(sensor1);
    //agtComp.addBody(sensor2);
    physics.add(sensor2);
    //agtComp.addBody(sensor3);
    physics.add(sensor3);
    //agtComp.addBody(sensor4);
    physics.add(sensor4);
    //agtComp.addBody(sensor5);
    physics.add(sensor5);
    //agtComp.addBody(sensor6);
    physics.add(sensor6);
    //agtComp.addBody(sensor7);
    physics.add(sensor7);
    //agtComp.addBody(sensor8);
    physics.add(sensor8);
    //agtComp.addBody(sensor9);
    physics.add(sensor9);
    //agtComp.addBody(sensor10);
    physics.add(sensor10);
    //agtComp.addBody(sensor11);
    physics.add(sensor11);
    //agtComp.addBody(sensor12);
    physics.add(sensor12);
    //agtComp.addBody(sensor13);
    physics.add(sensor13);
    //agtComp.addBody(agt);
    
    physics.add(agt);
    
    //agtComp.setPosition(x,y);
    //agtComp.setName("critter");
    //physics.add(agtComp);
    
    //rigid joints attaching sensory 'whiskers' to the agent's body
    j1 = new FRevoluteJoint(sensor1,agt);
    j1.setAnchor(x,y);
    j1.setCollideConnected(false);
    j1.setEnableLimit(true);
    
    j2 = new FRevoluteJoint(sensor2,agt);
    j2.setAnchor(x,y);
    j2.setCollideConnected(false);
    j2.setEnableLimit(true);
    
    j3 = new FRevoluteJoint(sensor3,agt);
    j3.setAnchor(x,y);
    j3.setCollideConnected(false);
    j3.setEnableLimit(true);
    
    j4 = new FRevoluteJoint(sensor4,agt);
    j4.setAnchor(x,y);
    j4.setCollideConnected(false);
    j4.setEnableLimit(true);
    
    j5 = new FRevoluteJoint(sensor5,agt);
    j5.setAnchor(x,y);
    j5.setCollideConnected(false);
    j5.setEnableLimit(true);
    
    j6 = new FRevoluteJoint(sensor6,agt);
    j6.setAnchor(x,y);
    j6.setCollideConnected(false);
    j6.setEnableLimit(true);
    
    j7 = new FRevoluteJoint(sensor7,agt);
    j7.setAnchor(x,y);
    j7.setCollideConnected(false);
    j7.setEnableLimit(true);
    
    j8 = new FRevoluteJoint(sensor8,agt);
    j8.setAnchor(x,y);
    j8.setCollideConnected(false);
    j8.setEnableLimit(true);
    
    j9 = new FRevoluteJoint(sensor9,agt);
    j9.setAnchor(x,y);
    j9.setCollideConnected(false);
    j9.setEnableLimit(true);
    
    j10 = new FRevoluteJoint(sensor10,agt);
    j10.setAnchor(x,y);
    j10.setCollideConnected(false);
    j10.setEnableLimit(true);
    
    j11 = new FRevoluteJoint(sensor11,agt);
    j11.setAnchor(x,y);
    j11.setCollideConnected(false);
    j11.setEnableLimit(true);
    
    j12 = new FRevoluteJoint(sensor12,agt);
    j12.setAnchor(x,y);
    j12.setCollideConnected(false);
    j12.setEnableLimit(true);
    
    j13 = new FRevoluteJoint(sensor13,agt);
    j13.setAnchor(x,y);
    j13.setCollideConnected(false);
    j13.setEnableLimit(true);
    
    physics.add(j1);
    physics.add(j2);
    physics.add(j3);
    physics.add(j4);
    physics.add(j5);
    physics.add(j6);
    physics.add(j7);
    physics.add(j8);
    physics.add(j9);
    physics.add(j10);
    physics.add(j11);
    physics.add(j12);
    physics.add(j13);

  }

  public void metabolism()
  {
    if (energy > 100.0f) {
      energy = 100.0f;
      eggCounter+=1;
      if (eggCounter>5)
      {
        energy = 55.0f;
        layEgg = true;
        eggCounter = 0;
      }
    }
    else
    {
      energy -= 0.35f;
    }
    if (energy < 0.0f)
    {
      alive = false;
      this.die();
    }
    textSize(10);
    text(energy, this.agt.getX(), this.agt.getY());
  }
  
  public void die()
  {
    //serialize nn object to file here
    physics.remove(agtComp);
  }
  
  public void sense()
  {
    //inputs 1-13 (whiskers)
    //w1
    println(sensor1.getContacts().size());
    if (sensor1.getContacts().size() >0)//getTouching().size() > 0)
    {
      println("s1 activated");
      brain.neurons.get(0).activate();
    }
    //w2
    if (sensor2.getTouching().size() > 0)
    {
      println("s2 activated");
      brain.neurons.get(1).activate();
    }
    //w3
    if (sensor3.getTouching().size() > 0)
    {
      println("s3 activated");
      brain.neurons.get(2).activate();
    }
    //w4
    if (sensor4.getTouching().size() > 0)
    {
      println("s4 activated");
      brain.neurons.get(3).activate();
    }
    //w5
    if (sensor5.getTouching().size() > 0)
    {
      println("s5 activated");
      brain.neurons.get(4).activate();
    }
    //w6
    if (sensor6.getTouching().size() > 0)
    {
      println("s6 activated");
      brain.neurons.get(5).activate();
    }
    //w7
    if (sensor7.getTouching().size() > 0)
    {
      println("s7 activated");
      brain.neurons.get(6).activate();
    }
    //w8
    if (sensor8.getTouching().size() > 0)
    {
      println("s8 activated");
      brain.neurons.get(7).activate();
    }
    //w9
    if (sensor9.getTouching().size() > 0)
    {
      println("s9 activated");
      brain.neurons.get(8).activate();
    }
    //w10
    if (sensor10.getTouching().size() > 0)
    {
      println("s10 activated");
      brain.neurons.get(9).activate();
    }
    //w11
    if (sensor11.getTouching().size() > 0)
    {
      println("s11 activated");
      brain.neurons.get(10).activate();
    }
    //w12
    if (sensor12.getTouching().size() > 0)
    {
      println("s12 activated");
      brain.neurons.get(11).activate();
    }
    //w13
    if (sensor13.getTouching().size() > 0)
    {
      println("s13 activated");
      brain.neurons.get(12).activate();
    }
          /* i'll get this loop working at some point to make the code prettier
          for (int i = 0; i < 13; i++)
          {
            if (toString(sensor+i)
            {}
          }*/
    //input 14 (stomach sensor)
    float hungry = energy/100;
    brain.neurons.get(13).activate(hungry);
    
    //
    brain.step();
  }
  
  public void move()
  {
    float o1 = brain.neurons.get(214).getActivation();
    //println("o1 = "+o1);
    float o2 = brain.neurons.get(215).getActivation();
    //println("o2 = "+o2);
    float o3 = brain.neurons.get(216).getActivation();
    //println("o3 = "+o3);
    float o4 = brain.neurons.get(217).getActivation();
    //println("o4 = "+o4);
    float o5 = brain.neurons.get(218).getActivation();
    //println("o5 = "+o5);
    
    //output 1 - clockwise turn
    if (o1 < 0.7f)
    {
      println("clockwise turn");
      agt.addTorque(100.0f);
    }
    //output 2 - strafe left
    if (o2 < 0.7f)
    {
      println("strafe left");
      agt.addImpulse(100.0f,0.0f);
    }
    //output 3 - move UP
    if (o3 < 0.7f)
    {
      println("go up");
      agt.addImpulse(0.0f,100.0f);
    }
    //output 4 - strafe right
    if (o4 < 0.7f)
    {
      println("strafe right");
      agt.addImpulse(-100.0f,0.0f);
    }
    //output 5 - anticlockwise turn
    if (o5 < 0.7f)
    {
      println("anticlockwise turn");
      agt.addTorque(-100.0f);
    }
  }
  
}
class Connection
{
  //data
  float weight;
  int fromNeuron;
  int toNeuron;
  
  //constructor
  Connection(int comesFrom, int goesTo)
  {
    this.fromNeuron = comesFrom;
    this.toNeuron = goesTo;
    this.weight = random(1.0f);
  }
  
  //functions
  public void bind(Neuron n)
  {
    n.incConect.add(this);
  }
  public int cStart()
  {
    return fromNeuron;
  }
  public int cEnd()
  {
    return toNeuron;
  }
  
  public float cWeight()
  {
    return weight;
  }
}

class Genome
{
  //list for storing full genome
  ArrayList<Gene> genomeL = new ArrayList<Gene>();
  
  //constructor, 1st generation
  Genome(int genomeLen)
  {initRandomGenome(genomeLen);}
  
  //constructor, daughter generations
  Genome(){}
  
  //functions
  public void initRandomGenome(int geneNum)
  { for (int i = 0; i < geneNum; i++) 
    {genomeL.add(new Gene());}
  }
  public float geneX(int whichGene)
  { Gene temp = genomeL.get(whichGene);
    return temp.xPos;
  }
  public float geneY(int whichGene)
  { Gene temp = genomeL.get(whichGene);
    return temp.yPos;
  }
  public float geneA(int whichGene)
  { Gene temp = genomeL.get(whichGene);
    return temp.alure;
  }
  public boolean geneI(int whichGene)
  {
    Gene temp = genomeL.get(whichGene);
    return temp.inhib;
  }
  public boolean geneS(int whichGene)
  {
    Gene temp = genomeL.get(whichGene);
    return temp.strechy;   
  }
  
  public void mutate(int mutRate)
  {
    for (int i = 0; i < mutRate; i++)
    {
      int toMutate = PApplet.parseInt(random(1,genomeL.size()-1));
      genomeL.remove(toMutate);
      genomeL.add(new Gene());
    }
  }
}

class Gene
{
  //data
  float xPos;
  float yPos;
  float alure;
  boolean inhib;
  boolean strechy; //strechy neurons look for the furthest away attractive neurons, not the closest
  
  Gene () //default construction randomizes gene values
  {
     xPos = random(800.0f);
     yPos = random(650.0f);
    alure = random(1.0f);
    if (random(1.0f)<0.3f)
    {inhib = true;}
    else
    {inhib = false;}
    if(random(1.0f)<0.4f)
    {strechy = true;}
    else
    {strechy = false;}
    
  }
  
  Gene (float x, float y, float a) //explictly sets genome up other ways
  {
     xPos = x;
     yPos = y;
    alure = a;
    if (random(1.0f)<0.3f)
    {inhib = true;}
    else
    {inhib = false;}
    if(random(1.0f)<0.4f)
    {strechy = true;}
    else
    {strechy = false;}
  }
  
  Gene(float x, float y, float a, boolean i, boolean s)
  {
    xPos = x;
     yPos = y;
    alure = a;
    inhib = i;
    strechy = s;
  }
}


class NN implements Serializable
{
  /*data*/
  //the first 14 of these are input neurons, the last 5 are output
  ArrayList<Neuron> neurons = new ArrayList<Neuron>();
  ArrayList<Connection> connections = new ArrayList<Connection>();
  float axonLen = 500;
  Genome genome;
  
  //constructor for random (G1) agents
  NN(int gSize)
  {
    /*Genome*/ genome = new Genome(gSize);
    placeNeurons(genome);
    connectNetwork();
  }
  //constructor for born (G2 and later) agents
  NN(Genome pGenes)
  {
    genome = pGenes;
    genome.mutate(2);  //mutation rate is currently hardcoded here !-!-!-!-!-! NOTE !-!-!-!-!-!
    placeNeurons(genome);
    connectNetwork();
  }
  /*/copy function
  //returns a copy of this NN for use in child Agents
  /*/
  public Genome gCopy()
  {
    Genome childG = new Genome();
    Genome parentG = this.genome;
    for (int i = 0; i < parentG.genomeL.size(); i++)
    {
      Gene pGene = parentG.genomeL.get(i);
      Gene cGene = new Gene(pGene.xPos,pGene.yPos,pGene.alure);
      childG.genomeL.add(cGene);
    }
    return childG;
  }
  
  /*/stepping function
  //step through each neuron in the network, updating their activation
  //based on the activation of all incoming connections
  /*/
  public void step()
  {
    int nPop = this.neurons.size();
    //println(nPop);
    //only try to calculate internal/output neurons here, not input
    for (int z = 0; z < nPop; z++)
    {
      Neuron thsNeur = neurons.get(z);
      float sigIn = 0.0f;
      double sigOut = 0.0f;
      //summing function
      for (int x = 0; x < thsNeur.incConect.size(); x++)
      {
        Connection c = thsNeur.incConect.get(x);
        
        Neuron inNeur = neurons.get(c.fromNeuron);
        float toSum = inNeur.getActivation()*c.weight;
        sigIn += (toSum);
        //println(toSum);
        //println("sigIN (inside L) = "+sigIn);
      }
    //sigmoid function for calculating activation based on summing function
    sigOut = 1.0f/(1+Math.exp(-1.0f*(double)sigIn));  
    thsNeur.activate((float)sigOut);
    //println("sigIN (outside L) = "+sigIn);
    //println("sigOUT = "+sigOut);
    }
  }
  
  /*conection functions*/
  //calculate distance from one neuron to another
  public float distCalc(float x1, float x2, float y1, float y2)
  {
    float dist = sqrt(sq(x1 - x2) + sq(y1 - y2));
    return dist;
  }
  
  //return the axonLength of neurons in this network
  public float axonLen()
  {return axonLen;}
  
  //iterate through genome, creating neurons in the 'brain'
  public void placeNeurons(Genome dna)
  { 
    //add input neurons
    for (int i = 0; i < 14; i++)
    {
      neurons.add(new Neuron(-50, (float)43*i, true, false));
    }
    //add 'brain' neurons
    int rna = dna.genomeL.size();
    for (int i = 0; i < rna; i++)
    { float gX = dna.geneX(i);
      float gY = dna.geneY(i);
      float gA = dna.geneA(i);
      neurons.add(new Neuron(gX,gY,gA,axonLen));
    }
    //add output neurons
    for (int i = 0; i < 5; i++)
    {
      neurons.add(new Neuron(850, (float)140*i, false, true));
    }
  }
  
  //connect neurons in the network together
  public void connectNetwork()
  { 
    int nPop = neurons.size();
    for (int z = 0; z < nPop; z++) //for every neuron in this NN
    {
       //stores list of local neurons
       ArrayList<Neuron> locNeurons = new ArrayList<Neuron>();
       Neuron currNeuron = neurons.get(z);
       boolean axRemain = true;
       float viewR = 150.0f;
       float dist;
       Neuron targNeuron;
       for (int i = 0; i < neurons.size(); i++)   //first scan the area around current neuron, add a population of
       {                                          //other neurons within view range, add them to locNeurons
       targNeuron = neurons.get(i);
         if (targNeuron == currNeuron)
         {continue;}
         else
         {
           dist = distCalc(targNeuron.xVal(),currNeuron.xVal(),targNeuron.yVal(),currNeuron.yVal());
           
           if (dist < viewR) //only connect to what is in range
           {
             locNeurons.add(targNeuron);
           }
         }
       }
       //find the most attractive based on attractiveness and distance) in
       //locNeurons assign it to alphaN and it's distance to alphaDist, then
       // remove it from locNeurons. Continue until neuron runs out of axon
       while (axRemain == true)
       {
         int bestN = 1;       //stores aplpha's location on neruons arraylist
         int bestLoc = 0;     //stores alpha's location on locNeurons arraylist
         float bestDist = 800.0f; 
         float bestNeuAl = 0.0f; 
         Neuron viewingN;
         float viewNeuDist;
         float viewNeuAl;
         
         for (int j = 0; j < locNeurons.size(); j++) //check every neuron, evaluate distance and
         {                                           //overall attractiveness to current neuron
           viewingN = locNeurons.get(j);
           viewNeuDist = distCalc(viewingN.xVal(),currNeuron.xVal(),viewingN.yVal(),currNeuron.yVal());
           viewNeuAl = viewingN.alureCalc(viewNeuDist);
           
           if (viewNeuAl > bestNeuAl)  //if a neuron has a higher alure than current
           {                            //highest (alpha neuron), set it as the new alpha
             bestNeuAl = viewNeuAl;
             bestN = neurons.indexOf(viewingN);
             bestLoc = locNeurons.indexOf(viewingN);
             bestDist = viewNeuDist;
           }
         }
       
         if (currNeuron.axLength() < bestDist)  //now connec to the most attractive neuron
         { axRemain = false; }                     //in sight if there is enough membrane
         else                                    //(alpha should refer to it's index location)
         { 
           int from = neurons.indexOf(currNeuron);
           int to = bestN;
           Neuron toN = neurons.get(bestN);
           Connection newConnect = new Connection(from,to);
           connections.add(newConnect);
           currNeuron.axShorter(bestDist);
           toN.incConect.add(newConnect);
           locNeurons.remove(bestLoc);
         }
       }      
    }
  }
}
  
class Neuron
{
  //data
  float posX;
  float posY;
  float alure;
  float membLength;
  boolean inp = false;
  boolean otp = false;
  boolean strechy = false;
  float activity;
  ArrayList<Connection> incConect = new ArrayList<Connection>();

  //constructor 1
  Neuron(float x, float y, float atr)
  {
    posX = x;
    posY = y;
    alure = atr;
    membLength = random(300,700);
    inp = false;
    otp = false;
    if (random(1.0f) > 5.0f){strechy = false;}
    else{strechy = true;}
  }
  //constructor 2 THIS IS THE PRIMARY CONSTRUCTOR USED IN FILLING NN's
  Neuron(float x, float y, float atr, boolean strech)
  {
    posX = x;
    posY = y;
    alure = atr;
    membLength = random(300,700);
    inp = false;
    otp = false;
    strechy = strech;
    activity = 0.0f;
  }
  //constructor 2
  Neuron(float x, float y, float atr, float axLen)
  {
    posX = x;
    posY = y;
    alure = atr;
    membLength = axLen;
    inp = false;
    otp = false;
  }
  //constructor 4: input/output neurons
  Neuron(float x, float y, boolean isInp, boolean isOtp)
  {
    posX = x;
    posY = y;
    if (isInp == true)
    {
      inp = true;
      membLength = 500;
      alure = -10.0f;
    }
    else if(isOtp == false)
    {
      otp = true;
      membLength = 0.0f;
      alure = 1.0f;
    }
  }
  //activation function
  public void activate()
  {
    activity = 1.0f;
  }
  public void activate(float thisMuch)
  {
    activity = thisMuch;
  }
  public float getActivation()
  {
    //println("neuron activated");
    //activity = random(1.0);  //temporary
    //println(activity);
    return activity;
  }
  
  
  /*query functions*/
  public float axLength()
  {
    return membLength;
  }
  public float xVal()
  {
    return posX;
  }
  public float yVal()
  {
    return posY;
  }
  public float alureVal()
  {
    return alure;
  }
  public boolean inpNeu()
  {
    if (inp = true) {return true;}
    else {return false;}
  }
  public boolean otpNeu()
  {
    if (otp = true) {return true;}
    else {return false;}
  }
  public void axShorter(float less)
  {
    membLength -= less;
  }
  public float alureCalc(float dist)
  { 
    float totAlure = dist/this.alure;
    return totAlure;
  }
}

class Nutrients
{
  int calories;
  float initialX;
  float initialY;
  FCircle nu;
  
  Nutrients()
  {
    calories = PApplet.parseInt(random(10,50));
    initialX = (int)random(10,990);
    initialY = (int)random(10,50);
    nu = new FCircle(10);
    nu.setPosition(initialX,initialY);
    nu.setName("morsel");
    nu.setFill(75,240,39);
    physics.add(nu);
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Kelpsim" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
