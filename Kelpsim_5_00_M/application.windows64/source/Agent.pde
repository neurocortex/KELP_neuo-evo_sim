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
    energy = 90.0;
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
    sensor6.setRotation(1.3089);
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
    sensor8.setRotation(1.8325);
    sensor8.setStroke(222,255,15);
    //sensor 9
    sensor9 = new FBox(2,100);
    sensor9.setName("sensor9");
    sensor9.setGroupIndex(-1);
    sensor9.setSensor(true);
    sensor9.setPosition(x+46,y+25);
    sensor9.setRotation(2.0943);
    sensor9.setStroke(222,255,15);
    //sensor 10
    sensor10 = new FBox(2,100);
    sensor10.setName("sensor10");
    sensor10.setGroupIndex(-1);
    sensor10.setSensor(true);
    sensor10.setPosition(x+37,y+35);
    sensor10.setRotation(2.3561);
    sensor10.setStroke(222,255,15);
    //sensor 11
    sensor11 = new FBox(2,100);
    sensor11.setName("sensor11");
    sensor11.setGroupIndex(-1);
    sensor11.setSensor(true);
    sensor11.setPosition(x+25,y+43);
    sensor11.setRotation(2.6179);
    sensor11.setStroke(222,255,15);
    //sensor 12
    sensor12 = new FBox(2,100);
    sensor12.setName("sensor12");
    sensor12.setGroupIndex(-1);
    sensor12.setSensor(true);
    sensor12.setPosition(x+13,y+47);
    sensor12.setRotation(2.8797);
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
    sensor6.setRotation(1.3089);
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
    sensor8.setRotation(1.8325);
    sensor8.setStroke(222,255,15);
    //sensor 9
    sensor9 = new FBox(2,100);
    sensor9.setName("sensor9");
    sensor9.setGroupIndex(-1);
    sensor9.setSensor(true);
    sensor9.setPosition(x+46,y+25);
    sensor9.setRotation(2.0943);
    sensor9.setStroke(222,255,15);
    //sensor 10
    sensor10 = new FBox(2,100);
    sensor10.setName("sensor10");
    sensor10.setGroupIndex(-1);
    sensor10.setSensor(true);
    sensor10.setPosition(x+37,y+35);
    sensor10.setRotation(2.3561);
    sensor10.setStroke(222,255,15);
    //sensor 11
    sensor11 = new FBox(2,100);
    sensor11.setName("sensor11");
    sensor11.setGroupIndex(-1);
    sensor11.setSensor(true);
    sensor11.setPosition(x+25,y+43);
    sensor11.setRotation(2.6179);
    sensor11.setStroke(222,255,15);
    //sensor 12
    sensor12 = new FBox(2,100);
    sensor12.setName("sensor12");
    sensor12.setGroupIndex(-1);
    sensor12.setSensor(true);
    sensor12.setPosition(x+13,y+47);
    sensor12.setRotation(2.8797);
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

  void metabolism()
  {
    if (energy > 100.0) {
      energy = 100.0;
      eggCounter+=1;
      if (eggCounter>5)
      {
        energy = 55.0;
        layEgg = true;
        eggCounter = 0;
      }
    }
    else
    {
      energy -= 0.35;
    }
    if (energy < 0.0)
    {
      alive = false;
      this.die();
    }
    textSize(10);
    text(energy, this.agt.getX(), this.agt.getY());
  }
  
  void die()
  {
    //serialize nn object to file here
    physics.remove(agtComp);
  }
  
  void sense()
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
  
  void move()
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
    if (o1 < 0.7)
    {
      println("clockwise turn");
      agt.addTorque(100.0);
    }
    //output 2 - strafe left
    if (o2 < 0.7)
    {
      println("strafe left");
      agt.addImpulse(100.0,0.0);
    }
    //output 3 - move UP
    if (o3 < 0.7)
    {
      println("go up");
      agt.addImpulse(0.0,100.0);
    }
    //output 4 - strafe right
    if (o4 < 0.7)
    {
      println("strafe right");
      agt.addImpulse(-100.0,0.0);
    }
    //output 5 - anticlockwise turn
    if (o5 < 0.7)
    {
      println("anticlockwise turn");
      agt.addTorque(-100.0);
    }
  }
  
}
