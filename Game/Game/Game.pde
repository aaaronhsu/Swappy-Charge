
public ArrayList<Charge> chargeList = new ArrayList<Charge>();

public float[][] xField = new float[1600][900];
public float[][] yField = new float[1600][900];

public float[][] xFieldRev = new float[1600][900];
public float[][] yFieldRev = new float[1600][900];

public boolean reversedField = false;
public boolean launched = false;

public int xStartPosition, yStartPosition;

public Player player;
public Cannon cannon;
public Goal goal;


public void setup() {
  size(1600, 900);

  xStartPosition = 500;
  yStartPosition = 450;

  player = new Player(xStartPosition, yStartPosition, 0, 0, -1, 30, launched);
  cannon = new Cannon(xStartPosition, yStartPosition);
  goal = new Goal(1000, 350, 1500, 550);

  chargeList.add(new Charge(800, 600, 10, 60));
  chargeList.add(new Charge(700, 300, -4, 60));
  sumElectricField();
}

public void draw() {
  background(0, 0, 0);

  for (Charge c : chargeList) {
      c.draw();
  }

  cannon.draw();
  goal.draw();

  if (reversedField) {
      player.draw(xFieldRev, yFieldRev, chargeList, launched);
  }
  else {
      player.draw(xField, yField, chargeList, launched);
  }

  boolean checkWin = goal.checkWin(player);

  if (checkWin) {
      text("You Win!", 1400, 300);
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