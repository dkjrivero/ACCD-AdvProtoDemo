class BeeHive {
  ArrayList<Bee> bees;
  int honeyCount, beeHoneyThreshold;
  color hiveColor;
  float size;
  PVector position;
  HashMap<Sunflower, Bee> targets;
//setup beehive  
  BeeHive() {
    this.position = new PVector(50, 50);
    this.size = random(3, 8);
    this.hiveColor = color(155, 103, 60);
    this.honeyCount = 0;
    this.beeHoneyThreshold = int(random(5, 10)); // does not add 
    this.bees = new ArrayList<Bee>();
    this.bees.add(new Bee());
    this.targets = new HashMap<Sunflower, Bee>(); //for each sunflower theres a bee map
  }
// adds honey when bee brings flower back  
  void addHoney() {
    this.honeyCount++;
      this.size += 0.5;
  }
//draws beehive
  void display() {
    fill(hiveColor);
    noStroke();
    ellipse(position.x, position.y, size*10, size*10);
  }
}
