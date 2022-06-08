
public class PickupCharge {

    int x, y, charge, radius, time;

    PickupCharge(int x, int y, int charge) {
        this.x = x;
        this.y = y;
        this.charge = charge;
        this.radius = 40;
        this.time = 0;
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

        pushMatrix();
        translate(this.x, this.y);
        rotate(time * PI / 180);

        // draw the charge
        if (this.charge > 0) {
          // proton
          fill(#5386E4);
          stroke(#FFAE03);
          circle(0, 0, this.radius);
          strokeWeight(6);
          stroke(255);
          line(-6, 0, 6, 0);
          line(0, -6, 0, 6);
        }
        else {
          // electron
          fill(#F25757);
          stroke(#FFAE03);
          circle(0, 0, this.radius);
          strokeWeight(6);
          stroke(255);
          line(-6, 0, 6, 0);
        }

        fill(255, 255, 255);        
        strokeWeight(4);
        stroke(0);

        popMatrix();

        time++;
    }
}