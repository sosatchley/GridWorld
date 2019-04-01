Environment env;
Agent agent;

void setup() {
    background(0);
    int winDim = 1000;
    int size = 8;
    size(1000, 1000);
    env = new Environment(size, winDim, false, true);
    agent = new Agent(size, winDim);
}

void draw() {
    env.render();
    agent.render();
}
