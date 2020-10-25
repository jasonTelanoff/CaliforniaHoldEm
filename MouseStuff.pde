void mouseClicked() {
  for (Button b : buttons)
    if (b.mouseOn())
      b.action();
}
