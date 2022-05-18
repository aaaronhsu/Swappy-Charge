public float K = 1/(4 * PI * 8.85 * 10e-6);

public class Charge {

  // characteristics of the charge
  int x, y, charge, radius;
  boolean isConstant;

  // electric field the charge creates in unit vector notation
  float[][] xField = new float[1600][900];
  float[][] yField = new float[1600][900];

  Charge(int x, int y, int initialCharge, int radius, boolean isConstant) {
    this.x = x;
    this.y = y;
    this.charge = initialCharge;
    this.radius = (int) (radius * ((float) abs(initialCharge) / 10)) + 1;
    this.isConstant = isConstant;

    generateElectricField();
  }

  public void generateElectricField() {
    // uses electric field formula to calculate electric field at each coordinate
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

  public void swapCharge() {
    if (this.isConstant) return;
    this.charge *= -1;
  }

  public void draw() {

    // sets up colors and stroke for the charge
      if (this.charge > 0) {
        fill(0, 0, 255);
        stroke(0, 0, 100);
      } else {
        fill(255, 0, 0);
        stroke(100, 0, 0);
      }

      if (this.isConstant) {
        fill(100, 100, 100);
        stroke(100, 100, 100);
      }

    // draws the charge
      circle(this.x, this.y, radius);

    // draws the markings on the charge

      stroke(255);
      strokeWeight(abs(this.charge));

      if (this.charge > 0) {
        line(x - abs(charge), y, x + abs(charge), y);
        line(x, y - abs(charge), x, y + abs(charge));
      } else {
        line(x - abs(charge), y, x + abs(charge), y);
      }
      stroke(0);
      strokeWeight(4);

      fill(255, 255, 255);
  }
}
