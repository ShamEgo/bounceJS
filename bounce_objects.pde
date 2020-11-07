ArrayList<PVector> points;
ArrayList<Object> objects;
boolean penDown = false;
int r, g, b;

void setup()
{
  size(1000, 1000); 
  colorMode(HSB, 360, 100, 100);
  noFill();
  background(0, 0, 0);
  points = new ArrayList<PVector>();
  objects = new ArrayList<Object>();
}

void draw() 
{
  background(0, 0, 0);

  for (int i = 0; i < objects.size(); i++) {
      objects.get(i).update();
  }

  if (mousePressed == true) {
    points.add(new PVector(mouseX, mouseY));
  }
  
  if (mousePressed)
  {
    penDown = true;
    r = frameCount%360;
    g = 100;
    b = 100;
    drawStaticObject(points, r, g, b);

  } else if (!mousePressed && penDown) 
  {
    penDown = false;
    objects.add(new Object(points, r, g, b));
    points = new ArrayList<PVector>();
  }
  
  if (keyPressed == true) {
    objects.clear();
  } else {
    
  }
}

void drawStaticObject(ArrayList<PVector> points, int r, int g, int b) 
{
    stroke(r, g, b);
    beginShape();
    for (PVector p : points)
    {
      vertex(p.x, p.y);
    }
    endShape();
}

class Object {
  ArrayList<PVector> points;
  float xspeed = 1;  // Speed of the shape
  float yspeed = 1;  // Speed of the shape
  
  int xdirection = int(random(5));  // Left or Right
  int ydirection = int(random(5));  // Top to Bottom
  
  int r, g, b;

  Object(ArrayList<PVector> points, int r, int g, int b) {
    this.points = points;
    this.r = r;
    this.g = g;
    this.b = b;
  }

  void update() {
    stroke(r, g, b);
    beginShape();

    for (PVector p : points)
    {
      vertex(p.x, p.y);
      
      // Update the position of the shape
      p.x = p.x + ( xspeed * xdirection );
      p.y = p.y + ( yspeed * ydirection );

      // If the shape exceeds the boundaries of the screen
      // If it does, reverse its direction by multiplying by -1
      if (p.x > width || p.x < 0) {
        xdirection *= -1;
      }
      if (p.y > height || p.y < 0) {
        ydirection *= -1;
      }
    }
    endShape();
  }
}
