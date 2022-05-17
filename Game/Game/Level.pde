
public class Level {

    Player player;
    Goal goal;
    ArrayList<Charge> chargeList;

    Level(int xStart, int yStart, ArrayList<Charge> chargeList, int goalX1, int goalY1, int goalX2, int goalY2) {
        player = new Player(xStart, yStart, 0, 0, -1, 30, false);
        this.chargeList = chargeList;
        goal = new Goal(goalX1, goalY1, goalX2, goalY2);
    }
}

static Level parseLevelFile(String filename) {
    
}
