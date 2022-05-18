
public class Cannon {

    int x, y;
    int barrelLength = 50;

    Cannon(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public void draw() {
      // draw body
        fill(100, 100, 100);
        circle(this.x, this.y, 50);

        float angle = atan2(mouseY - this.y, mouseX - this.x);

      // draw barrel
        stroke(150, 150, 150);
        strokeWeight(20);
        line(this.x, this.y, cos(angle) * barrelLength + this.x, sin(angle) * barrelLength + this.y);
        strokeWeight(4);
        stroke(0, 0, 0);

    }
}
