def while : cmd bool -> cmd unit -> cmd unit = \test. \body.
  b <- test;
  if b {body; while test body} {}
end

def opposite : dir -> dir = \d. if (d == left) {right} {left} end

def pushUntilBlocked : cmd unit = try {push; pushUntilBlocked} {} end

def goToNook : dir -> int -> cmd unit = \d. \n.
  if (n == 0) {
    turn (opposite d); move; turn back
  } {
    turn d; pushUntilBlocked; goToNook d (n-1)
  }
end

def center : cmd unit =
  turn right; move; turn left; move; turn right; move; move
end

def assistant : int -> cmd unit = \n.
  goToNook left n;
  watch forward; wait 2048;
  if (n == 4)
    {push; push}
    { pushUntilBlocked; wait 2; try {move} {};
      goToNook left (3-n); move; move
    };
  center;
  goToNook right n;
  watch forward; wait 2048;
  pushUntilBlocked
end

def x : int -> cmd unit -> cmd unit = \n. \c.
  if (n == 0) {} {c ; x (n-1) c}
end

def for : int -> (int -> cmd unit) -> cmd unit = \n. \c.
  if (n == 0) {} {c n; for (n-1) c}
end

def solution : cmd unit =
  turn left; x 3 move; turn right;
  x 6 (pushUntilBlocked; turn back; move; turn right);
  x 6 (pushUntilBlocked; turn back; move; turn left);
  turn left; move; turn right;
  pushUntilBlocked;
  turn right; x 18 move; grab; equip "3D printer";
  turn back;
  pushUntilBlocked; turn left;
  pushUntilBlocked; turn back; x 2 move; turn right; pushUntilBlocked;
  for 5 (\k. build {assistant (k-1)}; return ());
  turn back; pushUntilBlocked; turn right; x 12 move; turn right; move; turn right;
  pushUntilBlocked;
  turn right; move; turn left; move; turn left; pushUntilBlocked;
  wait 10;
  x 5 (pushUntilBlocked; turn left);
  move; turn right; move; turn left; x 2 move; turn left; x 2 move; turn left; move; turn left;
  pushUntilBlocked;
  wait 10;
  x 6 (pushUntilBlocked; turn right);
  move; turn left; move; turn left; x 3 push
end
