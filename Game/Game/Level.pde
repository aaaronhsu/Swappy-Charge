
public class Level {

    Player player;
    Goal goal;
    ArrayList<Charge> chargeList;

    Level(int xStart, int yStart, ArrayList<Charge> chargeList, int goalX1, int goalY1, int goalX2, int goalY2) {
        player = new Player(xStart, yStart, 0, 0, -1, 30, false);
        this.chargeList = chargeList;
        goal = new Goal(goalX1, goalY1, goalX2, goalY2);
    }

    Level(Player player, Goal goal, ArrayList<Charge> chargeList) {
        this.player = player;
        this.goal = goal;
        this.chargeList = chargeList;
    }
}

static Level parseLevelFile(String filename) {
    String[] rawLevel = loadStrings("levels/" + filename);

    Player player;
    Goal goal;
    ArrayList<Charge> chargeList = new ArrayList<Charge>();

    for (String row : rawLevel) {
        String[] data = splitTokens(row);

        if (data[0].equals("player")) {
            int x = Integer.parseInt(data[1]);
            int y = Integer.parseInt(data[2]);
            int charge = Integer.parseInt(data[3]);

            player = new Player(x, y, 0, 0, charge, 30, false);
        }
        else if (data[0].equals("goal")) {
            int x1 = Integer.parseInt(data[1]);
            int y1 = Integer.parseInt(data[2]);
            int x2 = Integer.parseInt(data[3]);
            int y2 = Integer.parseInt(data[4]);

            goal = new Goal(x1, y1, x2, y2);
        }
        else if (data[0].equals("charge")) {
            int x = Integer.parseInt(data[1]);
            int y = Integer.parseInt(data[2]);
            int charge = Integer.parseInt(data[3]);

            chargeList.add(new Charge(x, y, charge, 60));
        }
    }

    return new Level(player, goal, chargeList);
}
