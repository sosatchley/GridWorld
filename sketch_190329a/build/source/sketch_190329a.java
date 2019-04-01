import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Random; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_190329a extends PApplet {

Environment env;

public void setup() {
    background(0);
    int winDim = 1000;
    
    env = new Environment(10, winDim, false, true);

}

public void draw() {
    env.render();
}
class Agent {
    
}


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


    public void render() {
        grid(this.size);
        gridfill(this.contents);
    }

    public void genContents() {
        Random generator = new Random();
        int len = this.size * this.size;
        this.contents = new int[len];
        double mazeChance, mineChance;
        if (this.maze) {
            mazeChance = .7f;
        } else {
            mazeChance = 1.0f;
        }
        if (this.mines) {
            mineChance = .9f;
        } else {
            mineChance = 1.0f;
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

    public void grid(int size) {
        stroke(0xff7d169c);
        strokeWeight(1);
        for (int i=0; i < this.winDim; i += this.winDim/size) {
            line(i, 0, i, winDim);
            line(0, i, winDim, i);
        }
        line(winDim, 0, winDim, winDim);
        line(0, winDim, winDim, winDim);
    }

    public void gridfill(int[] contents) {
        for (int i = 0; i < contents.length; i++) {
            drawContents(i, contents[i]);
        }
    }

    public void drawContents(int index, int content) {
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

    public int ind_x(int index) {return index % this.size;}
    public int ind_y(int index) {return index / this.size;}
    public int index(int x, int y) {return x + y * this.size;}
}
  public void settings() {  size(1000, 1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_190329a" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
