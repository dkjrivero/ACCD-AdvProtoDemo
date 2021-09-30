class Bee {
  PVector position;
  PVector vel;
  float speed;
  boolean busy;
  Sunflower target;
  float radius;
  color bColor;
// set up bee  
  Bee(float _x, float _y) {
    position = new PVector(_x, _y);
    vel = new PVector(random(-3, 3), random(-3, 3));

    radius = 30;
    bColor = color(30, 100, 100);

  }
//bee adds flower circle and releases at beehive  
  Bee() {
    this.position = new PVector(50, 50);
    this.vel = new PVector(0, 0);
    this.speed = 5;
    this.busy = false;
    
    this.radius = 10;
    this.bColor = color(252, 226, 5);
  }
// caculates distance to flower  
  double distanceToFlower(Sunflower flower) {
    return Math.sqrt((this.position.x - flower.position.x) * (this.position.x - flower.position.x) + (this.position.y - flower.position.y) * (this.position.y - flower.position.y));
  }

void move(ArrayList<Sunflower> flowers, BeeHive hive) { // knows ab hive n flower
    //vertical border
    if (position.x + radius >= width || position.x - radius <= 0) {
      vel.x = vel.x*-1;
    }
    //horizontal border
    if (position.y + radius >= height || position.y - radius <= 0) {
      vel.y = vel.y*-1;
    }

    position.add(vel);
    
    if (flowers.size() != 0 && !busy) { // if bee is not busy check distance to flower, go to clossest flower set as new target
      print("seeking\n");
      if (target == null) {
        Sunflower closest = flowers.get(0);
        double closestDist = Double.MAX_VALUE;
        
        
        for (Sunflower flower : flowers) { // checks distance to each finds closest 
           double currDist = this.distanceToFlower(flower);
           if (currDist <= closestDist && !hive.targets.containsKey(flower)) {
             closest = flower;
             closestDist = currDist;
           }
        }
        
        
        target = closest; // closest is target, attack
        hive.targets.put(target, this);
        print("got target (" + target.position.x + ", " + target.position.y + ")\n");
        
        
      }
      this.vel = PVector.sub(target.position, this.position); // normalize speed heading to target
      this.vel.normalize();
      this.vel.mult(this.speed);
      print("going towards target (" + target.position.x + ", " + target.position.y + ") with velocity (" + vel.x + ", " + vel.y + "\n");
      
      
      // 5 pixels normalize speed after getting target
      if (this.position.x >= target.position.x - 5 && this.position.x <= target.position.x + 5 && this.position.y >= target.position.y - 5 && this.position.y <= target.position.y + 5) {
        this.busy = true;
        this.vel = PVector.sub(new PVector(50, 50), this.position);
        this.vel.normalize();
        this.vel.mult(this.speed);
        print("gotten to target\n");
      }
    }
    
    if (target != null && busy) { // head back to hive, removes target flower, remove hive target
      print("heading back to hive\n");
      if (this.position.x >= 50 - 5 && this.position.x <= 50 + 5 && this.position.y >= 50 - 5 && this.position.y <= 50 + 5) {
        this.busy = false;
        flowers.remove(target);
        hive.targets.remove(target);
        
        // add honey to hive, stop speed
        target = null;
        this.vel = new PVector(0, 0);
        hive.addHoney();
        print("got to hive\n");
      }
    }
  }

  void display() { // drawing bee
    if (target != null && busy) {
      fill(0, 0, 0);
      ellipse(position.x + radius, position.y +radius, radius*2, radius*2);
      fill(bColor);
      noStroke();
      ellipse(position.x, position.y, radius*2, radius*2);
    } else {
      fill(0, 0, 0);
      noStroke();
      ellipse(position.x, position.y, radius*2, radius*2);
      fill(bColor);
      ellipse(position.x + radius, position.y +radius, radius*2, radius*2);
    }
  }
}
