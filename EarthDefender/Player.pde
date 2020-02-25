class Player extends Character {
    PImage img1;
    PImage img2;
    Minim minim;
    AudioPlayer sound1;
    boolean goRight;
    float cooldown; // In milliseconds
    float timeMarker;
    int score;
    int killCount;
    float ay = gravity;
    boolean moveLeft, moveRight, moveUp, moveDown;
    boolean inAir = false;

    /**
     * Basic constructor for Player
     * 
     * @param x x-location of player
     * @param y y-location of player
     * @param size size of player
     */
    Player(float x, float y, float size) {
        super(x, y, size);
        score = 0;
        killCount = 0;
        cooldown = 200;
        timeMarker = millis();
        img1 = loadImage("images/player1.png");
        img2 = loadImage("images/player2.png");
        sound1 = minim.loadFile("audio/laser-gun-19sf.mp3");
    }

    /**
     *
     * @param x x-location of player
     * @param y y-location of player
     * @param size size of player
     * @param filePath file path to image file
     * @param minim sound player
     */
    Player(float x, float y, float size, String filePath, Minim minim) {
        super(x, y, size, filePath, color(64,224,208));
        score = 0;
        killCount = 0;
        cooldown = 200;
        timeMarker = millis();
        img1 = loadImage("images/player1.png");
        img2 = loadImage("images/player2.png");
        this.minim = minim;
        sound1 = minim.loadFile("audio/laser.mp3");
    }

    /**
     * Move player, prevent going out of bounds, draw player, and draw health
     * bar
     */
    void draw() {
        vx = 0;
        if(moveRight) vx += 10; // Move right if right key is pressed
        if(moveLeft) vx -= 10; // Move left if left key is pressed
        x += vx;

        if (moveUp && !inAir) { // Jump if not in air and up key is pressed
            vy = -20.0;
            inAir = true;
        }
        y += vy;

        vy += ay; // Acceleration in y

        if (y >= ground) { // Prevent character from moving below the ground
            y = ground;
            vy = 0.0;
            inAir = false;
        }

        // Block character from moving off screen
        if (x < 0) {
            x = 0;
        } else if (x > width) {
            x = width;
        }

        if (moveRight) {
            imageMode(CENTER);
            image(img1, x, y, size, size);
        } else {
            imageMode(CENTER);
            image(img2, x, y, size, size);
        }
        drawHealthBar();
    }

    /**
     * Fire bullet if player fires and not on cooldown
     * 
     * @return newly fired bullet
     */
    Bullet fire() {
        if (keyPressed && key == ' ' && millis() - timeMarker >= cooldown) {
            timeMarker = millis();
            sound1.rewind();
            sound1.play();
            return fireBullet(0,-10);
        }
        return null;
    }

    /**
     * Check contact between character and items
     * 
     * @param items ArrayList of items to check contact
     * @return number of items in contact with character
     */
    int checkItems(ArrayList<Item> items) {
        int count = 0;
        for (Item i : items) {
            count += i.checkContact(this);
        }
        return count;
    }
}
