
public class Player {

    float x, y, charge, radius;
    float xVel, yVel;

    Player(float x, float y, float initialXVelocity, float initialYVelocity, float charge, float radius, boolean launched) {
        this.x = x;
        this.y = y;
        this.xVel = initialXVelocity;
        this.yVel = initialYVelocity;
        this.charge = charge;
        this.radius = radius;
    }

    public float pythagorean(float x1, float y1, float x2, float y2) {
        return (float) Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
    }

    public void updateVelocity(float[][] x_field, float[][] y_field) {
        xVel += x_field[(int)x][(int)y] * this.charge;
        yVel += y_field[(int)x][(int)y] * this.charge;
    }

    public void updatePosition(ArrayList<Charge> chargeList) {

        for (Charge c : chargeList) {
            if (pythagorean(this.x, this.y, c.x, c.y) < (c.radius + this.radius) / 2) {
                this.xVel = 0;
                this.yVel = 0;
            }
        }

        x += xVel;
        y += yVel;
    }

    public void draw(float[][] x_field, float[][] y_field, ArrayList<Charge> chargeList, boolean launched) {
        if (this.x < 0 || this.x > 1600 || this.y < 0 || this.y > 900) {
            return;
        }

        if (launched) {
            updateVelocity(x_field, y_field);
            updatePosition(chargeList);
        }

        if (this.x < 0 || this.x > 1600 || this.y < 0 || this.y > 900) {
            return;
        }

        fill(255, 0, 0);
        circle(this.x, this.y, this.radius);
        fill(255, 255, 255);
    }
}
