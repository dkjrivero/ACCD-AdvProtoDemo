import processing.serial.*;
Serial myConnection;
String serialValue = "";
color bkgColor;
BeeHive hive;
float currentValue;
float previousValue;
ArrayList<Sunflower> flowers;
float cv;
float pv;
int flowerstoadd = 0;

void setup() { //set up the screen
  size(800, 800);

  //printArray(Serial.list());
  myConnection = new Serial(this, Serial.list()[4], 9600);
  myConnection.bufferUntil('\n');

  //added = false;
  bkgColor = color(135, 206, 235); // define bg color
  flowers = new ArrayList<Sunflower>(); // initalizing flower
  hive = new BeeHive(); // initalizing bee
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
  if (flowerstoadd > 0) {
    for (int i = 0; i < flowerstoadd; i++) {
      flowers.add(new Sunflower());
    }
    flowerstoadd = 0;
  }
}//end of draw

void serialEvent(Serial conn) {
  String input = trim(conn.readString());
  println(input);
  float[] pieces = new float[2];
  pieces = float(split(input, ','));
  printArray(pieces);

  if (pieces.length == 2) { 
    float potentiometer = -1, forceSensor = -1;
    potentiometer = pieces[0];
    forceSensor = pieces[1];

    pv = cv;
    cv = potentiometer; // adds bees and removes bees
    if (cv != pv && cv > 4094) {
      if (hive.honeyCount >= 2) {
        hive.bees.add(new Bee());
        hive.removeHoney(2);
      }
    } else if (cv != pv && cv < 1) {
      hive.bees.remove(hive.bees.size() - 1);
    }
    println(serialValue);

    currentValue = forceSensor; // adds flowers
    if (currentValue > 800) {
      flowerstoadd++;
    }
  }
}
