

class NN implements Serializable
{
  /*data*/
  //the first 14 of these are input neurons, the last 5 are output
  ArrayList<Neuron> neurons = new ArrayList<Neuron>();
  ArrayList<Connection> connections = new ArrayList<Connection>();
  float axonLen = 900; //formerly 500, ajusted to allow for sparser network
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
    genome.mutate((int)random(1,3));  //mutation rate is currently hardcoded here !-!-!-!-!-!
    placeNeurons(genome);
    connectNetwork();
  }
  /*/copy function
  //returns a copy of this NN for use in child Agents
  /*/
  Genome gCopy()
  {
    Genome childG = new Genome();
    Genome parentG = this.genome;
    for (int i = 0; i < parentG.genomeL.size(); i++)
    {
      float blur = random(0.9,1.1);
      Gene pGene = parentG.genomeL.get(i);
      Gene cGene = new Gene(pGene.xPos,pGene.yPos,pGene.alure,pGene.weight*blur);
      childG.genomeL.add(cGene);
    }
    return childG;
  }
  
  /*/stepping function
  //step through each neuron in the network, updating their activation
  //based on the activation of all incoming connections
  /*/
  void step()
  {
    int nPop = this.neurons.size();
    //println(nPop);
    //only try to calculate internal/output neurons here, not input
    for (int z = 14; z < nPop; z++)
    {
      Neuron thsNeur = neurons.get(z);
      float stepIn = 0.0;
      double stepOut = 0.0;
      if (thsNeur.incConect.size()>0)
      {
        //summing function
        for (int x = 0; x < thsNeur.incConect.size(); x++)
        {
          Connection c = thsNeur.incConect.get(x);
          
          Neuron inNeur = neurons.get(c.fromNeuron);
          float toSum = inNeur.getActivation()*c.weight;
          stepIn += (toSum);
        }
        if(stepFunction = false)
        {/////////sigmoid activation function
          stepOut = 1.0/(1+Math.exp(-1.0*(double)stepIn));  
          thsNeur.activate((float)stepOut);
        }else if (stepFunction = true)
        {/////////tanH activation function
          stepOut =
(Math.exp((double)stepIn*2.0)-1.0)/(Math.exp((double)stepIn*2.0)+1.0);
          thsNeur.activate((float)stepOut);
        }
      }/*
      else
      {
        stepOut = random(-0.5,0.5);
      }*/
    }
  }
  
  /*conection functions*/
  //calculate distance from one neuron to another
  float distCalc(float x1, float x2, float y1, float y2)
  {
    float dist = sqrt(sq(x1 - x2) + sq(y1 - y2));
    return dist;
  }
  
  //return the axonLength of neurons in this network
  float axonLen()
  {return axonLen;}
  
  //iterate through genome, creating neurons in the 'brain'
  void placeNeurons(Genome dna)
  { 
    //add input neurons
    for (int i = 0; i < 14; i++)
    {
      neurons.add(new Neuron(-70, ((float)55*i)+5, true, false,1.0));
    }
    //add 'brain' neurons
    int rna = dna.genomeL.size();
    for (int i = 0; i < rna; i++)
    { float gX = dna.geneX(i);
      float gY = dna.geneY(i);
      float gA = dna.geneA(i);
      float gW = dna.geneW(i);
      neurons.add(new Neuron(gX,gY,gA,axonLen,gW));
    }
    //add output neurons
    for (int i = 0; i < 5; i++)
    {
      neurons.add(new Neuron(850, ((float)175*i)+10, false, true,0.0));
    }
  }
  
  //connect neurons in the network together
  void connectNetwork()
  { 
    int nPop = neurons.size();
    for (int z = 0; z < nPop; z++) //for every neuron in this NN
    {
       //stores list of local neurons
       ArrayList<Neuron> locNeurons = new ArrayList<Neuron>();
       Neuron currNeuron = neurons.get(z);
       boolean axRemain = true;
       float viewR = 175.0; //formerly 150
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
         float bestDist = 800.0; 
         float bestNeuAl = 0.0; 
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
           Connection newConnect = new Connection(from,to,currNeuron.weight);
           connections.add(newConnect);
           currNeuron.axShorter(bestDist);
           toN.incConect.add(newConnect);
           locNeurons.remove(bestLoc);
         }
       }      
    }
  }
}
  
