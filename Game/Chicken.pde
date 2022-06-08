
public class Chicken extends Player {
    
    float angle = 0;
    float angularVelocity = 0;
    PImage chicken;

    Chicken(float x, float y, float initialXVelocity, float initialYVelocity, float charge, float radius, boolean launched) {
        super(x, y, initialXVelocity, initialYVelocity, charge, radius, launched);

        chicken = loadImage("chicken.png");
    }

    public float calculateTorque(int vX, int vY, float[][] x_field, float[][] y_field) {
        if (vX < 0) vX = 0;
        else if (vX > 999) vX = 999;
        if (vY < 0) vY = 0;
        else if (vY > 799) vY = 799;

        float cXVector = vX - x;
        float cYVector = vY - y;
        float fXVector = x_field[vX][vY];
        float fYVector = y_field[vX][vY];

        return cYVector * fXVector - cXVector * fYVector;
    }

    public void updateAngularVelocity(float[][] x_field, float[][] y_field) {
        int xHead = (int) (x + radius * Math.cos(angle));
        int yHead = (int) (y + radius * Math.sin(angle));
        int xTail = (int) (x - radius * Math.cos(angle));
        int yTail = (int) (y - radius * Math.sin(angle));

        float headTorque = calculateTorque(xHead, yHead, x_field, y_field) / 2;
        float tailTorque = calculateTorque(xTail, yTail, x_field, y_field);

        angularVelocity += (headTorque - tailTorque) / radius;
    }

    public void updateAngle() {
        angle += angularVelocity / 100;
    }

    public void draw(float[][] x_field, float[][] y_field, ArrayList<Charge> chargeList, boolean launched, Level currentLevel) {
        // if the player is out of bounds, restart level
        if (this.x < 0 || this.x > 1000 || this.y < 0 || this.y > 800) {
          setup();
          return;
        }

        // once the player is launched from the cannon, start calculating and updating the velocity and position of the player
        if (launched) {
            super.updateVelocity(x_field, y_field);
            super.updatePosition(chargeList);

            updateAngularVelocity(x_field, y_field);
            updateAngle();
        }


        chicken.resize(70, 55);

        pushMatrix();
        translate(x, y);
        rotate(angle - (float) Math.PI / 8);
        if (!launched) {
            rotate(atan2(mouseY - y, mouseX - x));
        }

        // translate(-35 * cos(angle), -27.5 * sin(angle);


        pushMatrix();
        // translate(-35 * sin(angle), -35 * cos(angle));
        image(chicken, 0, 0);
        popMatrix();
        
        // if (this.charge > 0) {
        //   // proton
        //   stroke(#5386E4);
        //   strokeWeight(5);
        //   line(0 - 10, 0, 0 + 10, 0);
        //   line(0, 0 - 10, 0, 0 + 10);
        // }
        // else if (this.charge < 0) {
        //   // electron
        //   stroke(#F25757);
        //   strokeWeight(5);
        //   line(0 - 10, 0, 0 + 10, 0);
        // }

        stroke(255);
        popMatrix();


    }
}