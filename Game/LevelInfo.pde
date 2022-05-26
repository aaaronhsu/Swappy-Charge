public class LevelInfo {

    public void drawLevelInfo(int level) {

        textAlign(CENTER);
        textSize(32);
        int len = 150;
        
        switch(level) {
            case 1:
                text("Aim your cursor here", width/2, 200);
                text("LEFT CLICK to get the ball to the goal", width/2, 600);

                len = 150;
                stroke(255);
                pushMatrix();
                translate(width/2 + 125, height/2 - 175);
                rotate(radians(35));
                line(0,0,len, 0);
                line(len, 0, len - 8, -8);
                line(len, 0, len - 8, 8);
                popMatrix();

                stroke(0);
                break;
            
            case 2:
                text("This is a constant negative charge", width/2 + 100, 200);
                text("it produces an electric field", width/2 + 100, 600);
                text("that affects the ball's velocity", width/2 + 100, 640);

                len = 100;
                stroke(255);
                pushMatrix();
                translate(width/2 + 100, 240);
                rotate(radians(90));
                line(0,0,len, 0);
                line(len, 0, len - 8, -8);
                line(len, 0, len - 8, 8);
                popMatrix();
                stroke(0);
        }

        textAlign(LEFT);
        textSize(50);
    }
}