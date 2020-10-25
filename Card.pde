class Card {
  int suit, num, x, y;

  Card(int suit, int num) {
    this.suit = suit;
    this.num = num;
  }

  void show() {    
    fill(255);
    stroke(0);
    strokeWeight(2);
    rect(x, y, width/10 - 30, height/4 - 30, 20);

    if (suit < 2)
      fill(0);
    else
      fill(#ff0000);
    textSize(height/40);
    textAlign(LEFT, TOP);
    text(showNum(num), x + 15, y + 15);
    textAlign(RIGHT, BOTTOM);
    text(showNum(num), x + width/10 - 45, y + height/4 - 45);
  }

  void pick(boolean hand, int i) {
    if (hand) {
      x = i * width/10 + 15;
      y = 3*height/4 + 15;
    } else {
      x = width - i * width/10 - width/10 + 15;
      y = 15;
    }
  }

  String showNum(int n) {
    switch(n) {
    case 11:
      return "J";
    case 12:
      return("Q");
    case 13:
      return("K");
    }
    return "" + n;
  }
}
