
public class Goal {

    int x1, y1, x2, y2;

    Goal(int x1, int y1, int x2, int y2) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
    }

    public void draw() {
        fill(0, 255, 0);
        rect(x1, y1, abs(x2 - x1), abs(y2 - y1));
        fill(255);
    }

    public boolean checkWin(Player p) {
        return p.x >= x1 && p.x <= x2 && p.y >= y1 && p.y <= y2;
    } 
}