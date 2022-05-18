// VARIABLE SETUP
public float[][] xField, yField, xFieldRev, yFieldRev = new float[1600][900];

public ArrayList<Charge> chargeList;

public boolean reversedField, launched;

public Player player;
public Cannon cannon;
public Goal goal;

public int level = 1;
public Level currentLevel;


public void setup() {
  size(1600, 900);
  ellipseMode(CENTER);

  // sets up map and player
  reversedField = false;
  launched = false;
  updateLevel(parseLevelFile("level" + level));
}

public void draw() {
  background(0, 0, 0);

  // draws charges, cannon, goal, and player
  for (Charge c : chargeList) {
      c.draw();
  }

  cannon.draw();
  goal.draw();

  if (reversedField) {
      player.draw(xFieldRev, yFieldRev, chargeList, launched, currentLevel);
  }
  else {
      player.draw(xField, yField, chargeList, launched, currentLevel);
  }


  // next level
  if (goal.checkWin(player)) {
    level++;
    setup();
  }
}

public void sumElectricField() {
  // regular electric field
    xField = new float[1600][900];
    yField = new float[1600][900];

  // swapped electric field
    xFieldRev = new float[1600][900];
    yFieldRev = new float[1600][900];

  // sum electric fields
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
  // switches between regular and reversed electric field
    if (key == 'c') {
        reversedField = !reversedField;
        for (Charge c : chargeList) {
            c.charge *= -1;
        }
    }

  // resets level
    if (key == 'r') {
        background(0);
        setup();
    }

  // launches player from cannon
    if (key == 'l' && !launched) {
        launched = true;

        float angle = atan2(cannon.y - mouseY, cannon.x - mouseX);

        float x = cos(angle) * 5;
        float y = sin(angle) * 5;

        player.xVel = -x;
        player.yVel = -y;
    }

  // skips level
    if (key == 's') {
      level++;
      setup();
    }
}

public void mousePressed() {
  // launches player from cannon
  if (mouseButton == LEFT && !launched) {
    launched = true;

    float angle = atan2(cannon.y - mouseY, cannon.x - mouseX);

    float x = cos(angle) * 5;
    float y = sin(angle) * 5;

    player.xVel = -x;
    player.yVel = -y;
  }

  // switches between regular and reversed electric field
  if (mouseButton == RIGHT) {
    reversedField = !reversedField;
    for (Charge c : chargeList) {
        c.charge *= -1;
    }
  }
}

public Level parseLevelFile(String filename) {
  // reads map data
    String[] rawLevel = loadStrings("levels/" + filename);

  // creates level variables
    Player player = new Player(0, 0, 0, 0, -1, 30, false);
    Goal goal = new Goal(0, 0, 0, 0);
    ArrayList<Charge> chargeList = new ArrayList<Charge>();

  // parses map data
    for (String row : rawLevel) {
        String[] data = splitTokens(row);

        // stores player info
        if (data[0].equals("player")) {
            int x = Integer.parseInt(data[1]);
            int y = Integer.parseInt(data[2]);
            int charge = Integer.parseInt(data[3]);

            player = new Player(x, y, 0, 0, charge, 30, false);
        }

        // stores goal info
        else if (data[0].equals("goal")) {
            int x1 = Integer.parseInt(data[1]);
            int y1 = Integer.parseInt(data[2]);
            int x2 = Integer.parseInt(data[3]);
            int y2 = Integer.parseInt(data[4]);

            goal = new Goal(x1, y1, x2, y2);
        }

        // stores charge info
        else if (data[0].equals("charge")) {
            int x = Integer.parseInt(data[1]);
            int y = Integer.parseInt(data[2]);
            int charge = Integer.parseInt(data[3]);

            chargeList.add(new Charge(x, y, charge, 60));
        }
    }

    return new Level(player, goal, chargeList, int(filename.substring(filename.length() - 1)));
}

public void updateLevel(Level l) {
  // takes level variables and updates game
    this.player = l.player;
    this.cannon = l.cannon;
    this.goal = l.goal;
    this.chargeList = l.chargeList;

    sumElectricField();
}