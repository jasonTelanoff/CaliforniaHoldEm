void gameScene() {
  background(#23A039);

  for (int i = 0; i < players.get(TURN).hand.size(); i++)
    players.get(TURN).hand.get(i).show();

  for (int i = 0; i < table.size(); i++)
    table.get(i).show();

  for (GameButton b : gameButtons)
    b.show();

  fill(#ffff00);
  textAlign(LEFT, TOP);
  textSize(50);
  text("$" + players.get(TURN).balance, 15, 15);

  textAlign(CENTER, CENTER);
  textSize(height/4);
  text("$" + TOTAL_BET, width/2, height/2);
}

void betScene() {
  if (!calling) betUpdate();
  gameScene();

  fill(100, 150);
  noStroke();
  rect(0, 0, width, height);

  fill(120, 180);
  stroke(125, 180);
  rectMode(CENTER);
  rect(width/2, height/2, max(("  " + betting).length() * 30, 180), 60);

  if (!calling)
    for (BetButton b : betButtons)
      b.show();

  subBut.show();
  eBut.show();

  textAlign(CENTER, CENTER);
  fill(255, 255, 0, 120);
  textSize(40);
  text("$" + betting, width/2, height/2);
}

void betUpdate() {
  if (mousePressed && (timeDown > 20 || !changed)) {
    changed = true;
    for (BetButton b : betButtons)
      if (b.mouseOn()) 
        b.action();
  } else if (!mousePressed && changed) {
    changed = false;
    timeDown = 0;
  } else
    timeDown++;
}
