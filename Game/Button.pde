
public class Button {

    int x1, y1, x2, y2;
    String text;

    Button(int x1, int y1, int x2, int y2, String text) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
        this.text = text;
    }

    public void draw() {
        fill(100);
        rect(x1, y1, x2 - x1, y2 - y1, 10);
        fill(255);

        stroke(0);
        textSize(50);
        text(text, x1 + (x2 - x1) / 2 - textWidth(text) / 2, y1 + (y2 - y1) / 2 + textAscent() / 2);
    }

    public boolean isClicked(int x, int y) {
        return x > x1 && x < x2 && y > y1 && y < y2;
    }

}