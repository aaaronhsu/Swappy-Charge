
public class Player {

    // characteristics of a player
    float x, y, charge, radius;
    float xVel, yVel;
    int mass;

    Player(float x, float y, float initialXVelocity, float initialYVelocity, float charge, float radius, boolean launched) {
        this.x = x;
        this.y = y;
        this.xVel = initialXVelocity;
        this.yVel = initialYVelocity;
        this.charge = charge;
        this.radius = radius;
        this.mass = 1;
    }

    public float pythagorean(float x1, float y1, float x2, float y2) {
        return (float) Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
    }

    public void updateVelocity(float[][] x_field, float[][] y_field) {
        // uses electric field to calculate acceleration
        xVel += x_field[(int)x][(int)y] * this.charge;
        yVel += y_field[(int)x][(int)y] * this.charge;
    }

    public void updatePosition(ArrayList<Charge> chargeList) {
        // if the player is touching a charge, restart level
        for (Charge c : chargeList) {
            if (pythagorean(this.x, this.y, c.x, c.y) < (c.radius + this.radius) / 2) {
                this.xVel = 0;
                this.yVel = 0;
                setup();
                return;
            }
        }

        // uses velocity to calculate position
        x += xVel;
        y += yVel;
    }

    public void draw(float[][] x_field, float[][] y_field, ArrayList<Charge> chargeList, boolean launched, Level currentLevel) {
        // if the player is out of bounds, restart level
        if (this.x < 0 || this.x > 1000 || this.y < 0 || this.y > 800) {
          setup();
          return;
        }

        // once the player is launched from the cannon, start calculating and updating the velocity and position of the player
        if (launched) {
            updateVelocity(x_field, y_field);
            updatePosition(chargeList);
        }

        // if the player is out of bounds, restart level
        if (this.x < 0 || this.x > 1000 || this.y < 0 || this.y > 800) {
          setup();
          return;
        }

        // circumference of the player
        stroke(255);
        strokeWeight(2);

        // draw the player
        if (this.charge > 0) {
          // proton
          fill(0, 0, 255);
          circle(this.x, this.y, this.radius);
          strokeWeight(6);
          line(x - 6, y, x + 6, y);
          line(x, y - 6, x, y + 6);
        }
        else if (this.charge < 0) {
          // electron
          fill(255, 0, 0);
          circle(this.x, this.y, this.radius);
          strokeWeight(6);
          line(x - 6, y, x + 6, y);
        }
        else {
            // neutral
            fill(200);
            circle(this.x, this.y, this.radius);
        }

        fill(255, 255, 255);        
        strokeWeight(4);
        stroke(0);
    }
}
