
public class Level {

    // stores level data
    Player player;
    Cannon cannon;
    Goal goal;
    ArrayList<Charge> chargeList;
    ArrayList<PickupCharge> pickupChargeList;
    ArrayList<Wall> wallList;
    ArrayList<Pit> pitList;

    int levelNum;

    Level(Player player, Goal goal, ArrayList<Charge> chargeList, ArrayList<PickupCharge> pickupChargeList, ArrayList<Wall> wallList, ArrayList<Pit> pitList, int levelNum) {
        this.player = player;
        this.goal = goal;
        this.chargeList = chargeList;
        this.pickupChargeList = pickupChargeList;
        cannon = new Cannon((int)player.x, (int)player.y);
        this.levelNum = levelNum;
        this.wallList = wallList;
        this.pitList = pitList;
    }
}
