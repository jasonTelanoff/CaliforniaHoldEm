void mousePressed() {
  switch(scene) {
  case 1:
    for (GameButton b : gameButtons)
      if (b.mouseOn())
        b.action();
    break;
  case 2:
    if (subBut.mouseOn())
      subBut.action();
    if (eBut.mouseOn())
      eBut.action();
    changed = false;
    timeDown = 0;
    break;
  case 3:
    if (confFold.mouseOn())
      confFold.action();
    else
      scene = 1;
    break;
  default:
    scene = 1;
  }
}

//void mouseReleased() {
//  switch(scene) {
//  case 2:
//    timeDown = 0;
//    break;
//  }
//}
