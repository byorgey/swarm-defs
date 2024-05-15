def x3: Cmd Unit -> Cmd Unit = \c. c; c; c end

def m4 = move; move; move; move end

def m3 = move; move; move end

def blocked_left: Cmd Bool =
  r <- scan left;
  case r (\_. return false) (\_. return true)
end

def try_all: Int -> Cmd Unit
  = \n.
  if (n == 0) {} {
    x3 (
      b <- blocked_left;
      if b {
        move;
        try_all (n - 1);
        turn back;
        move;
        turn back;
        drill down;
        return ()
      } {}
    )
  }
end

def next = turn left; m4; turn right end

def solve =
  m3;
  try_all 3;
  next;
  try_all 4;
  next;
  try_all 5;
  next;
  try_all 6;
  turn left;
  m3;
  turn right;
  move;
  move;
  grab
end
