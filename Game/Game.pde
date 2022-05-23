// VARIABLE SETUP
public float[][] xField, yField, xFieldRev, yFieldRev = new float[1600][900];

public ArrayList<Charge> chargeList;
public ArrayList<Wall> wallList;
public ArrayList<PickupCharge> pickupChargeList;
public ArrayList<Pit> pitList;

public boolean reversedField, launched;

public Player player;
public Cannon cannon;
public Goal goal;

public int level = 1;
public Level currentLevel;


public void setup() {
  size(1000, 800);
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

  ArrayList<PickupCharge> removeList = new ArrayList<PickupCharge>();
  for (PickupCharge c : pickupChargeList) {
    c.draw();

    if (c.isTouchingPlayer(player)) {
      player.charge += c.charge;
      player.radius = sqrt((abs(player.charge * 100))) + 30;

      if (abs(player.charge) <= 1) {
        player.radius = 30;
      }

      removeList.add(c);
    }
  }
  for (PickupCharge c : removeList) {
    pickupChargeList.remove(c);
  }

  for (Wall w : wallList) {
    w.draw();
  }
  for (Pit p : pitList) {
    p.draw();
  }

  cannon.draw();
  goal.draw();

  if (reversedField) {
      player.draw(xFieldRev, yFieldRev, chargeList, launched, currentLevel);
  }
  else {
      player.draw(xField, yField, chargeList, launched, currentLevel);
  }

  // check pit collision
  for (Pit p : pitList) {
    if (p.isTouchingPlayer(player)) {
      setup();
      return;
    }
  }

  // check wall collision
  for (Wall w : wallList) {
    if (w.isTouchingPlayer(player)) {
      if (w.stopXVelocity(player)) {
        // player.xVel = 0;
        player.xVel *= -1;
      }
      else {
        // player.yVel = 0;
        player.yVel *= -1;
      }
      return;
    }
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


                if (c.isConstant) {
                  xFieldRev[i][j] += c.xField[i][j];
                  yFieldRev[i][j] += c.yField[i][j];
                }
                else {
                  xFieldRev[i][j] -= c.xField[i][j];
                  yFieldRev[i][j] -= c.yField[i][j];
                }
            }
        }
    }
}

public void keyPressed() {
  // switches between regular and reversed electric field
    if (key == 32) {
        reversedField = !reversedField;
        for (Charge c : chargeList) {
            c.swapCharge();
        }
    }

  // resets level
    if (key == 8) {
        background(0);
        setup();
    }

  // launches player from cannon
    if (key == 'g' && !launched) {
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
        c.swapCharge();
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
    ArrayList<Wall> wallList = new ArrayList<Wall>();
    ArrayList<PickupCharge> pickupChargeList = new ArrayList<PickupCharge>();
    ArrayList<Pit> pitList = new ArrayList<Pit>();

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

            chargeList.add(new Charge(x, y, charge, 60, false));
        }

        // stores constant charge info
        else if (data[0].equals("constantcharge")) {
          int x = Integer.parseInt(data[1]);
          int y = Integer.parseInt(data[2]);
          int charge = Integer.parseInt(data[3]);

          chargeList.add(new Charge(x, y, charge, 60, true));
        }

        else if (data[0].equals("pickupcharge")) {
          int x = Integer.parseInt(data[1]);
          int y = Integer.parseInt(data[2]);
          int charge = Integer.parseInt(data[3]);

          pickupChargeList.add(new PickupCharge(x, y, charge));
        }

        else if (data[0].equals("wall")) {
          int x1 = Integer.parseInt(data[1]);
          int y1 = Integer.parseInt(data[2]);
          int x2 = Integer.parseInt(data[3]);
          int y2 = Integer.parseInt(data[4]);
          int thickness = Integer.parseInt(data[5]);

          wallList.add(new Wall(x1, y1, x2, y2, thickness));
        }

        else if (data[0].equals("pit")) {
          int x1 = Integer.parseInt(data[1]);
          int y1 = Integer.parseInt(data[2]);
          int x2 = Integer.parseInt(data[3]);
          int y2 = Integer.parseInt(data[4]);
          int thickness = Integer.parseInt(data[5]);

          pitList.add(new Pit(x1, y1, x2, y2, thickness));
        }
    }
    
    return new Level(player, goal, chargeList, pickupChargeList, wallList, pitList, int(filename.substring(filename.length() - 1)));
}

public void updateLevel(Level l) {
  // takes level variables and updates game
    this.player = l.player;
    this.cannon = l.cannon;
    this.goal = l.goal;
    this.chargeList = l.chargeList;
    this.pickupChargeList = l.pickupChargeList;
    this.wallList = l.wallList;
    this.pitList = l.pitList;

    sumElectricField();
}