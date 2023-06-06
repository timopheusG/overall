int birdY;
float birdYSpeed;
int score;
int status;
float gravity = 1.2;
PImage bg;
PImage bird;
int best;

int pipeX;
int pipeGap;
int pipeSpeed;
int pipeWidth;
int pipeHeight;
boolean scored;

void setup() {
  size(400, 600);
  reset();
  bg = loadImage("background.jpg");
  
}

void draw() {
 background(bg);
  
 // status 1 is the play state, status 0 is the intro screen, status 2 is the game over state
 if (status == 0) {
    drawIntro();
 }
  else if (status == 1) {
    updateBird();
    addScore();
    updatePipes();
    checkCollision();
    drawBird();
    drawPipes();
    drawScore();
  } 
   else if (status == 2) {
    drawGameOver();
  }
}
void reset() {
  birdY = height/2;
  birdYSpeed = 0;
  score = 0;
  status = 0;
  pipeX = width;
  pipeGap = 150;
  pipeSpeed = 6;
  pipeWidth = 80;
  pipeHeight = height - pipeGap;
  scored = false;
}

void keyPressed() {
  if (keyCode == UP && status == 1) {
    birdYSpeed = -7;
  } else if (key == 'a' && status == 0) {
    status = 1;
  } else if (key == 'a' && status == 2) {
    reset();
  }
}

void drawBird() {
//  fill(255, 255, 0);
  bird = loadImage("bird.png");
  image(bird, 50, birdY);
//  ellipse(50, birdY, 32, 32);
}

void drawPipes() {
  fill(55, 182, 0);
  rect(pipeX, 0, pipeWidth, pipeHeight);
  rect(pipeX, pipeHeight + pipeGap, pipeWidth, height - pipeHeight - pipeGap);
}
void updateBird() {
  birdYSpeed += 0.3 * gravity;
  birdY += birdYSpeed;
  
  if (birdY > height || birdY < 0) {
    status = 2;
  }
}

void updatePipes() {
  pipeX -= pipeSpeed;
  
  if (pipeX < -pipeWidth) {
    pipeX = width;
    pipeHeight = int(random(100, height - 100));
    scored = false;
  }
  
//  if (get(
  
//  if (pipeX < width/2 && !scored) {
//    score++;
//    scored = true;
//  }
}

void checkCollision() {
  if (birdY > height || birdY < 0) {
    status = 2;
    if (score > best){
    best = score;
    }
  }  
  if (pipeX < 120){
    if(birdY < pipeHeight -5 || birdY > pipeHeight + pipeGap -50){
      status = 2;
      if (score > best){
      best = score;

      }
    }
  }
} 
void addScore() {
  if (pipeX < 50  && pipeX > 50 - pipeSpeed){
//    if(birdY < pipeHeight - 10 || birdY > pipeHeight + pipeGap + 10){
  print("hello");
      scored = true;
      score++;
      scored = false;
      if (score > best) {
        best++;
      }
//    }
  }
}






void drawScore() {
  fill(255);
  textSize(20);
  textAlign(CENTER);
  text(score, width/2, 60);
  text("Best:" + best, width /2, 100); 
}

void drawIntro() {
  fill(255);
  textSize(30);
  textAlign(CENTER);
  text("Flappy Bird", width/2, height/2 - 50);
  textSize(15);
  text("Press 'a' to Play", width/2, height/2);
}

void drawGameOver() {
  fill(255);
  textSize(30);
  textAlign(CENTER);
  text("Game Over", width/2, height/2 - 50);
  textSize(15);
  text("Press 'a' to Restart", width/2, height/2);
}
