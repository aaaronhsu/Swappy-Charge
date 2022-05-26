
public class Wall {

    int x1, x2, y1, y2, thickness;

    Wall(int x1, int y1, int x2, int y2, int thickness) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
        this.thickness = thickness;
    }


    public boolean isTouchingPlayer(Player p) {
        return p.x + (p.radius + thickness / 2) / 2 >= min(x1, x2) && p.x - (p.radius + thickness / 2) / 2 <= max(x1, x2) && p.y + (p.radius + thickness / 2) / 2 >= min(y1, y2) && p.y - (p.radius + thickness / 2) / 2 <= max(y1, y2);
    }

    public boolean stopXVelocity(Player p) {
        return x1 == x2;
    }

    public float quadraticFormula(float a, float b, float c) {
        float d = b*b - 4*a*c;
        if (d < 0) {
            return -1;
        }
        return (float) ((-b + Math.sqrt(d)) / (2*a));
    }

    public void draw() {
        strokeWeight(thickness);
        stroke(50);

        line(x1, y1, x2, y2);

        strokeWeight(4);
    }
}