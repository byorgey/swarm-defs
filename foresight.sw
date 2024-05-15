def while: Cmd Bool -> Cmd Unit -> Cmd Unit
  = \test. \body.
  b <- test;
  if b {body; while test body} {}
end

def opposite: Dir -> Dir = \d. if (d == left) {right} {left}
end

def pushUntilBlocked: Cmd Unit =
  try {push; pushUntilBlocked} {}
end

def goToNook: Dir -> Int -> Cmd Unit
  = \d. \n.
  if (n == 0) {turn (opposite d); move; turn back} {
    turn d;
    pushUntilBlocked;
    goToNook d (n - 1)
  }
end

def center: Cmd Unit =
  turn right;
  move;
  turn left;
  move;
  turn right;
  move;
  move
end

def assistant: Int -> Cmd Unit
  = \n.
  goToNook left n;
  watch forward;
  wait 2048;
  if (n == 4) {push; push} {
    pushUntilBlocked;
    wait 2;
    try {move} {};
    goToNook left (3 - n);
    move;
    move
  };
  center;
  goToNook right n;
  watch forward;
  wait 2048;
  pushUntilBlocked
end

def x: Int -> Cmd Unit -> Cmd Unit
  = \n. \c.
  if (n == 0) {} {c; x (n - 1) c}
end

def for: Int -> (Int -> Cmd Unit) -> Cmd Unit
  = \n. \c.
  if (n == 0) {} {c n; for (n - 1) c}
end

def solution: Cmd Unit =
  turn left;
  x 3 move;
  turn right;
  x 6 (pushUntilBlocked; turn back; move; turn right);
  x 6 (pushUntilBlocked; turn back; move; turn left);
  turn left;
  move;
  turn right;
  pushUntilBlocked;
  turn right;
  x 18 move;
  grab;
  equip "3D printer";
  turn back;
  pushUntilBlocked;
  turn left;
  pushUntilBlocked;
  turn back;
  x 2 move;
  turn right;
  pushUntilBlocked;
  for 5 (\k. build {assistant (k - 1)}; return ());
  turn back;
  pushUntilBlocked;
  turn right;
  x 12 move;
  turn right;
  move;
  turn right;
  pushUntilBlocked;
  turn right;
  move;
  turn left;
  move;
  turn left;
  pushUntilBlocked;
  wait 10;
  x 5 (pushUntilBlocked; turn left);
  move;
  turn right;
  move;
  turn left;
  x 2 move;
  turn left;
  x 2 move;
  turn left;
  move;
  turn left;
  pushUntilBlocked;
  wait 10;
  x 6 (pushUntilBlocked; turn right);
  move;
  turn left;
  move;
  turn left;
  x 3 push
end
