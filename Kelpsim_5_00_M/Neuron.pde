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
  float pActivity;
  float weight;
  ArrayList<Connection> incConect = new ArrayList<Connection>();

  //constructor 1
  Neuron(float x, float y, float atr, float w)
  {
    posX = x;
    posY = y;
    alure = atr;
    membLength = random(300,700);
    inp = false;
    otp = false;
    if (random(1.0) > 5.0){strechy = false;}
    else{strechy = true;}
    weight = w;
  }
  //constructor 2
  Neuron(float x, float y, float atr, boolean strech, float w)
  {
    posX = x;
    posY = y;
    alure = atr;
    membLength = random(300,700);
    inp = false;
    otp = false;
    strechy = strech;
    activity = 0.0;
    weight = w;
  }
  //constructor 3 THIS IS THE PRIMARY CONSTRUCTOR USED IN FILLING NN's
  Neuron(float x, float y, float atr, float axLen, float w)
  {
    posX = x;
    posY = y;
    alure = atr;
    membLength = axLen;
    inp = false;
    otp = false;
    weight = w;
  }
  //constructor 4: input/output neurons
  Neuron(float x, float y, boolean isInp, boolean isOtp, float w)
  {
    posX = x;
    posY = y;
    if (isInp == true)
    {
      inp = true;
      membLength = 400;
      alure = -10.0;
    }
    else if(isOtp == false)
    {
      otp = true;
      membLength = 0.0;
      alure = 1.0;
    }
    weight = w;
  }
  //activation function
  void activate()
  {
    //pActivity = 1.0;
    activity = 1.0;
  }
  void activate(float thisMuch)
  {
    //pActivity = activity;
    activity = thisMuch;
  }
  //retrieve activity
  float getActivation()
  { 
    return activity+random(-0.025,0.025);
    //return pActivity+random(-0.025,0.025);
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
