ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Card> cards = new ArrayList<Card>();
ArrayList<Card> table = new ArrayList<Card>();

int CURRENT_BET, TURN, MIN_BET, TOTAL_BET, ANTI;

// Local
GameButton[] gameButtons = new GameButton[3];
BetButton[] betButtons = new BetButton[2];
SubmitButton subBut;
ExitButton eBut;
int scene, betting = 0, timeDown = 0;
boolean changed = false, calling = false;

void setup() {
  fullScreen();

  TOTAL_BET = 0;
  CURRENT_BET = 0;
  TURN = 0;
  MIN_BET = 25;
  ANTI = 10;

  scene = 1;
  subBut = new SubmitButton();
  eBut = new ExitButton();

  for (int i = 0; i < 2; i++)
    players.add(new Player(100));
    
  for (int i = 0; i < 2; i++)
    players.get(i).bet(ANTI);

  for (int s = 0; s < 4; s++)
    for (int n = 1; n < 14; n++)
      cards.add(new Card(s, n));

  for (int i = 0; i < players.size(); i++)
    players.get(i).drawCards();

  for (int i = 0; i < gameButtons.length; i++)
    gameButtons[i] = new GameButton(i);

  for (int i = 0; i < betButtons.length; i++)
    betButtons[i] = new BetButton(i == 1);
}

void draw() {
  switch(scene) {
  case 1:
    gameScene();
    break;
  case 2:
    betScene();
    break;
  }
}

void endRound() {
  if (table.size() == 0) {
    table.add(pickCard(cards, false, 0));
    table.add(pickCard(cards, false, 1));
    table.add(pickCard(cards, false, 2));
  } else if (table.size() < 5)
    table.add(pickCard(cards, false, table.size()));
}

Card pickCard(ArrayList<Card> list, boolean hand, int i) {
  int index = (int) random(list.size());
  Card card = list.get(index);
  list.remove(index);
  card.pick(hand, i);

  return card;
}
