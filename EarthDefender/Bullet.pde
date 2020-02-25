class Bullet {
    float x, y;
    float size;
    float vx, vy;
    boolean visible;
    color c;

    /**
     * Basic Constructor for Bullet
     * 
     * @param x x-location of bullet
     * @param y y-location of bullet
     * @param size size of bullet
     */
    Bullet(float x, float y, float size) {
        this.x = x;
        this.y = y;
        this.vx = 0;
        this.vy = random(-3,3);
        this.size = size;
        this.visible = true;
        this.c = 0;
    }

    /**
     * Constructor for Bullet with specified color
     * 
     * @param x x-location of bullet
     * @param y y-location of bullet
     * @param size size of bullet
     * @param vx velocity of bullet in x-direction
     * @param vy velocity of bullet in y-direction
     * @param c color of bullet
     */
    Bullet(float x, float y, float size, float vx, float vy, color c) {
        this(x, y, size);
        this.vx = vx;
        this.vy = vy;
        this.c = c;
    }

    /**
     * Draw bullet if visible and remove if out of bounds
     */
    void draw() {
        if (visible) {
            // Move location according to velocity
            x += vx;
            y += vy;

            // Remove bullet if out of bounds
            if (x < 0 || x > width || y < 0 || y > ground) {
                remove();
            }

            // Draw bullet
            fill(c);
            stroke(0);
            rectMode(CENTER);
            rect(x, y, size*2/3, size*2/3);
        }
    }

    /**
     * Remove Bullet by making it not visible
     */
    void remove() {
        visible = false;
    }

    /**
     * Check for contact between Bullet and Character
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
