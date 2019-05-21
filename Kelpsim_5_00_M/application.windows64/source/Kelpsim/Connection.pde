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
    this.weight = random(1.0);
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
