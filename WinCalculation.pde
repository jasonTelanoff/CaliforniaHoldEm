void calcWin() {
  int hI = 0;
  int hS = 0;

  for (Player p : players) {
    if (!p.folded) {
      int score = calcScore(p);
      if (score > hS) {
        hS = score;
        hI = p.i;
      } else if (score == hS) {
        Card[] hand = fullHand(p.hand);
        Card[] hand2 = fullHand(players.get(hI).hand);

        quickSort(hand, 0, hand.length - 1);
        quickSort(hand2, 0, hand2.length - 1);

        for (int i = hand.length - 1; i >= 0; i--) {
          if (hand[i].num > hand2[i].num) {
            hS = score;
            hI = p.i;
            break;
          } else if (hand[i].num < hand2[i].num)
            break;
        }
      }
    }
  }

  println("Highest Score : " + hS);
}

int winByFold() {
  Player _p = null;

  for (Player p : players)
    if (!p.folded)
      if (_p == null)
        _p = p;
      else return -1;


  if (_p != null)
    return _p.i;
  return -1;
}

int calcScore(Player p) {
  int score = 0;

  Card[] hand = fullHand(p.hand);

  if (straight(hand))
    score = 4;
  if (_flush(hand))
    if (score == 4)
      score = 8;
    else
      score = 5;
  else if (onePair(hand))
    if (threeKind(hand) != -1)
      if (fourKind(hand))
        score = 7;
      else if (fullHouse(hand))
        score = 6; 
      else
        score = 3;
    else if (twoPair(hand))
      score = 2;
    else
      score = 1;

  return score;
}

int[] highCard(Card[] c) {
  int[] nums = {2, 2}; 
  return nums;
}

boolean onePair(Card[] c) {
  for (int n = 0; n < c.length; n++)
    for (int i = n + 1; i < c.length; i++)
      if (c[n].num == c[i].num)
        return true;
  return false;
}

boolean twoPair(Card[] c) {
  int numUsed = -1;
  for (int n = 0; n < c.length; n++) {
    if (c[n].num != numUsed)
      for (int i = n + 1; i < c.length; i++)
        if (c[n].num == c[i].num) {
          if (numUsed != -1)
            return true;
          numUsed = c[n].num;
        }
  }
  return false;
}

int threeKind(Card[] c) {
  int val;
  for (int n = 0; n < c.length; n++) {
    int amount = 0;
    val = n;
    for (int i = n + 1; i < c.length; i++)
      if (c[n].num == c[i].num) {
        if (amount == 1)
          return val;
        amount++;
      }
  }
  return -1;
}

boolean straight(Card[] _c) {
  quickSort(_c, 0, _c.length - 1);

  int ones = 0;
  for (Card c : _c)
    if (c.num == 1)
      ones++;
  Card[] c = new Card[_c.length + ones];

  for (int i = 0; i < _c.length; i++)
    c[i] = _c[i];
  for (int i = _c.length; i < c.length; i++)
    c[i] = new Card(0, 14);

  for (int n = 0; n < c.length - 4; n++)
    for (int i = n; i < n + 4; i++)
      if (c[i].num + 1 == c[i+1].num) {
        if (i == n + 3)
          return true;
      } else break;

  return false;
}


boolean _flush(Card[] c) {
  for (int n = 0; n < c.length - 4; n++)
    for (int i = n; i < n + 4; i++)
      if (c[i].suit != c[i + 1].suit)
        break; 
      else if (i == n + 3)
        return true; 
  return false;
}

boolean fullHouse(Card[] c) {  
  int val = threeKind(c); 
  for (int n = 0; n < c.length; n++)
    if (n != val)
      for (int i = n + 1; i < c.length; i++)
        if (c[n].num == c[i].num)
          return true; 
  return false;
}

boolean fourKind(Card[] c) {
  for (int n = 0; n < c.length; n++) {
    int amount = 0; 
    for (int i = n + 1; i < c.length; i++)
      if (c[n].num == c[i].num) {
        if (amount == 2)
          return true; 
        amount++;
      }
  }
  return false;
}

void quickSort(Card[] arr, int start, int end) {
  if (start < end) {
    int index = partition(arr, start, end); 
    quickSort(arr, start, index - 1); 
    quickSort(arr, index + 1, end);
  }
}

int partition(Card[] arr, int start, int end) {
  int pivotIndex = start; 
  float pivotValue = arr[end].num; 
  for (int i =start; i < end; i++) {
    if (arr[i].num < pivotValue) {
      swap(arr, i, pivotIndex++);
    }
  }
  swap(arr, pivotIndex, end); 
  return pivotIndex;
}

void swap(Card[] arr, int a, int b) {
  Card temp = arr[a]; 
  arr[a] = arr[b]; 
  arr[b] = temp;
}

Card[] fullHand(Card[] _hand) {
  Card[] hand = new Card[2 + table.size()];
  hand[0] = _hand[0];
  hand[1] = _hand[1];
  for (int i = 2; i < hand.length; i++)
    hand[i] = table.get(i - 2);

  return hand;
}
