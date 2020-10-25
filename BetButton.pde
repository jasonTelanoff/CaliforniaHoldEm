class BetButton {
  int amount;

  BetButton(int a) {
    this.amount = a;
  }

  void show() {
    switch(amount) {
    case 10:
      fill(#0000ff);
      stroke(#afafaf);
      strokeWeight(3);
      rect(7*width/10 - 15, 5*height/6 + 15, width/10 - 30, height/6 - 30);
      fill(255);
      textMode(CENTER);
      textSize(30);
      text("10", 15*width/20 - 30, 5*height/6 + 15 + (height/6 - 30)/2);
      break;
    case 25:
      fill(#ff0000);
      rect(8*width/10 - 15, 5*height/6 + 15, width/10 - 30, height/6 - 30);
      break;
    case 100:
      fill(#ffffff);
      rect(9*width/10 - 15, 5*height/6 + 15, width/10 - 30, height/6 - 30);
      break;
    }
  }

  void checkPress() {
  }
}
