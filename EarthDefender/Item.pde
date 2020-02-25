class Item extends Bullet {
    PImage img;
    int itemCode;

    /**
     * Constructor for Item
     *
     * @param x x-location of item
     * @param y y-location of item
     * @param size size of item
     * @param vx velocity in x-direction
     * @param vy velocity in y-direction
     * @param itemCode code determining type of item
     */
    Item(float x, float y, float size, float vx, float vy, int itemCode) {
        super(x, y, size, vx, vy, 0);
        this.itemCode = itemCode;
        if (itemCode == 1) {
            this.img = loadImage("images/potion.png");
        } else if (itemCode == 2) {
            this.img = loadImage("images/ASbuff.png");
        } else if (itemCode == 3) {
            this.img = loadImage("images/extratime.png");
        }
    }

    /**
     * Draw item if visible and bounce at boundaries
     */
    void draw() {
        if (visible) {
            x += vx;
            y += vy;
            imageMode(CENTER);
            image(img, x, y, size, size);

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
     * Check contact between item anc character
     * 
     * @param c Character to check for contact
     * @return itemCode if in contact, 0 otherwise
     */
    int checkContact(Character c) {
        if (super.checkContact(c) != 0) {
            return itemCode;
        }
        return 0;
    }
}
