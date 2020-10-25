class Player {
  int balance, amountBet;
  ArrayList<Card> hand = new ArrayList<Card>();
  
  Player(int balance) {
    this.balance = balance;
    amountBet = 0;
  }

  void drawCards() {
    for (int i = 0; i < 2; i++)
      hand.add(pickCard(cards, true, i));
  }
  
  void betMoney(int amount) {
    
  }
}
