class PaletteSelector {
  int numColours;
  int posX, posY;
  int rightEdge, bottomEdge;
  int squareSz = 30;
  int selectedColour;
  Drawing drawing;

  PaletteSelector(int x, int y) {
    posX = x;
    posY = y;
    bottomEdge = y + squareSz;
    selectedColour = 0;
  }

  void setDrawing(Drawing d) {
    drawing = d;
    numColours = drawing.palette.length;
    rightEdge = posX + numColours * squareSz;
  }

  void display() {
    if (drawing != null) {
      for (int i = 0; i < numColours; i++) {
        if (i == selectedColour) {
          stroke(0);
        } 
        else {
          noStroke();
        }
        fill(d.palette[i]);
        rect(posX + i * squareSz, posY, squareSz, squareSz);
      }
    }
  }

  boolean hitTest(int mx, int my) {
    if (mx > posX && mx < rightEdge && my > posY && my < bottomEdge) {
      selectedColour = (mx - posX) / squareSz;
      println(selectedColour);
      return true;
    } 
    else {
      return false;
    }
  }
}
