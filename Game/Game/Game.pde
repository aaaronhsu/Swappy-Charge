
public ArrayList<Charge> chargeList = new ArrayList<Charge>();
public float[][] xField = new float[1600][900];
public float[][] yField = new float[1600][900];

public float[][] xFieldRev = new float[1600][900];
public float[][] yFieldRev = new float[1600][900];

public boolean reversedField = false;
public boolean launched = false;

public int xStartPosition = 50;
public int yStartPosition = 450;

public Player player = new Player(xStartPosition, yStartPosition, 0, 0, -1, 30, launched);
public Cannon cannon = new Cannon(xStartPosition, yStartPosition);


public void setup() {
  size(1600, 900);

//   for (int i = 0; i < 5; i++) {
//       chargeList.add(new Charge(i, i, i, 1));
//   }

    chargeList.add(new Charge(800, 600, 10, 60));
    chargeList.add(new Charge(700, 300, -4, 60));
  sumElectricField();
}

public void draw() {
  background(0, 0, 0);
  
//   text(xField[mouseX][mouseY] * 1000, 100, 100);
//   text(yField[mouseX][mouseY] * 1000, 500, 100);

  for (Charge c : chargeList) {
      c.draw();
  }

  cannon.draw();

  if (!reversedField) {
        player.draw(xField, yField, chargeList, launched);
    }
    else {
        player.draw(xFieldRev, yFieldRev, chargeList, launched);
    }
}

public void sumElectricField() {
    xField = new float[1600][900];
    yField = new float[1600][900];

    xFieldRev = new float[1600][900];
    yFieldRev = new float[1600][900];

    for (Charge c : chargeList) {
        for (int i = 0; i < 1600; i++) {
            for (int j = 0; j < 900; j++) {
                xField[i][j] += c.xField[i][j];
                yField[i][j] += c.yField[i][j];

                xFieldRev[i][j] -= c.xField[i][j];
                yFieldRev[i][j] -= c.yField[i][j];
            }
        }
    }
}

public void keyPressed() {
    if (key == 'c') {
        reversedField = !reversedField;
        for (Charge c : chargeList) {
            c.charge *= -1;
        }
    }

    if (key == 'r') {
        launched = false;
        player = new Player(xStartPosition, yStartPosition, 0, 0, -1, 30, launched);
    }

    if (key == 'l') {
        launched = true;

        float angle = atan2(cannon.y - mouseY, cannon.x - mouseX);

        float x = cos(angle) * 5;
        float y = sin(angle) * 5;

        player.xVel = -x;
        player.yVel = -y;
    }
}