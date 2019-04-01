class Agent {
    int x;
    int y;
    int index;
    int gridSize;
    int winDim;

    Agent(int gridSize, int winDim) {
        this.x = 0;
        this.y = 0;
        this.index = 0;
        this.gridSize = gridSize;
        this.winDim = winDim;
    }

    void render() {
        float size = (this.winDim/this.gridSize);
        float x = this.x * (size);
        float y = this.y * (size);
        x += (size)/2;
        y += (size)/2;
        fill(#1ef0fe);
        ellipse(x, y, size, size);
    }
}
