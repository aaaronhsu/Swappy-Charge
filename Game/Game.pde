// VARIABLE SETUP
public float[][] xField, yField, xFieldRev, yFieldRev = new float[1600][900];

public LevelInfo levelInfo = new LevelInfo();

public ArrayList<Charge> chargeList;
public ArrayList<Wall> wallList;
public ArrayList<PickupCharge> pickupChargeList;
public ArrayList<Pit> pitList;

public ArrayList<PickupCharge> removedPickupCharges = new ArrayList<PickupCharge>();

public boolean reversedField, launched;

public Button startButton;
public Button victoryButton;
public Button chickenifyButton = new Button(350, 600, 650, 750, "CHICKENIFY");
// public Button controlsButton;

public Player player;
public Cannon cannon;
public Goal goal;

public int level = 0;
public Level currentLevel;
public int deaths = 0;

public boolean controlsScreen;
public boolean showElectricField = false;
public boolean victory = false;

public boolean chickenify = false;


public void setup() {
  size(1000, 800);
  ellipseMode(CENTER);
  startButton = new Button(width/2 - 100, height/2 - 50, width/2 + 100, height/2 + 50, "Start");
  // controlsButton = new Button(width/2 + 75, height/2 - 50, width/2 + 325, height/2 + 50, "Controls");

  // sets up map and player
  reversedField = false;
  launched = false;
  controlsScreen = false;

  if (level > 0) {

    if (currentLevel == null) {
      currentLevel = parseLevelFile(1);
      updateLevel(currentLevel);
    }
    else if (level != currentLevel.levelNum) {
      // THE PLAYER PASSED THE LEVEL
      // println("Loading level " + level + "... the level used to be " + currentLevel.levelNum);

      pickupChargeList = new ArrayList<PickupCharge>();
      removedPickupCharges = new ArrayList<PickupCharge>();
      
      Level newLevel;

      try {
        newLevel = parseLevelFile(level);
      } catch (Exception e) {
        victory = true;
        victoryButton = new Button(width/2 - 150, height/2 + 25, width/2 + 150, height/2 + 125, "Play Again?");
        return;
      }
      updateLevel(newLevel);
      currentLevel = newLevel;
    }
    else {
      // THE PLAYER FAILED THE LEVEL
      if (chickenify) {
        player = new Chicken(cannon.x, cannon.y, 0, 0, 1, 30, false);
      }
      else {
        player = new Player(cannon.x, cannon.y, 0, 0, 1, 30, false);
      }

      for (PickupCharge c : removedPickupCharges) {
        pickupChargeList.add(c);
        println("pickup added");
      }

      removedPickupCharges = new ArrayList<PickupCharge>();

      for (Charge c : chargeList) {
        c.charge = c.initialCharge;
      }


      deaths++;
    }
  }
}

public void draw() {
  background(#101010);

  if (victory) {
    drawVictory();
  }
  else if (level > 0) {
    if (showElectricField) {
      drawElectricField();
    }
    drawElements();
    checkCollisions();

    // next level
    if (goal.checkWin(player)) {
      level++;
      setup();
    }

    textSize(24);
    text("Level " + level, 25, 25);
    text("Press 'c' to toggle controls", 25, 50);

    textAlign(RIGHT);
    if (chickenify) text("Chicken Charge: " + player.charge, 980, 25);
    else text("Charge: " + player.charge, 980, 25);
    
    text("Deaths: " + deaths, 980, 780);
    textSize(50);
    textAlign(LEFT);

    if (!launched) levelInfo.drawLevelInfo(level);
    
  }
  else if (level == 0) {
    textAlign(CENTER);
    if (chickenify) text("CHICKENIFIED SWAPPY CHARGE", width/2, height/2 - 200);
    else text("Swappy Charge", width/2, height/2 - 200);
    
    textAlign(LEFT);
    drawTitle();

    // controlsButton.draw();
  }
  else if (level < 0) {
    drawGameOver();
  }


  if (controlsScreen) {
    drawControls();
  }

  // println("(" + mouseX + ", " + mouseY + ")");
}

public void drawVictory() {
  textAlign(CENTER);
  text("WINNER WINNER CHICKEN DINNER!", width/2, height/2 - 200);
  textAlign(LEFT);
  victoryButton.draw();
}

public void drawTitle() {
  startButton.draw();
  chickenifyButton.draw();
}

public void drawElectricField() {

  if (reversedField) {
    for (int i = 0; i < xFieldRev.length; i += 50) {
      for (int j = 0; j < xFieldRev[i].length; j += 50) {
        float opacity = (xFieldRev[i][j] * xFieldRev[i][j] + yFieldRev[i][j] * yFieldRev[i][j]) * 10000000;
        float len = 25;

        float theta = atan2(yFieldRev[i][j], xFieldRev[i][j]);

        stroke(255, opacity / 255);
        strokeWeight(1);
        pushMatrix();
        translate(i, j);
        rotate(theta);
        line(0,0,len, 0);
        line(len, 0, len - 5, -5);
        line(len, 0, len - 5, 5);
        popMatrix();
        stroke(0);
        strokeWeight(3);

        fill(255, 50);
        stroke(255, 50);
        if (opacity == 0) ellipse(i, j, 3, 3);
        fill(255);
        stroke(0);
      }
    }
  }
  else {
    for (int i = 0; i < xField.length; i += 50) {
      for (int j = 0; j < xField[i].length; j += 50) {
        float opacity = (xField[i][j] * xField[i][j] + yField[i][j] * yField[i][j]) * 10000000;
        float len = 25;


        float theta = atan2(yField[i][j], xField[i][j]);

        stroke(255, opacity / 255);
        strokeWeight(1);
        pushMatrix();
        translate(i, j);
        rotate(theta);
        line(0,0,len, 0);
        line(len, 0, len - 5, -5);
        line(len, 0, len - 5, 5);
        popMatrix();
        stroke(0);
        strokeWeight(3);  

        fill(255, 50);
        stroke(255, 50);
        if (opacity == 0) ellipse(i, j, 3, 3);
        fill(255);
        stroke(0);
      }
    }
  }
}

public void drawGameOver() {
  textSize(100);
  textAlign(CENTER);
  fill(255, 0, 0);
  text("GAME OVER", width/2, height/2);
}

public void drawControls() {
  textSize(50);
  // textAlign(CENTER);
  // text("CONTROLS", 20, 680 - 100);

  fill(230, 230, 230, 200);
  rect(300, 100, 400, 600, 10);
  fill(200, 200, 200, 200);
  rect(305, 105, 390, 590, 10);


  textAlign(CENTER);

  fill(0);
  text("CONTROLS", 500, 200);
  fill(30);
  textSize(25);
  text("Aim: CURSOR", 500, 300);
  text("Shoot: LEFT CLICK", 500, 350);
  text("Flip Charges: SPACE", 500, 400);
  text("Restart Level: BACKSPACE", 500, 450);
  text("Skip Level: 's'", 500, 500);
  text("Toggle Electric Field: 't'", 500, 550);

  fill(255, 255, 255);
  textSize(50);

  textAlign(LEFT);
}

/* DRAWS ELEMENTS */
public void drawElements() {
  for (Charge c : chargeList) {
      c.draw();
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
}



/* CHECKS COLLISIONS */
public void checkCollisions() {
  checkPickupChargeCollision();
  checkPitCollision();
  checkWallCollsion();
}

public void checkPickupChargeCollision() {
  ArrayList<PickupCharge> removeList = new ArrayList<PickupCharge>();
  for (PickupCharge c : pickupChargeList) {
    c.draw();

    if (c.isTouchingPlayer(player)) {
      player.charge += c.charge;
      player.radius = sqrt((abs(player.charge * 100))) + 30;

      player.xVel *= (float) player.mass / (player.mass + 1);
      player.yVel *= (float) player.mass / (player.mass + 1);

      player.radius += 10;

      removeList.add(c);
    }
  }
  for (PickupCharge c : removeList) {
    removedPickupCharges.add(c);
    pickupChargeList.remove(c);
  }
}

public void checkPitCollision() {
  // check pit collision
  for (Pit p : pitList) {
    if (p.isTouchingPlayer(player)) {
      setup();
      return;
    }
  }
}

public void checkWallCollsion() {
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
}



/* UPDATES LEVEL */
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

public Level parseLevelFile(int level) {
  // reads map data
    String[] rawLevel = loadStrings("levels/level" + level);

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

            if (chickenify) player = new Chicken(x, y, 0, 0, charge, 30, false);
            else player = new Player(x, y, 0, 0, charge, 30, false);
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
    
    return new Level(player, goal, chargeList, pickupChargeList, wallList, pitList, level);
}

public void updateLevel(Level l) {
  // takes level variables and updates game

    // println("updating level " + l.levelNum);
    this.player = l.player;
    this.cannon = l.cannon;
    this.goal = l.goal;
    this.chargeList = l.chargeList;
    this.pickupChargeList = l.pickupChargeList;
    this.wallList = l.wallList;
    this.pitList = l.pitList;
    sumElectricField();
}



/* USER INPUT */
public void keyPressed() {
  // switches between regular and reversed electric field

  if (level > 0) {
    if (key == 32) {
        reversedField = !reversedField;
        for (Charge c : chargeList) {
            c.swapCharge();
        }
    }

  // resets level on backspace
    if (key == 8) {
        background(0);
        setup();
    }

  // skips level
    if (key == 's') {
      level++;
      setup();
    }
  }

  if (key == 'c') {
    controlsScreen = !controlsScreen;
  }

  if (level > 0 && key == 't') {
    showElectricField = !showElectricField;
  }
}

public void mousePressed() {

  if (level > 0) {
    // launches player from cannon on left click
    if (mouseButton == LEFT && !launched) {
      launched = true;

      float angle = atan2(cannon.y - mouseY, cannon.x - mouseX);

      float x = cos(angle) * 5;
      float y = sin(angle) * 5;

      player.xVel = -x;
      player.yVel = -y;
    }

    // restarts level on right click
    if (mouseButton == RIGHT) {
      background(0);
      setup();
    }
  }

  if (level == 0 && mouseButton == LEFT) {
    if (startButton.isClicked(mouseX, mouseY)) {
      level = 1;
      setup();
    }
  }

  if (victory && mouseButton == LEFT) {
    if (victoryButton.isClicked(mouseX, mouseY)) {
      level = 0;
      deaths = 0;
      victory = false;
      setup();
    }
  }

  if (level == 0 && mouseButton == LEFT) {
    if (chickenifyButton.isClicked(mouseX, mouseY)) {
      chickenify = !chickenify;
    }
  }

  // if (level == 0 && mouseButton == LEFT) {
  //   if (controlsButton.isClicked(mouseX, mouseY)) {
  //     controlsScreen = !controlsScreen;
  //   }
  // }
}