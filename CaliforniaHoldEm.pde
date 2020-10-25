ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Card> cards = new ArrayList<Card>();
ArrayList<Card> table = new ArrayList<Card>();

int CURRENT_BET, TURN;

// Local
Button[] buttons = new Button[3];


void setup() {
  fullScreen();
  
  CURRENT_BET = 0;
  TURN = 0;
  
  players.add(new Player(100));

  for (int s = 0; s < 4; s++)
    for (int n = 1; n < 14; n++)
      cards.add(new Card(s, n));

  for (int i = 0; i < players.size(); i++)
    players.get(0).drawCards();
  
  for(int i = 0; i < buttons.length; i++)
    buttons[i] = new Button(i);
}

void draw() {
  background(#23A039);
  
  for (int i = 0; i < players.get(0).hand.size(); i++)
    players.get(0).hand.get(i).show();
  
  for (int i = 0; i < table.size(); i++)
    table.get(i).show();
    
  for(Button b : buttons)
    b.show();
    
  fill(#ffff00);
  textAlign(LEFT, TOP);
  textSize(50);
  text("$" + players.get(0).balance, 15, 15);
}

void endRound() {
  if(table.size() == 0) {
    table.add(pickCard(cards, false, 0));
    table.add(pickCard(cards, false, 1));
    table.add(pickCard(cards, false, 2));
  } else if(table.size() < 5)
    table.add(pickCard(cards, false, table.size()));
}

Card pickCard(ArrayList<Card> list, boolean hand, int i) {
  int index = (int) random(list.size());
  Card card = list.get(index);
  list.remove(index);
  card.pick(hand, i);

  return card;
}
