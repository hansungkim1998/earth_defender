class Alien extends Character {
    float cooldown; // In milliseconds
    float timeMarker; // In milliseconds
    boolean visible;

    /**
     * Basic constructor for Alien
     *
     * @param x x-location of alien
     * @param y y-location of alien
     * @param size size of alien
     */
    Alien(float x, float y, float size) {
        super(x, y, size);
        visible = true;
        cooldown = 200;
        timeMarker = millis();
    }

    /**
     * Constructor for Alien with image
     * 
     * @param x x-location of alien
     * @param y y-location of alien
     * @param size size of alien
     * @param filePath file path to image file
     */
    Alien(float x, float y, float size, String filePath) {
        super(x, y, size, filePath, color(255,0,0));
        visible = true;
        cooldown = 200;
        timeMarker = millis();
    }

    /**
     * Constructor for Alien with image and velocities
     * 
     * @param x x-location of alien
     * @param y y-location of alien
     * @param size size of alien
     * @param filePath file path to image file
     * @param vx velocity in x-direction
     * @param vy velocity in y-direction
     */
    Alien(float x, float y, float size, String filePath, float vx, float vy) {
        this(x, y, size, filePath);
        this.vx = vx;
        this.vy = vy;
    }

    /**
     * Draw Alien if visible
     */
    void draw() {
        if (visible) {
            x += vx;
            y += vy;
            drawCharacter();

            // Check for horizontal out of bounds
            if (x < size/2) { // Bounce right if in contact with left edge
                x = size/2;
                vx = -1*vx;
            } else if (x > width-size/2) { // Bounce left if in contact with right edge
                x = width-size/2;
                vx = -1*vx;
            }

            // Check for vertical out of bounds
            if (y > ground - size/2) { // Bounce up if in contact with ground
                y = ground - size/2;
                vy = -1*vy;
            } else if (y < size/2) { // Bounce down if in contact with top edge
                y = size/2;
                vy = -1*vy;
            }
        }
    }

    /**
     * Remove Alien by making it not visible
     */
    void remove() {
        visible = false;
    }

    /**
     * Fire bullets from Alien if visible and not on cooldown
     * 
     * @return newly fired bullet, null otherwise
     */
    Bullet openFire() {
        // Fire bullet if alien is alive and not on cooldown
        if (visible && millis() - timeMarker >= cooldown) {
            // Reset time marker
            timeMarker = millis();

            // Play laser sound
            laser.rewind();
            laser.play();

            // Return newly fired bullet
            return fireBullet(0, 5);
        }
        return null;
    }

    /**
     * Check for contact between Alien and bullets
     * 
     * @param bullets ArrayList of bullets to check for contact
     * @return number of bullets in contact with Alien
     */
    int checkContact(ArrayList<Bullet> bullets) {
        // Check for contact if alien is alive
        if (visible) {
            // Return number of bullets in contact
            return super.checkContact(bullets);
        }
        return 0;
    }

    /**
     * Check for contact between Alien and Character
     * 
     * @param c Character to check for contact
     * @return 1 if in contact, 0 otherwise
     */
    int checkContact(Character c) {
        // Return 1 if in collision with character and remove the alien
        if (visible && sqrt(pow(c.x - x, 2) + pow(c.y - y, 2)) < (size + c.size)/2) {
            remove();
            return 1;
        }
        return 0;
    }
}
