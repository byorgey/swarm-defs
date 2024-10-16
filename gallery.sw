def sorted: Cmd Bool =
  s1 <- scan down;
  move;
  s2 <- scan down;
  res <- case s1 (\_. return true) (
    \p1. case s2 (\_. return true) (
      \p2. n1 <- count p1;
      n2 <- count p2;
      return (n1 < n2)
    )
  );
  turn back;
  move;
  turn back;
  return res
end

def swapnext: Cmd Unit =
  turn right;
  move;
  turn back;
  push;
  turn right;
  move;
  move;
  turn back;
  push;
  turn right;
  move;
  turn left;
  move;
  move;
  turn back;
  push;
  turn left;
  move;
  turn right;
  move;
  turn right;
  push;
  move;
  turn left
end

def nonempty: Cmd Bool =
  s <- scan down;
  case s (\_. return false) (\_. return true)
end

def while: Cmd Bool -> Cmd Unit -> Cmd Unit
  = \p. \body.
  b <- p;
  if b {body; while p body} {}
end

def bubblepass: Cmd Unit =
  while nonempty (s <- sorted; if s {move} {swapnext})
end

def bubblesort: Cmd Unit =
  while nonempty (
    bubblepass;
    turn back;
    move;
    while nonempty move;
    turn back;
    move
  )
end

def solution: Cmd Unit = move; move; move; bubblesort end
