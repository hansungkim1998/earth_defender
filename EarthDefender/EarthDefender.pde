import ddf.minim.*;

Minim minim;
AudioPlayer introMusic;
AudioPlayer laser;
AudioPlayer boom;
AudioPlayer bigBoom;

PFont gameFont;
PImage introBack;

GameState game;
Player player;

ArrayList<Alien> aliens;
ArrayList<Bullet> enemyBullets;
ArrayList<Bullet> friendlyBullets;
ArrayList<Item> items;
ArrayList<Explosion> explosions;
AlienBoss boss;

int timer;
int currTime;
float ground;
float gravity;
int count;

/**
 * Load and set up necessary components for game
 */
void setup() {
  size(1000, 750);
  
  // Import font and initialize game
  gameFont = createFont("font/Retro Gaming.ttf", 50);
  textFont(gameFont);
  game = new GameState();
  game.stage = Stage.INTRO;
  gravity = 1.0;
  ground = height*9/10;
  
  // Import game sounds
  introBack = loadImage("images/EarthBackground.png");
  minim = new Minim(this);
  introMusic = minim.loadFile("audio/intro.wav");
  laser = minim.loadFile("audio/laser2.mp3");
  boom = minim.loadFile("audio/boom.mp3");
  bigBoom = minim.loadFile("audio/bigboom.mp3");
}

/**
 * Draw a frame according to the current stage of game
 */
void draw() {
  switch(game.stage) {
    case INTRO:
      // Background Image
      imageMode(CENTER);
      image(introBack, width/2, height/2, width, height);
      
      // Display game title
      fill(255);
      textAlign(CENTER);
      textSize(60);
      text("EARTH DEFENDER", width/2, height/2+10);
      
      // Blink press enter to play
      if ((count / 20) % 2 == 0) {
        textSize(30);
        text("Press ENTER to Play", width/2, height/2+50);
      }
      count++;
      
      // Play intro music
      introMusic.play();
    
      // Start game if ENTER key is pressed
      if (keyCode == ENTER) {
        introMusic.pause();
        game.stage = Stage.START;
      }
      break;
      
    case START: // Initialize Stage 1
      game.stage = Stage.STAGE1;
      
      // Initialize player
      player = new Player(width/2, ground, 40, "images/player1.png", minim); 
      
      // Initialize enemies
      aliens = new ArrayList<Alien>();
      aliens.add(new Alien(width/3, height/5, 40, "images/alien.png", 1, 0));
      aliens.add(new Alien(width*2/3, height/5, 40, "images/alien.png", -1, 0));
      boss = null;
      
      // Initialize empty list of bullets
      enemyBullets = new ArrayList<Bullet>();
      friendlyBullets = new ArrayList<Bullet>();
      
      // Initialize empty list of items
      items = new ArrayList<Item>();
      
      // Initialize items
      int itemCount = (int) random(1, 2);
      for (int i = 0; i <= itemCount; i++) {
        items.add(new Item(random(width), random(height*3/4, ground), 30, (int) random(-1, 2), (int) random(-1, 2), (int) random(1, 4)));
      }
      
      // Initialize explosions
      explosions = new ArrayList<Explosion>();
      
      // Initialize timer
      timer = 20;
      currTime = second();
      break;
      
    case STAGE1:
      drawStage();
      break;
      
    case STAGE2S: // Initialize Stage 2
      game.stage = Stage.STAGE2;
      
      // Reset enemies
      aliens = new ArrayList<Alien>();
      aliens.add(new Alien(width/3, height/5, 40, "images/alien.png", 1, 0));
      aliens.add(new Alien(width*2/3, height/5, 40, "images/alien.png", -1, 0));
      aliens.add(new Alien(width/5, height/3, 40, "images/alien.png", 0, 0));
      aliens.add(new Alien(width*4/5, height/3, 40, "images/alien.png", 0, 0));
      aliens.add(new Alien(width*4/5, 0, 40, "images/alien.png", 1, -2));
      aliens.add(new Alien(width/5, 0, 40, "images/alien.png", -1, -2));
      boss = null;
      
      // Reset empty list of bullets
      enemyBullets = new ArrayList<Bullet>();
      friendlyBullets = new ArrayList<Bullet>();
      
      // Reset empty list of items
      items = new ArrayList<Item>();
      
      // Reset items
      itemCount = (int) random(1, 4);
      for (int i = 0; i <= itemCount; i++) {
        items.add(new Item(random(width), random(height*3/4, ground), 30, (int) random(-1, 2), (int) random(-1, 2), (int) random(1, 4)));
      }
      
      // Reset explosions
      explosions = new ArrayList<Explosion>();
      
      // Reset timer
      timer = 20;
      currTime = second();
      
      break;
    
    case STAGE2:
      drawStage();
      break;
      
    case STAGE3S: // Initialize Stage 3
      game.stage = Stage.STAGE3;
      
      // Reset enemies
      aliens = new ArrayList<Alien>();
      aliens.add(new Alien(width/3, height/5, 40, "images/alien.png", 1, 0));
      aliens.add(new Alien(width/3, height/5, 40, "images/alien.png", -1, 0));
      aliens.add(new Alien(width*2/3, height/5, 40, "images/alien.png", 1, 0));
      aliens.add(new Alien(width*2/3, height/5, 40, "images/alien.png", -1, 0));
      boss = new AlienBoss(width/2, 1, 100, "images/alien.png", 0, 0);
      
      // Reset empty list of bullets
      enemyBullets = new ArrayList<Bullet>();
      friendlyBullets = new ArrayList<Bullet>();
      
      // Reset empty list of items
      items = new ArrayList<Item>();
      
      // Reset items
      itemCount = (int) random(4, 7);
      for (int i = 0; i <= itemCount; i++) {
        items.add(new Item(random(width), random(height*3/4, ground), 30, (int) random(-1, 2), (int) random(-1, 2), (int) random(1, 4)));
      }
      
      // Reset explosions
      explosions = new ArrayList<Explosion>();
      
      // Reset timer
      timer = 20;
      currTime = second();
      
      break;
      
    case STAGE3:
      drawStage();
      break;
      
    case WIN:
      imageMode(CENTER);
      image(introBack, width/2, height/2, width, height);
      
      // Display "You Win" message and score
      fill(255);
      textAlign(CENTER);
      textSize(50);
      text("You Win!", width/2, height/2);
      textSize(30);
      text("Score: " + player.score*100, width/2, height/2+50);
      text("Press ENTER to Play Again", width/2, height/2+90);
      
      // Restart game when ENTER key is pressed
      if (keyCode == ENTER) {
        game.stage = Stage.START;
      }
      break;
      
    case GAMEOVER:
      imageMode(CENTER);
      image(introBack, width/2, height/2, width, height);
      
      // Display "Game Over" message
      fill(255);
      textAlign(CENTER);
      textSize(50);
      text("Game Over", width/2, height/2);
      textSize(30);
      text("Press ENTER to Play Again", width/2, height/2+50);
      
      // Restart game when ENTER key is pressed
      if (keyCode == ENTER) {
        game.stage = Stage.START;
      }
      break;
  }
}

/**
 * Draw background and ground
 */
void drawBackground() {
  // Draw sky
  background(color(49,14,49));
  
  // Draw ground
  fill(color(178,31,103));
  rectMode(CORNER);
  rect(0,ground+player.size/2,width,height);
}

/**
 * Draw all components of the stage
 */
void drawStage() {
  // Game over if no health left or no time left
  if (player.health <= 0 || timer < 0) {
    game.stage = Stage.GAMEOVER;
    delay(500);
    return; // Exits the method
  }
  
  // Move to next stage if kill all enemies
  if ((boss == null || !boss.visible) && player.killCount >= aliens.size()) {
    player.score += timer;
    player.killCount = 0;
    
    if (game.stage == Stage.STAGE1) {
      game.stage = Stage.STAGE2S;
    } else if (game.stage == Stage.STAGE2) {
      game.stage = Stage.STAGE3S;
    } else if (game.stage == Stage.STAGE3) {
      game.stage = Stage.WIN;
    }
    
    delay(500);
    return; // Exits the method
  }

  drawBackground();
  
  // Update health based on hits
  player.health -= 10 * player.checkContact(enemyBullets);
  
  // For each enemy: check contact, fire bullet, and draw enemy
  for (Alien alien : aliens) {
    // Remove if enemy gets shot
    int scoreInc = alien.checkContact(friendlyBullets);
    if (scoreInc > 0) {
      // Adjust score and kill count
      player.score += scoreInc;
      player.killCount++;
      
      // Draw explosion and play explosion sound
      explosions.add(new Explosion(alien.x, alien.y, alien.size));
      boom.rewind();
      boom.play();
      alien.remove();
    }
    
    // Check collision with player
    int collision = alien.checkContact(player);
    if (collision > 0) {
      player.health -= 50 * collision;
      player.killCount++;
    }
    
    // Alien fires bullet
    Bullet bullet = alien.openFire();
    if (bullet != null) {
      enemyBullets.add(bullet);
    }
    
    // Draw the alien
    alien.draw();
  }
  
  // Alien Boss check contact, fire bullets, and draw boss
  if (boss != null && boss.visible) {
    int bossHit = boss.checkContact(friendlyBullets);
    player.score += bossHit;
    boss.health -= 5 * bossHit;
    
    // Alien Boss death
    if (boss.health <= 0) {
      boss.remove();
      
      // Play explosion sound
      bigBoom.rewind();
      bigBoom.play();
      
      // Generate 3 new enemies upon boss death
      aliens.add(new Alien(width/2+boss.size/2, 1, 40, "images/alien.png", -2, 2));
      aliens.add(new Alien(width/2-boss.size/2, 1, 40, "images/alien.png", 2, 2));
      aliens.add(new Alien(width/2, 1, 40, "images/alien.png", 0, 3));
    }
    
    // Alien Boss fire bullets
    for (Bullet bullet : boss.openFireBoss()) {
      enemyBullets.add(bullet);
    }
    
    // Draw the Alien Boss
    boss.draw();
  }
  
  // Draw all enemy bullets
  for (Bullet bullet : enemyBullets) {
    bullet.draw();
  }
  
  // Items check contact, draw items, apply buffs
  for (Item item : items) {
    // Apply item effect based on item code
    int itemCode = item.checkContact(player);
    if (itemCode == 1) { // Health potion
      player.health += 50;
      if (player.health > 100) {
        player.health = 100;
      }
    } else if (itemCode == 2) { // Attack speed buff
      player.cooldown = player.cooldown / 2;
    } else if (itemCode == 3) { // Extra time
      timer += 3;
    }
    
    // Draw the item
    item.draw();
  }
  
  // Draw all friendly bullets
  for (Bullet bullet : friendlyBullets) {
    bullet.draw();
  }
  
  // Draw all explosions
  for (Explosion explosion : explosions) {
    explosion.draw();
  }
  
  // Player fire bullets
  Bullet bullet = player.fire();
  if (bullet != null) {
    friendlyBullets.add(bullet);
  }
  player.draw();
  
  // Display time and score
  if (second() != currTime) { // Decrement timer every second
    timer--;
    currTime = second(); // Mark current time
  }
  
  // Display game info
  fill(0);
  textSize(30);
  textAlign(LEFT, TOP);
  int s = 0;
  if (game.stage == Stage.STAGE1) s = 1;
  else if (game.stage == Stage.STAGE2) s = 2;
  else if (game.stage == Stage.STAGE3) s = 3;
  text("Stage " + s, 30, height - 40); // Display stage
  text("Score: " + player.score*100, width*4/9, height - 40); // Display score
  text("Timer: " + timer, width*5/6, height - 40); // Display timer
      
}

void keyPressed() {
  if (keyCode == RIGHT) {
    player.moveRight = true;
  }
  if (keyCode == LEFT) {
    player.moveLeft = true;
  }
  if (keyCode == UP) {
    player.moveUp = true;
  }
  if (keyCode == DOWN) {
    player.moveDown = true;
  }
}

void keyReleased() {
  if (keyCode == RIGHT) {
    player.moveRight = false;
  }
  if (keyCode == LEFT) {
    player.moveLeft = false;
  }
  if (keyCode == UP) {
    player.moveUp = false;
  }
  if (keyCode == DOWN) {
    player.moveDown = false;
  }
}
