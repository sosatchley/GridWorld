Environment env;

void setup() {
    background(0);
    int winDim = 1000;
    size(1000, 1000);
    env = new Environment(10, winDim, false, true);

}

void draw() {
    env.render();
}
