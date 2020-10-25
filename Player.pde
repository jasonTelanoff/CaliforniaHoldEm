class Player {
  int balance, amountBet, i;
  Card[] hand = new Card[2];
  boolean bet = false, folded = false, allIn = false;

  Player(int balance, int i) {
    this.balance = balance;
    amountBet = 0;
    this.i = i;
  }

  void drawCards() {
    for (int i = 0; i < 2; i++)
      hand[i] = pickCard(cards, true, i);
  }

  void bet(int amount) {
    balance-= amount;
    amountBet+= amount;
    TOTAL_BET+= amount;
  }
}
