import controlP5.*;

ControlP5 controlP5;

Drawing d;
DrawingEditor drawEd;
PaletteSelector palSel;
ColorPicker colPick;

void setup() {
  size(1000, 500);

  controlP5 = new ControlP5(this);
  colPick = controlP5.addColorPicker("picker", 400, 200, 100, 30);

  d = new Drawing(32);
  drawEd = new DrawingEditor(20, 20, 10);
  drawEd.setDrawing(d);
  palSel = new PaletteSelector(20, 400);
  palSel.setDrawing(d);
}

void draw() {
  background(255);
  palSel.display();
  drawEd.display();
  drawTileGrid(400, 20);
}

void drawTileGrid(int l, int t) {
  for (int x = 0; x < 5; x++) {
    for (int y = 0; y < 5; y++ ) {
      d.drawTile(l + d.sz * x, t + d.sz * y);
    }
  }
}

void mouseClicked() {
  if (palSel.hitTest(mouseX, mouseY)) {
    drawEd.currentColour = palSel.selectedColour;
    colPick.setColourValue(d.palette[palSel.selectedColour]);
  }
}

void mouseDragged() {
  drawEd.hitTest(mouseX, mouseY);
}

void picker(int col) {
  println(col);
  d.palette[palSel.selectedColour] = col;
}

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

class Drawing {
  int[][] pix;      // pixel array of image
  int sz;           // size of the drawing
  color[] palette;

  Drawing(int sz) {
    this.sz = sz;
    pix = new int[sz][sz];
    zero();
    palette = new color[4];
  }

  void zero() {
    for (int x = 0; x < sz; x++) {
      for (int y = 0; y < sz; y++) {
        pix[x][y] = 0;
      }
    }
  }

  void setPx(int x, int y, color c) {
    pix[x][y] = c;
  }

  int getPx(int x, int y) {
    return pix[x][y];
  }

  void setPalette(int idx, color v) {
    palette[idx] = v;
  }

  // draw the image at actual size
  void drawTile(int px, int py) {
    for (int x = 0; x < sz; x++) {
      for (int y = 0; y < sz; y++) {
        stroke(palette[pix[x][y]]);
        point(px + x, py + y);
      }
    }
  }
}

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

