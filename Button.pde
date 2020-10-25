class Button {
  int type, x, y, w, h;

  Button(int type) {
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

  boolean mouseOn() {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h)
      return true;
    return false;
  }
  
  void action() {
    
  }
}
