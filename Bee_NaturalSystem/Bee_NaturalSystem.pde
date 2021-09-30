color bkgColor;
BeeHive hive;
ArrayList<Sunflower> flowers; 
boolean added;

void setup() { //set up the screen
  size(800, 800);


  added = false;
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
}//end of draw

void mousePressed() {
  hive.bees.add(new Bee()); // new bee gets added

}

void keyReleased() {
  if (key == ' ') {
    flowers.add(new Sunflower()); // new flower appears
  }
}
