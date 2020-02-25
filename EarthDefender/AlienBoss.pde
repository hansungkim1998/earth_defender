class AlienBoss extends Alien {
    float fireAngle;
    float angleChange;

    /**
     * Constructor for Alien Boss
     * 
     * @param x x-location of alien boss
     * @param y y-location of alien boss
     * @param size size of alien boss
     * @param filePath file path to image file
     * @param vx velocity in x-direction
     * @param vy velocity in y-direction
     */
    AlienBoss(float x, float y, float size, String filePath, float vx, float vy) {
        super(x, y, size, filePath, vx, vy);
        this.cooldown = 400;
        this.fireAngle = (float) Math.PI/2;
        this.angleChange = (float) Math.PI/18;
    }

    /**
     * Draw as Alien and draw health bar if alive
     */
    void draw() {
        super.draw();
        if (visible) drawHealthBar();
    }

    /**
     * Fire bullets from Alien Boss if visible and not on cooldown
     * 
     * @return ArrayList containing newly fired bullets
     */
    ArrayList<Bullet> openFireBoss() {
        // Fire bullets if alive and not on cooldown
        if (visible && millis() - timeMarker >= cooldown) {
            // Reset time marker
            timeMarker = millis();

            // Create new list of bullets
            ArrayList<Bullet> bullets = new ArrayList<Bullet>();

            // Calculate speed of bullets in x and y
            float speed = 5;
            float vxB = speed * cos(fireAngle);
            float vyB = speed * sin(fireAngle);

            // Add bullets to the list
            bullets.add(new Bullet(x, y, 10, 0, 5, bulletC));
            bullets.add(new Bullet(x+size/3, y, 10, vxB, vyB, bulletC));
            bullets.add(new Bullet(x-size/3, y, 10, -1*vxB, vyB, bulletC));

            // Change fire angle
            fireAngle += angleChange;
            if (fireAngle < 0) { // Reverse fire angle change if at 0 degrees
                fireAngle = 0;
                angleChange = -1 * angleChange;
            } else if (fireAngle > (float) Math.PI) { // Reverse fire angle change if at 180 degrees
                fireAngle = (float) Math.PI/2;
                angleChange = -1 * angleChange;
            }

            // Play laser sound
            laser.rewind();
            laser.play();

            // Return list of generated bullets
            return bullets;
        }

        // Return an empty list if not alive
        return new ArrayList<Bullet>();
    }
}
