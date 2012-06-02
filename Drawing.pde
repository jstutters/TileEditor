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
