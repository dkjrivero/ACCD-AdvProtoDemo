class Sunflower {
  color flowerColor;
  int honeyCount;
  PVector position;
  float radius;
  
//setup sunflower  
  Sunflower() {
    this.flowerColor = color(155, 103, 60);
    this.honeyCount = int(random(1, 5));
    this.position = new PVector(random(100, 700), random(100, 700));
    
    radius = 10;

  }
// draws sunflower  
  void display() {
    fill(246, 169, 15);
    ellipse(position.x + honeyCount * 10 / 2, position.y + honeyCount * 10 / 2, honeyCount*10, honeyCount*10);
    ellipse(position.x - honeyCount * 10 / 2, position.y - honeyCount * 10 / 2, honeyCount*10, honeyCount*10);
    ellipse(position.x + honeyCount * 10 / 2, position.y - honeyCount * 10 / 2, honeyCount*10, honeyCount*10);
    ellipse(position.x - honeyCount * 10 / 2, position.y + honeyCount * 10 / 2, honeyCount*10, honeyCount*10);
    fill(flowerColor);
    noStroke();
    ellipse(position.x, position.y, honeyCount*10, honeyCount*10);
  }
}
