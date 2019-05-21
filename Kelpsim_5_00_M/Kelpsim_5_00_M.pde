
//java imports
import java.io.Serializable;
import java.math.*;
//processing imports
import controlP5.*;
import fisica.*;
import g4p_controls.*;

//state data - for switching between the main menu, simulation,
// and analysis modes
final int sMenu = 0;
final int sSim = 1;
final int sStat = 2;
int state = sMenu;

//world data
FWorld physics;
long steps;
long startTime;
long passedTime;
int foodTime = 250;
int metTime = 100;
int curentTimeF = 0;
int curentTimeA = 0;
public boolean stepFunction;
public boolean metabolic;
public int totalAgt;
ArrayList<Nutrients> food;
ArrayList<Agent> population;

//for stat display selection
//Agent viewing;
int intPick = 0;

//GUI data
ControlP5 cp5;


void setup()
{
  stepFunction = false;
  metabolic = true;
  cp5 = new ControlP5(this);
  cp5.addTextfield("Pick_Agent",1000,70,100,20);
  totalAgt = 0;
  passedTime = 0;
  steps = 0;
  size(1650,900); //prior stable (1250,700);
  Fisica.init(this);
  food = new ArrayList<Nutrients>();
  population = new ArrayList<Agent>();
  steps = 0;
  
  physics = new FWorld();
  physics.setEdges();
  physics.setEdgesRestitution(1.2);
  physics.setGravity(0,15);
  
  //initial population size decided here
  for(int i=0;i<25;i++){
    population.add(new Agent());
  }
  
  //initial amount of available food decided here
  for(int j = 0; j<50; j++){
    food.add(new Nutrients());
  }
}

void draw()
{
  switch (state)
  {
    case sMenu:
    menuDisplay();
    break;
    
    case sSim:
    simDisplay();
    break;
    
    case sStat:
    statDisplay();
    break;
  }
}


void menuDisplay()
{
  //window setup
  fill(#F58AF3);
  rect(200,50,850,600);
  fill(#5EF5DF);
  rect(220,200,250,410,9);
  rect(500,200,250,410,9);
  rect(780,200,250,410,9);

  //strings for text
  String title = "KELPSIM 5.0 - MENU";
  String expl =
"- A 2D simulation environment designed to explore the effect of neural metabolism on the evolution of brain structure\n in dimunitive whiskered creatures called 'Kelpians'.";
  String cM = "MENU CONTROLS:";
  String cST = "STATISTICS CONTROLS:";
  String cSI = "SIMULATION CONTROLS:";
  String r =
"~ to run the simulation press 'R'";
  String rST =
"~ to resume the simulation, press 'R'";
  String n =
"~ to start a new simulation, press 'N'";
  String sta =
"~ to get to the statistics mode, press 'S'";
  String sM =
"~ to return to this menu press 'M'";
  String a =
"~ to toggle between neural/non-neural based metabolic rates, press 'A'";
  String f =
"~ to switch between sigmoid and tanH activation functions, press 'F'";
  //placing text
  textSize(65);
  fill(1);
  text(title,270,110);
  
  //fill(1);
  textSize(14);
  text(expl, 205, 160);
  
  text(cM, 250,220);
  text(r,230,235,230,70);
  text(n,230,290,230,70);
  text(a,230,345,230,70);
  text(f,230,450,230,70);
  if (metabolic == true)
  {
  fill(#07F53C);
  ellipse(350,420,20,20);
  }
  else
  {
  fill(#F72E0A);
  ellipse(350,420,20,20);
  }
  
  fill(1);
  text(cSI, 530,220);
  text(sta,510,235,230,70);
  text(sM,510,290,230,70);
  if (stepFunction == true)
  {
  fill(#07F53C);
  ellipse(350,500,20,20);
  }
  else
  {
  fill(#F72E0A);
  ellipse(350,500,20,20);
  }
  
  fill(1);
  text(cST, 810,220);
  text(rST,790,235,230,70);
  
}

void simDisplay()
{
  background(0);
  int passedTimeF = millis() - curentTimeF;
  startTime = System.currentTimeMillis();
  
  //if enough time has passed, add more food to the world
  if (passedTimeF > foodTime)
  {
    food.add(new Nutrients());
    curentTimeF = millis();
  }
  
  //if there is too much food, remove food from the world (oldest first)
  if (food.size() > 80)
  { 
    FCircle n = food.get(0).nu;
    physics.remove(n);
    food.remove(0);
  }
  
  // step through all agents and deal with their eating/metabolism/breeding
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
            physics.remove(b1);
            a.energy += 50.0;
            fill(#FF0000);
            ellipse(c.getX(), c.getY(), 80, 80);
        }
        else if(b2.getName()=="morsel")
        {
            physics.remove(b2);
            a.energy += 50.0;
            fill(#FF0000);
            ellipse(c.getX(), c.getY(), 80, 80);
        }
      }
      a.liveFor++;
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
        a.children++;
      }
    }
    curentTimeA = millis();
  }
  steps ++;
  physics.step();
  physics.draw();
  passedTime += System.currentTimeMillis() - startTime;
}

void statDisplay()
{
  //main window
  fill(#6AF5A3);
  rect(75,50,1100,635);
  fill(1);
  textSize(40);
  text("STATISTICS",125,100);
  
  //simulation stats
  fill(#6E71E8);
  rect(90,120,400,500,8);
  textSize(16);
  fill(1);
  text(":::General simulation stats:::",100,150);
  //logic to gather average connections/neurons/age per agent
  int sumAge = 0;
  int sumChild = 0;
  int sumNeur = 0;
  int sumCon = 0;
  for (int u = 0; u < population.size();u++)
  {
    Agent examined = population.get(u);
    sumNeur += examined.brain.neurons.size();
    sumCon += examined.brain.connections.size();
    sumAge += examined.liveFor;
    sumChild += examined.children;
  }
  //int averageInCon = su
  int averageAge = sumAge/population.size();
  int averageChild = sumChild/population.size();
  int averageNur = sumNeur/population.size();
  int averageCon = sumCon/population.size();
  
  textSize(12);
  text("- this simulation has run for "+steps+" steps",100,180);
  text("- this simulation has run for "+passedTime/1000+" seconds",100,210);
  text("- there have been "+totalAgt+" agents born",100,240);
  text("- "+population.size()+" agents are alive right now",100,270);
  text("- agents NN's have an average of "+averageNur+" neurons",100,330);
  text("- agents NN's have an average of "+averageCon+" connections",100,360);
  text("- agents are an average of "+averageAge+" steps old",100,300);
  text("- agents have an average of " +averageChild+" daughters",100,390); 

  //agent specific stats
  Agent viewing;
  if (intPick <= population.size())
  {
    viewing = population.get(intPick);
  }else
  {viewing = population.get(0);}
  NN vb = viewing.brain;
  int sumInCon = 0;
  for (int j=14;j<vb.neurons.size();j++)
  {
    Neuron conSta = vb.neurons.get(j);
    sumInCon += conSta.incConect.size();
  }
  int averageIncCon = sumInCon/vb.neurons.size();
  
  fill(#9F66EA);
  rect(550,60,580,200,7);
  fill(1);
  textSize(16);
  text("::Selected agent stats::",700,80);
  textSize(12);
  text("- agent has "+vb.neurons.size()+" neurons",600,100);
  text("- agent has "+vb.connections.size()+" connections",600,120);
  text("- agent's neurons have "+averageIncCon+" incoming connections average",600,140);
  text("- agent has been alive for "+viewing.liveFor+" steps",600,160);
  text("- agent has "+viewing.children+" daughters",600,180);
  
  //agent specific NN display
  fill(#757676);
  rect(550,250,580,420,10);
  //WORKING BELOW//WORKING BELOW//WORKING BELOW//WORKING BELOW//WORKING BELOW
  
  //display every connection between neurons
  for (int i = 0; i < vb.connections.size(); i++)
  {
    Connection connect = vb.connections.get(i);
    float startX = vb.neurons.get(connect.cStart()).xVal();
    float startY = vb.neurons.get(connect.cStart()).yVal();
    float endX = vb.neurons.get(connect.cEnd()).xVal();
    float endY = vb.neurons.get(connect.cEnd()).yVal();
    float weight = connect.cWeight();
    strokeWeight(0.5+3.25*weight);
    stroke(30 + 180*weight, 51, 200 - 180*weight);
    line(startX*0.51+655,startY*0.51+270,endX*0.51+655,endY*0.51+270);
  }
  
  
  //display every neuron in the network
  for (int j = 0; j < vb.neurons.size(); j++)
  {
    Neuron neuron = vb.neurons.get(j);
    ellipseMode(CENTER);
    stroke(#24FFB0);
    fill(#2285ED);
    strokeWeight(3);
    ellipse(neuron.xVal()*0.51+655,neuron.yVal()*0.51+270,10,10);
    textSize(10);
    //fill(#080202);
    
  }
  
  //WORKING ABOVE//WORKING ABOVE//WORKING ABOVE//WORKING ABOVE//WORKING ABOVE  
}

public void Pick_Agent(String picked)
{
  int intChk = Integer.parseInt(picked);
  if (intChk <= population.size()-1)
  {
    intPick = intChk;
  }
}
public void controlEvent(ControlEvent event)
{}

//keyboard input handling, general
void keyPressed()
{
  switch (state)
  {
    case sMenu:
    menuKeys();
    break;
    
    case sSim:
    simKeys();
    break;
    
    case sStat:
    statKeys();
    break;
    
    default:
    break;
  }
}

void menuKeys()
{
  switch (key)
  {
    //run the simulation
    case 'r':
    state = sSim;
    break;
    
    //start a new simulation instance
    case 'n':
    background(0);
    setup();
    break;
    
    //on-off switch for agent metabolic rate based on number of neurons
    case 'a':
    if (metabolic == false)
    {
      metabolic = true;
    }
    else// if (metabolic == true)
    {
      metabolic = false;
    }
    break;
    
    case 'f':
    if (stepFunction == false)
    {
      stepFunction = true;
    }
    else// if (stepFunction == true)
    {
      stepFunction = false;
    }
    break;
    
    default:
    break;
  }
}

void simKeys()
{
  switch (key)
  {
    case 'p':
    if (paused = false)
    {paused = true;}
    else
    {paused = false;}
    break;
    
    case 'm':
    state = sMenu;
    break;
    
    case 's':
    state = sStat;
    break;
    
    default:
    break;
  }
}

void statKeys()
{
  switch (key)
  {
    case 'r':
    state = sSim;
    break;

    default:
    break;
  }
}
