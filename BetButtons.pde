class BetButton extends Button {
  boolean add;

  BetButton(boolean add) {
    this.add = add;
    s = 2;

    if (!add) {
      x = width/2 - max(("  " + betting).length() * 15, 90) - 75;
      text = "-";
    } else {
      x = width/2 + max(("  " + betting).length() * 15, 90) + 15;
      text = "+";
    }
    y = height/2 - 30;

    w = 60;
    h = 60;
  }

  void newX() {
    if (!add) 
      x = width/2 - max(("  " + betting).length() * 15, 90) - 75;
    else
      x = width/2 + max(("  " + betting).length() * 15, 90) + 15;
  }

  void action() {
    if (add) 
      betting+= 5;
    else 
    betting-= 5;

    betting = constrain(betting, max(CURRENT_BET * 2, MIN_BET), players.get(TURN).balance);

    for (BetButton b : betButtons)
      b.newX();
  }
}

class SubmitButton extends Button {
  SubmitButton() {
    s = 2;
    text = "Bet";
    x = width/2 - 120;
    y = height/2 + 45;
    w = 240;
    h = 50;
  }

  void action() {
    players.get(TURN).bet(betting);
    CURRENT_BET = betting;
    
    scene = 1;
    TURN++;
    if (TURN == players.size()) {
      TURN = 0;
      endRound();
    }
  }
}

class ExitButton extends Button {
  ExitButton() {
    s = 2;
    text = "X";
    x = width - 75;
    y = 15;
    w = 60;
    h = 60;
  }

  void action() {
    scene = 1;
  }
}