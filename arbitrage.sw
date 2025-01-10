def opposite: Dir -> Dir = \d. if (d == left) {right} {left} end

def x: Int -> Cmd Unit -> Cmd Unit = \n. \c. if (n == 0) {} {c; x (n - 1) c} end

def m5 = x 5 move end

def goTrade = m5; drill down; pure () end

def fig8half: Dir -> Cmd Unit = \d. x 3 (turn d; goTrade); goTrade end

def fig8: Dir -> Cmd Unit 
  = \d.
  turn back;
  fig8half (opposite d);
  fig8half d;
  turn back
end

def m2 = move; move end

def solution =
  m5;
  x 5 (grab; m2);
  x 2 (turn left; m2);
  m5;
  turn right;
  x 10 (fig8 right);
  x 8 (fig8 left)
end

solution