class Explosion {
    PImage img = loadImage("images/explosion.png");
    float x, y;
    float timeMarker;
    float size;
    boolean visible;

    /**
     * Constructor for Explosion
     * 
     * @param x x-location of explosion
     * @param y y-location of explosion
     * @param size size of explosion
     */
    Explosion(float x, float y, float size) {
        this.x = x;
        this.y = y;
        this.size = size;
        this.timeMarker = millis();
        this.visible = true;
    }

    /**
     * Draw explosion for 0.5 seconds, then remove
     */
    void draw() {
        if (visible) {
            if (millis() - timeMarker < 500) { // Draw explosion for 0.5 seconds
                imageMode(CENTER);
                image(img, x, y, size, size);
            } else {
                visible = false;
            }
        }
    }
}
