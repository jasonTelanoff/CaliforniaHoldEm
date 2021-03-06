class Card {
  final int suit, num;
  int x, y, w, h;

  Card(int suit, int num) {
    this.suit = suit;
    this.num = num;
    h = height/3;
    w = h * 2/3;
  }

  void show() {    
    fill(255);
    stroke(0);
    strokeWeight(2);
    rectMode(CORNER);
    rect(x, y, w, h, 20);

    if (suit < 2)
      fill(0);
    else
      fill(#ff0000);
    textSize(30);
    textAlign(LEFT, TOP);
    text(showNum(num), x + 15, y + 15);
    textAlign(RIGHT, BOTTOM);
    text(showNum(num), x + w - 15, y + h - 15);

    imageMode(CENTER);
    image(suits[suit], x + w/2, y + h/2, w/2, h/3);
  }

  void pick(boolean hand, int i) {
    if (hand) {
      x = i * (w + 15) + 15;
      y = height - h - 15;
    } else {
      x = width - (i + 1) * (w + 15);
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
