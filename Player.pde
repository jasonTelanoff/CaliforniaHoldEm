class Player {
  int balance, amountBet;
  ArrayList<Card> hand = new ArrayList<Card>();
  boolean bet = false, folded = false;

  Player(int balance) {
    this.balance = balance;
    amountBet = 0;
  }

  void drawCards() {
    for (int i = 0; i < 2; i++)
      hand.add(pickCard(cards, true, i));
  }

  void bet(int amount) {
    balance-= amount;
    TOTAL_BET+= amount;
  }
}
