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
    if (random(1.0) > 5.0){strechy = false;}
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
    activity = 0.0;
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
      alure = -10.0;
    }
    else if(isOtp == false)
    {
      otp = true;
      membLength = 0.0;
      alure = 1.0;
    }
  }
  //activation function
  void activate()
  {
    activity = 1.0;
  }
  void activate(float thisMuch)
  {
    activity = thisMuch;
  }
  float getActivation()
  {
    //println("neuron activated");
    //activity = random(1.0);  //temporary
    //println(activity);
    return activity;
  }
  
  
  /*query functions*/
  float axLength()
  {
    return membLength;
  }
  float xVal()
  {
    return posX;
  }
  float yVal()
  {
    return posY;
  }
  float alureVal()
  {
    return alure;
  }
  boolean inpNeu()
  {
    if (inp = true) {return true;}
    else {return false;}
  }
  boolean otpNeu()
  {
    if (otp = true) {return true;}
    else {return false;}
  }
  void axShorter(float less)
  {
    membLength -= less;
  }
  float alureCalc(float dist)
  { 
    float totAlure = dist/this.alure;
    return totAlure;
  }
}
