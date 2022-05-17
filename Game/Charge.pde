public float K = 1/(4 * PI * 8.85 * 10e-6);

public class Charge {

  int x, y, charge, radius;

  float[][] xField = new float[1600][900];
  float[][] yField = new float[1600][900];

  Charge(int x, int y, int initialCharge, int radius) {
    this.x = x;
    this.y = y;
    this.charge = initialCharge;
    this.radius = radius;

    generateElectricField();
  }

  public void generateElectricField() {
    for (int i = 0; i < 1600; i++) {
      for (int j = 0; j < 900; j++) {
        float force = (K * this.charge) / (float) Math.pow(pythagorean(i, j, this.x, this.y), 2);
        float angle = atan2((j - this.y), (i - this.x));
        xField[i][j] = force * cos(angle);
        yField[i][j] = force * sin(angle);
      }
    }
  }

  public float pythagorean(int x1, int y1, int x2, int y2) {
    return (float) Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
  }

  public void draw() {
      if (this.charge > 0) {
        fill(0, 0, 255);
        stroke(0, 0, 100);
      } else {
        fill(255, 0, 0);
        stroke(100, 0, 0);
      }

      circle(this.x, this.y, radius);

      stroke(255);
      strokeWeight(10);
      if (this.charge > 0) {
        line(x - 10, y, x + 10, y);
        line(x, y - 10, x, y + 10);
      } else {
        line(x - 10, y, x + 10, y);
      }
      stroke(0);
      strokeWeight(4);

      fill(255, 255, 255);
  }
}
