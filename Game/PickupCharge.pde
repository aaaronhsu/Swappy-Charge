
public class PickupCharge {

    int x, y, charge, radius;

    PickupCharge(int x, int y, int charge) {
        this.x = x;
        this.y = y;
        this.charge = charge;
        this.radius = 40;
    }

    public float pythagorean(float x1, float y1, float x2, float y2) {
        return (float) Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
    }

    public boolean isTouchingPlayer(Player player) {
        return pythagorean(x, y, player.x, player.y) <= radius + player.radius;
    }

    public void draw() {
        // circumference of the charge
        stroke(255, 255, 0);
        strokeWeight(2);

        // draw the charge
        if (this.charge > 0) {
          // proton
          fill(#5386E4);
          stroke(#5386F4);
          circle(this.x, this.y, this.radius);
          strokeWeight(6);
          stroke(255);
          line(x - 6, y, x + 6, y);
          line(x, y - 6, x, y + 6);
        }
        else {
          // electron
          fill(#F25757);
          stroke(#FF5757);
          circle(this.x, this.y, this.radius);
          strokeWeight(6);
          stroke(255);
          line(x - 6, y, x + 6, y);
        }

        fill(255, 255, 255);        
        strokeWeight(4);
        stroke(0);
    }
}