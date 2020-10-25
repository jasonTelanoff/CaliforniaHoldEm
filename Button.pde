class Button {
  int x, y, w, h, s;
  String text;

  void show() {
    if (mouseOn()) {
      stroke(204, 204, 0, 180);
      strokeWeight(5);
    } else {
      stroke(175, 180);
      strokeWeight(3);
    } 

    fill(154, 0, 0, 180);
    rectMode(CORNER);
    rect(x, y, w, h);

    textAlign(CENTER, CENTER);
    textSize(height/24);
    fill(255, 180);
    text(text, x + w/2, y + h/2);
  }

  boolean mouseOn() {
    if (s == scene && mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h)
      return true;
    return false;
  }
}
