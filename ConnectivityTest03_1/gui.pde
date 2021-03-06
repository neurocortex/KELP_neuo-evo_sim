/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void button2_click1(GButton source, GEvent event) { //_CODE_:buildButton:429859:
  clear();
  background(#868585);
  int gSize = round(200*neuronS.getValueF());
  Genome genome = new Genome(gSize);
  NN neuralNet = new NN();
  neuralNet.placeNeurons(genome);
  neuralNet.connectNetwork();
  outputText.setText("\nNetwork size:\n"
  +neuralNet.neurons.size()+ " neurons, making\n"
  +neuralNet.connections.size()+" connections\n\n"
  +"axon length (per neuron): "+neuralNet.axonLen()
  );
  
  for (int i = 0; i < neuralNet.connections.size(); i++) //display every connection between neurons
  {
    Connection connect = neuralNet.connections.get(i);
    float startX = neuralNet.neurons.get(connect.cStart()).xVal();
    float startY = neuralNet.neurons.get(connect.cStart()).yVal();
    float endX = neuralNet.neurons.get(connect.cEnd()).xVal();
    float endY = neuralNet.neurons.get(connect.cEnd()).yVal();
    strokeWeight(2);
    stroke(#FA77A9);
    line(startX+50,startY+25,endX+50,endY+25);  //drawing the connection
  }
 
  for (int j = 0; j < neuralNet.neurons.size(); j++) //display every neuron in the network
  {
    Neuron neuron = neuralNet.neurons.get(j);
    ellipseMode(CENTER);
    stroke(#24FFB0);
    fill(#2285ED);
    strokeWeight(3);
    ellipse(neuron.xVal()+50,neuron.yVal()+25,25,25);
    
    textSize(10);
    textAlign(CENTER);
    fill(#080202);
    text("#-"+j,neuron.xVal()+50,neuron.yVal()+25);
  }
  //println("button2 - GButton event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:buildButton:429859:

public void slider1_change1(GSlider source, GEvent event) { //_CODE_:axonSlider:212894:
  //println("slider1 - GSlider event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:axonSlider:212894:

public void slider1_change2(GSlider source, GEvent event) { //_CODE_:neuronS:864780:
  
  //println("slider1 - GSlider event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:neuronS:864780:

public void textarea2_change1(GTextArea source, GEvent event) { //_CODE_:outputText:856798:
  println("outputText - GTextArea event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:outputText:856798:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  if(frame != null)
    frame.setTitle("Sketch Window");
  buildButton = new GButton(this, 980, 20, 100, 20);
  buildButton.setText("build network");
  buildButton.setTextBold();
  buildButton.setLocalColorScheme(GCScheme.RED_SCHEME);
  buildButton.addEventHandler(this, "button2_click1");
  neurSizeLabel = new GLabel(this, 980, 70, 90, 28);
  neurSizeLabel.setText("number of neurons");
  neurSizeLabel.setOpaque(false);
  axonSlider = new GSlider(this, 960, 160, 142, 60, 10.0);
  axonSlider.setShowLimits(true);
  axonSlider.setLimits(1.0, 0.0, 2.0);
  axonSlider.setNbrTicks(5);
  axonSlider.setShowTicks(true);
  axonSlider.setNumberFormat(G4P.DECIMAL, 2);
  axonSlider.setOpaque(false);
  axonSlider.addEventHandler(this, "slider1_change1");
  axonLabel = new GLabel(this, 980, 140, 104, 38);
  axonLabel.setText("axon length");
  axonLabel.setOpaque(false);
  neuronS = new GSlider(this, 960, 90, 142, 56, 10.0);
  neuronS.setShowLimits(true);
  neuronS.setLimits(1.0, 0.0, 2.0);
  neuronS.setNbrTicks(5);
  neuronS.setShowTicks(true);
  neuronS.setNumberFormat(G4P.BLUE_SCHEME, 2);
  neuronS.setOpaque(false);
  neuronS.addEventHandler(this, "slider1_change2");
  outputLabel = new GLabel(this, 890, 220, 80, 20);
  outputLabel.setText("network stats:");
  outputLabel.setOpaque(false);
  outputText = new GTextArea(this, 890, 240, 240, 440, G4P.SCROLLBARS_VERTICAL_ONLY);
  outputText.setOpaque(true);
  outputText.addEventHandler(this, "textarea2_change1");
}

// Variable declarations 
// autogenerated do not edit
GButton buildButton; 
GLabel neurSizeLabel; 
GSlider axonSlider; 
GLabel axonLabel; 
GSlider neuronS; 
GLabel outputLabel; 
GTextArea outputText; 
