class Card {
  int suit, num;

  Card(int suit, int num) {
    this.suit = suit;
    this.num = num;
  }

  void show(int i) {
    fill(255);
    stroke(0);
    strokeWeight(2);
    rect(i * width/10 + 15, 3*height/4 + 15, width/10 - 30, height/4 - 30, 20);

    if (suit < 2)
      fill(0);
    else
      fill(#ff0000);
    textSize(height/40);
    textAlign(LEFT, TOP);
    text(showNum(num), i * width/10 + 20, 3*height/4 + 20);
    textAlign(RIGHT, BOTTOM);
    text(showNum(num), i * width/10 + width/10 - 20, height - 20);
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
