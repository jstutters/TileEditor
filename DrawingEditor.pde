class DrawingEditor {
  int posX, posY;             // position of the editor
  int gridX, gridY;           // position of the grid ignoring loop guides
  int gridRight, gridBottom;  // edges of the grid
  int squareSz;               // size of the editor squares
  Drawing drawing;            // the drawing we're working on
  int currentColour;            // colour we're drawing with

  DrawingEditor(int px, int py, int ss) {
    posX = px;
    posY = py;
    squareSz = ss;
    gridX = posX + squareSz + 1;
    gridY = posY + squareSz + 1;
    gridRight = 0;
    gridBottom = 0;
    currentColour = 0;
  }

  void setDrawing(Drawing d) {
    drawing = d;
    gridRight = gridX + (squareSz * drawing.sz);
    gridBottom = gridY + (squareSz * drawing.sz);
  }

  boolean hitTest(int mx, int my) {
    if (mx > gridX && mx < gridRight && my > gridY && my < gridBottom) {
      int relativeX = mx - gridX;
      int relativeY = my - gridY;
      int gx = floor(relativeX / squareSz);
      int gy = floor(relativeY / squareSz);
      drawing.setPx(gx, gy, currentColour);
      return true;
    } 
    else {
      return false;
    }
  }

  void display() { 
    noStroke();
    color c;
    for (int x = 0; x < drawing.sz; x++) {
      for (int y = 0; y < drawing.sz; y++) {
        c = drawing.palette[drawing.getPx(x, y)];
        fill(c);
        rect(x * squareSz + gridX, y * squareSz + gridY, squareSz, squareSz);
      }
    }

    for (int x = 0; x < drawing.sz; x++) {
      int sx = x * squareSz + gridX;
      c = drawing.palette[drawing.getPx(x, 0)];
      fill(c);
      rect(sx, gridBottom + 1, squareSz, squareSz);
      c = drawing.palette[drawing.getPx(x, drawing.sz - 1)];
      fill(c);
      rect(sx, posY, squareSz, squareSz);
    }

    for (int y = 0; y < drawing.sz; y++) {
      int sy = y * squareSz + gridY;
      c = drawing.palette[drawing.getPx(0, y)];
      fill(c);
      rect(gridRight + 1, sy, squareSz, squareSz);
      c = drawing.palette[drawing.getPx(drawing.sz - 1, y)];
      fill(c);
      rect(posX, sy, squareSz, squareSz);
    }
  }
}
