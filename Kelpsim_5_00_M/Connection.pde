class Connection
{
  //data
  float weight;
  int fromNeuron;
  int toNeuron;
  
  //constructor
  Connection(int comesFrom, int goesTo, float startWeight)
  {
    this.fromNeuron = comesFrom;
    this.toNeuron = goesTo;
    this.weight = startWeight;//float(startWeight*random(0.9,1.1));
  }
  
  //functions
  void bind(Neuron n)
  {
    n.incConect.add(this);
  }
  int cStart()
  {
    return fromNeuron;
  }
  int cEnd()
  {
    return toNeuron;
  }
  
  float cWeight()
  {
    return weight;
  }
}
