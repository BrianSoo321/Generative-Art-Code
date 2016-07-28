import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
AudioMetaData meta;
BeatDetect beat;
int  r = 200;
float rad = 70;
void setup()
{
  size(1080, 720);
  minim = new Minim(this);
  player = minim.loadFile("The Elder Scrolls V Skyrim Main theme- Dragonborn - HQ Epic Soundtracks.mp3");
  meta = player.getMetaData();
  beat = new BeatDetect();
  player.loop();
  //player.play();
  background(-1);
  noCursor();
}

void draw()
{ 
  float t = map(mouseX, 0, width, 0, 1);
  beat.detect(player.mix);
  fill(random(255), 20);
  noStroke();
  rect(0, 0, width, height);
  translate(width/2, height/2);
  noFill();
  fill(10, -5);
  if (beat.isOnset()) rad = rad*0.9;
  else rad = 70;
  drawcircle();
  stroke(-1, 50);
  int bsize = player.bufferSize();
  for (int i = 0; i < bsize - 1; i+=5)
  {
    float x = (r)*cos(i*2*PI/bsize);
    float y = (r)*sin(i*2*PI/bsize);
    float x2 = (r + player.left.get(i)*100)*cos(i*2*PI/bsize);
    float y2 = (r + player.left.get(i)*100)*sin(i*2*PI/bsize);
    line(x, y, x2, y2);
  }
  beginShape();
  noFill();
  stroke(-10, 10);
  for (int i = 0; i < bsize; i+=5)
  {
    float x2 = (r + player.left.get(i)*200)*cos(i*2*PI/bsize);
    float y2 = (r + player.left.get(i)*100)*sin(i*2*PI/bsize);
    vertex(x2, y2);
    pushStyle();
    stroke(-10);
    strokeWeight(3);
    point(x2, y2);
    popStyle();
  }
  endShape();
 // if (flag)
 // showMeta();
}

float myNoise = 0;
void drawcircle(){
  translate(-width/2, -height/2);
 
  circle(50, 0.001, 40, 100, 200);
  circle(100, 0.002, 80, 10, 200);
  circle(150, 0.003, 120, 100, 10);
  circle(200, 0.004, 160, 10, 200);
  circle(250, 0.005, 200, 200, 80);
  circle(300, 0.006, 245, 100, 90);
  circle(350, 0.006, 100, 150, 10);
  circle(400, 0.007, 190, 100, 200);
  circle(450, 0.008, 10, 255, 90);
  circle(500, 0.007, 50, 90, 200);
  circle(550, 0.006, 255, 140, 100);
  circle(600, 0.005, 110, 10, 110);
  circle(700, 0.004, 180, 180, 20);
  circle(800, 0.003, 50, 50, 200);
  circle(900, 0.002, 170, 70, 255);
  myNoise++;
  translate(width/2, height/2);
}
 
 
void circle(int ellipseSize, float factor, int circleFillA, int circleFillB, int circleFillC) {
 
  float x = noise(myNoise * factor, ellipseSize) * ellipseSize;
 
 
  noStroke();
 
  fill(
  noise(1, myNoise * factor)*circleFillA,
  noise(2, myNoise * factor)*circleFillB,
  noise(3, myNoise * factor)*circleFillC, noise(4, myNoise * factor)*150);
 
  ellipseMode(CENTER);
 
  ellipse(width/2, height/2, x, x);
 
 
}