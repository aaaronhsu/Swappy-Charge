
public class Level {

    // stores level data
    Player player;
    Cannon cannon;
    Goal goal;
    ArrayList<Charge> chargeList;
    ArrayList<PickupCharge> pickupChargeList;
    ArrayList<Wall> wallList;

    int levelNum;

    Level(int xStart, int yStart, ArrayList<Charge> chargeList, int goalX1, int goalY1, int goalX2, int goalY2, int levelNum) {
        player = new Player(xStart, yStart, 0, 0, -1, 30, false);
        this.chargeList = chargeList;
        goal = new Goal(goalX1, goalY1, goalX2, goalY2);
        this.levelNum = levelNum;
    }

    Level(Player player, Goal goal, ArrayList<Charge> chargeList, ArrayList<PickupCharge> pickupChargeList, ArrayList<Wall> wallList, int levelNum) {
        this.player = player;
        this.goal = goal;
        this.chargeList = chargeList;
        this.pickupChargeList = pickupChargeList;
        cannon = new Cannon((int)player.x, (int)player.y);
        this.levelNum = levelNum;
        this.wallList = wallList;
    }
}
