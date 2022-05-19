
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
        float a = (float)(y2 - y1) / (float)(x2 - x1);
        float b = -1;
        float c = ((float)(y1 - y2) / (float)(x2 - x1)) * x1 + y1;

        double dist = Math.abs(a * p.x + b * p.y + c) / Math.sqrt(a * a + b * b);

        return p.radius >= dist;

        // float a = x1*x1 - 2*x1*x2 + x2*x2;
        // float b = 2*x1*x2 - 2*x2*x2 - 2*p.x*x2 + 2*p.x*x2;
        // float c = x2*x2 - 2*p.x*x2 + p.x*p.x - p.radius*p.radius;

        // float a = x1 * x1 + y1 * y1 - 2 * x1 * x2 - 2 * y1 * y2;
        // float b = 2*x1*x2 + p.x*x2 - p.x*x1 + 2*y1*y2 + p.y*y2 - p.y*y1;
        // float c = p.x*p.x - p.x*x2 + p.y*p.y - p.y*y2 - p.radius*p.radius;


        // float quadForm = quadraticFormula(a, b, c);
        
        // return 0 <= quadForm && quadForm <= 1;
        
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