class GameButton extends Button {
  final int type;

  GameButton(int type) {
    s = 1;
    this.type = type;
    switch(type) {
    case 0:
      x = 7*width/10 - 15;
      y = 5*height/6 + 15;
      break;
    case 1:
      x = 8*width/10 - 15;
      y = 5*height/6 + 15;
      break;
    case 2:
      x = 9*width/10 - 15;
      y = 5*height/6 + 15;
      break;
    default:
      x = 0;
      y = 0;
      break;
    }
    w = width/10 - 30;
    h = height/6 - 30;
  }

  void show() {
    if (mouseOn()) {
      stroke(#cccc00);
      strokeWeight(5);
    } else {
      stroke(#afafaf);
      strokeWeight(3);
    } 

    fill(#cc0000);
    rectMode(CORNER);
    rect(x, y, w, h);

    textAlign(CENTER, CENTER);
    textSize(height/24);
    fill(255);
    text(showText(), x + w/2, y + h/2);
  }

  String showText() {
    switch(type) {
    case 0:
      if (CURRENT_BET == 0)
        return "Check";
      else
        return "Call";
    case 1:
      if (CURRENT_BET == 0)
        return "Bet";
      else
        return "Raise";
    case 2:
      return "Fold";
    default:
      return "Error";
    }
  }

  void action() {
    switch(type) {
    case 0:
      if (CURRENT_BET == 0) {
        endTurn();
      } else {
        betting = max(CURRENT_BET, MIN_BET);
        scene = 2;
        raising = false;
      }
      break;
    case 1:
      betting = max(CURRENT_BET * 2, MIN_BET);
      scene = 2;
      raising = true;
      break;
    case 2:
      players.get(TURN).folded = true;
      endTurn();
      break;
    }
  }
}
