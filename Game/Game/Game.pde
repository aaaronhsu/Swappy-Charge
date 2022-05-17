
public ArrayList<Charge> chargeList = new ArrayList<Charge>();
public float[][] xField = new float[1600][900];
public float[][] yField = new float[1600][900];

public float[][] xFieldRev = new float[1600][900];
public float[][] yFieldRev = new float[1600][900];

public Player player = new Player(400, 500, 3, 2, -1, 30);

public int fieldType = 1;

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

    text(fieldType, 100, 100);


    if (fieldType == 1) {
        player.draw(xField, yField, chargeList);
    }
    else {
        player.draw(xFieldRev, yFieldRev, chargeList);
    }

  for (Charge c : chargeList) {
      c.draw();
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
        fieldType *= -1;
        for (Charge c : chargeList) {
            c.charge *= -1;
        }
    }

    if (key == 'r') {
        player = new Player(400, 500, 3, 2, -1, 30);
    }
}