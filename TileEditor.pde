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




