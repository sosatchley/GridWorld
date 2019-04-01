import java.util.Random;

class Environment{
    int size;
    int winDim;
    boolean rom;
    boolean maze;
    boolean mines;
    int[] contents;

    Environment(int size, int winDim) {
        this.size = size;
        this.winDim = winDim;
        this.rom = false;
        this.maze = false;
        this.mines = false;
        genContents();
    }

    Environment(int size, int winDim, boolean maze, boolean mines) {
        this.size = size;
        this.winDim = winDim;
        this.rom = false;
        this.maze = maze;
        this.mines = mines;
        genContents();
    }


    void render() {
        grid(this.size);
        gridfill(this.contents);
    }

    void genContents() {
        Random generator = new Random();
        int len = this.size * this.size;
        this.contents = new int[len];
        double mazeChance, mineChance;
        if (this.maze) {
            mazeChance = .7;
        } else {
            mazeChance = 1.0;
        }
        if (this.mines) {
            mineChance = .9;
        } else {
            mineChance = 1.0;
        }
        // Draw Contents: 0=empty, 1=Start, 2=Finish, 3=Obstacle, 4=Landmine
        for (int i = 0; i < this.contents.length; i++) {
            double chance = generator.nextDouble();
            System.out.println(chance);
            if (i == 0) {
                contents[i] = 1;
                continue;
            } else if (i == this.contents.length-1) {
                contents[i] = 2;
                continue;
            }
            contents[i] = 0;
            // 30% chance for obstacles, 10% for landmines
            if (chance > mazeChance) {
                contents[i] = 3;
            }
            if (chance > mineChance) {
                contents[i] = 4;
            }
        }
    }

    void grid(int size) {
        stroke(#7d169c);
        strokeWeight(1);
        for (int i=0; i < this.winDim; i += this.winDim/size) {
            line(i, 0, i, winDim);
            line(0, i, winDim, i);
        }
        line(winDim, 0, winDim, winDim);
        line(0, winDim, winDim, winDim);
    }

    void gridfill(int[] contents) {
        for (int i = 0; i < contents.length; i++) {
            drawContents(i, contents[i]);
        }
    }

    void drawContents(int index, int content) {
        int x = ind_x(index);
        int y = ind_y(index);
        int len = (this.winDim/this.size);
        switch(content) {
            case 0 :
                noFill();
                break;
            case 1 :
                fill(0, 200, 255);
                break;
            case 2 :
                fill(0, 255, 0);
                break;
            case 3 :
                fill(125, 125, 125);
                break;
            case 4 :
                fill(255, 0, 0);
                break;
        }
        rect(len*x+1,len*y+1, len-1, len-1);
    }

    int ind_x(int index) {return index % this.size;}
    int ind_y(int index) {return index / this.size;}
    int index(int x, int y) {return x + y * this.size;}
}
