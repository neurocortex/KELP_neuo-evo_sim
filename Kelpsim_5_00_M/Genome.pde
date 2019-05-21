
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
  void initRandomGenome(int geneNum)
  { for (int i = 0; i < geneNum; i++) 
    {genomeL.add(new Gene());}
  }
  float geneX(int whichGene)
  { Gene temp = genomeL.get(whichGene);
    return temp.xPos;
  }
  float geneY(int whichGene)
  { Gene temp = genomeL.get(whichGene);
    return temp.yPos;
  }
  float geneA(int whichGene)
  { Gene temp = genomeL.get(whichGene);
    return temp.alure;
  }
  boolean geneI(int whichGene)
  {
    Gene temp = genomeL.get(whichGene);
    return temp.inhib;
  }
  boolean geneS(int whichGene)
  {
    Gene temp = genomeL.get(whichGene);
    return temp.strechy;   
  }
  float geneW(int whichGene)
  {
    Gene temp = genomeL.get(whichGene);
    return temp.weight;
  }
  
  void mutate(int mutRate)
  {
    float mutType = random(1);
    for (int i = 0; i < mutRate; i++)
    {
      int toMutate = int(random(14,genomeL.size()-6));
      if (mutType > 0.67)
      {
        genomeL.remove(toMutate);
      }
      else if(mutType < 0.32)
      {
        genomeL.add(new Gene());
      }
      else
      {
        genomeL.remove(toMutate);
        genomeL.add(new Gene());
      }
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
  float weight;
  
  Gene () //default construction randomizes gene values
  {
     xPos = random(800.0);
     yPos = random(750);
     //yPos = random(650.0);
    alure = random(1.0);
    if (random(1.0)<0.3)
    {inhib = true;}
    else
    {inhib = false;}
    if(random(1.0)<0.4)
    {strechy = true;}
    else
    {strechy = false;}
    weight = random(1.0);
    
  }
  
  Gene (float x, float y, float a, float w) //explictly sets genome up other ways
  {
    xPos = x;
    yPos = y;
    alure = a;
    weight = w;
    if (random(1.0)<0.3)
    {inhib = true;}
    else
    {inhib = false;}
    if(random(1.0)<0.4)
    {strechy = true;}
    else
    {strechy = false;}
  }
  
  Gene(float x, float y, float a, boolean i, boolean s, float w)
  {
    xPos = x;
    yPos = y;
    alure = a;
    inhib = i;
    strechy = s;
    weight = w;
  }
}
