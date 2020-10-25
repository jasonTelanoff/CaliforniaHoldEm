ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Card> cards = new ArrayList<Card>();
ArrayList<Card> table = new ArrayList<Card>();
ArrayList<BetButton> buttons = new ArrayList<BetButton>();

void setup() {
  fullScreen();
  
  players.add(new Player(100));

  for (int s = 0; s < 4; s++)
    for (int n = 1; n < 14; n++)
      cards.add(new Card(s, n));

  for (int i = 0; i < players.size(); i++)
    players.get(0).drawCards();
  
  buttons.add(new BetButton(10));
  buttons.add(new BetButton(25));
  buttons.add(new BetButton(100));
}

void draw() {
  background(#23A039);
  
  for (int i = 0; i < players.get(0).hand.size(); i++)
    players.get(0).hand.get(i).show(i);
    
  for(BetButton b : buttons)
    b.show();
}

void endRound() {
  if(table.size() < 5) {
    table.add(pickCard(cards));
  }
}

Card pickCard(ArrayList<Card> list) {
  int index = (int) random(list.size());
  Card card = list.get(index);
  list.remove(index);

  return card;
}
