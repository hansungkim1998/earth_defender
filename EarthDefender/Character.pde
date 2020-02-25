class Character {
    PImage img;
    float x, y;
    float size;
    float vx, vy;
    float health;
    float maxHealth;
    color bulletC;

    /**
     * Basic constructor for Character
     *
     * @param x x-location of character
     * @param y y-location of character
     * @param size size of character
     */
    Character(float x, float y, float size) {
        this.x = x;
        this.y = y;
        this.size = size;
        this.vx = 0;
        this.vy = 0;
        this.health = 100;
        this.maxHealth = 100;
        this.bulletC = 0;
    }

    /**
     * Constructor for Character with image and bullet color
     *
     * @param x x-location of character
     * @param y y-location of character
     * @param size size of character
     * @param filePath file path to image file
     * @param bulletC color of bullets
     */
    Character(float x, float y, float size, String filePath, color bulletC) {
        this(x, y, size);
        this.img = loadImage(filePath);
        this.bulletC = bulletC;
    }

    /**
     * Draw character with provided image if visible
     */
    void drawCharacter() {
        imageMode(CENTER);
        image(img, x, y, size, size);
    }

    /**
     * Draw health bar
     */
    void drawHealthBar() {
        // Create boundary box for health bar
        rectMode(CENTER);
        stroke(0);
        fill(0);
        rect(x, y+size*3/4, size*1.5, 5);

        // Display amount of health left
        if (health > 0) {
            if (health >= maxHealth*0.50) { // Green health bar if above 50
                fill(color(0,128,0));
            } else if (health >= maxHealth*0.25) { // Yellow health bar if above 25
                fill(color(255,255,0));
            } else {
                fill(color(255,0,0)); // Red health bar otherwise
            }

            // Fill health bar
            rectMode(CORNER);
            rect(x-size*3/4, y+size*3/4-5/2, size*1.5*health/maxHealth, 5);
        }
    }

    /**
     * Fire bullet with specified velocities
     * 
     * @param vxB velocity of bullet in x-direction
     * @param vyB velocity of bullet in y-direction
     * @return
     */
    Bullet fireBullet(float vxB, float vyB) {
        return new Bullet(this.x, this.y, 10, vxB, vyB, bulletC);
    }

    /**
     * Check for contact between Character and bullets
     *
     * @param bullets ArrayList of bullets to check for contact
     * @return number of bullets in contact with Alien
     */
    int checkContact(ArrayList<Bullet> bullets) {
        int count = 0;

        // Check each bullet for contact with this character
        for (Bullet b : bullets) {
            count += b.checkContact(this);
        }

        // Return number of bullets in contact with this character
        return count;
    }
}
