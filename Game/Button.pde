
public class Button {

    int x1, y1, x2, y2;
    String text;
    boolean hover;

    Button(int x1, int y1, int x2, int y2, String text) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
        this.text = text;
        this.hover = false;
    }

    public void draw() {
        this.hover = isClicked(mouseX, mouseY);
        if (this.hover) fill(#C7C7C7);
        else fill(#E7E7E7);

        rect(x1, y1, x2 - x1, y2 - y1, 10);

        if (this.hover) fill(#1EF01E);
        else fill(#1ED01E);
        textSize(50);
        text(text, x1 + (x2 - x1) / 2 - textWidth(text) / 2, y1 + (y2 - y1) / 2 + textAscent() / 2 - 8);
        fill(255);
    }

    public boolean isClicked(int x, int y) {
        return x > x1 && x < x2 && y > y1 && y < y2;
    }

}