
public class Goal {

    // top left and bottom right coordinates of the goal
    int x1, y1, x2, y2;

    Goal(int x1, int y1, int x2, int y2) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
    }

    public void draw() {
        fill(0, 255, 0);
        rect(min(x1, x2), min(y1, y2), abs(x2 - x1), abs(y2 - y1));
        fill(255);
    }

    public boolean checkWin(Player p) {
        // checks if the player is in the goal
        return p.x >= min(x1, x2) && p.x <= max(x1, x2) && p.y >= min(y1, y2) && p.y <= max(y1, y2);
    } 
}