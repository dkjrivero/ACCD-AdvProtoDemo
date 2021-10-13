import processing.serial.*;
Serial myConnection;
String serialValue = "";
color bkgColor;
BeeHive hive;
int currentValue = 0;
int previousValue = 0;
ArrayList<Sunflower> flowers;
float cv;
float pv;
//boolean added;
//boolean button_pressed;
//float Sunflower;
//Sunflower flowers_new ;

void setup() { //set up the screen
  size(800, 800);

  //printArray(Serial.list());
  myConnection = new Serial(this, Serial.list()[4], 9600);
  myConnection.bufferUntil('\n');

  //added = false;
  bkgColor = color(135, 206, 235); // define bg color
  flowers = new ArrayList<Sunflower>(); // initalizing flower
  hive = new BeeHive(); // initalizing bee
  //flowers_new = new Sunflower();
}

void draw() {
  background(bkgColor);
  hive.display(); // display hive on screen

  for (Bee bee : hive.bees) { //for every bee in the beehive
    bee.display(); // display bee on screen
    bee.move(flowers, hive); // moving alll the bees
  }
  for (Sunflower flower : flowers) { //for every flower
    if (!hive.targets.containsKey(flower) || !hive.targets.get(flower).busy) flower.display(); // check if not a target or been captured
  }

  //if (button_pressed == true) {
  //  flowers.add(new Sunflower());
  //  button_pressed = false;
  //}
  //println(button_pressed);
  //println(serialValue);
  //if (serialValue == null) {
  //  print("true");
  //}

  //else {
  //  button_pressed = false;
  //}

  //if (myConnection.available()>0) {
  //  // button is pressed
  //  flowers.add(new Sunflower());

  //}
}//end of draw
//void serialEvent(Serial conn){
//  flowers.add(new Sunflower());

//}
//void mousePressed() {
//  hive.bees.add(new Bee()); // new bee gets added
//}
// instead of add bee with mous preess make bee control
//void keyReleased() {
//  if (key == ' ') {
//    flowers.add(new Sunflower()); // new flower appears
//  }
//}
void serialEvent(Serial conn) {
  float serialValue[] = float(split(trim(conn.readString()), ','));
  //nVc = map(float(serialValue), 0, 4095, 0, 11);
  //nVp = map(float(serialValue), 0, 4095, 0, 11);
  //if(currentValue > previous) {
  //  hive.bees.add(new Bee());
  //  else if(nVc < nVp) {
  //    hive.bees.remove(nVp);
  //  }
  //}
  pv = cv;
  cv = (serialValue[0]);
  if(cv != pv && cv > 4094) {
    hive.bees.add(new Bee());
  }
  else if (cv != pv && cv < 1) {
    hive.bees.remove(hive.bees.size() - 1);
  }
  println(serialValue);
  //nVp = nVc
 
  //if(values.length == 3){
  //  posX = map(values[0], 0, 4095, 0, width);
  //}
  previousValue = currentValue;
  currentValue = ((int) serialValue[2]);
  if (previousValue == 0 && currentValue == 1){ 
    flowers.add(new Sunflower());
  }
//  //printArray(serialVals);
}
