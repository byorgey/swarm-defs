def mod = \a. \b. a - b * (a / b) end

def forever = \c. c; forever c end

def x4 = \c. c; c; c; c end

def drill_mound
  = \d.
  h <- scan d;
  if (h == inr "mound") {drill d; return ()} {}
end

def gopher_turret =
  forever (
    x4 (turn left; drill_mound forward);
    drill_mound down
  )
end

def idoN_rec: Int -> Int -> (Int -> Cmd Unit) -> Cmd Unit
  = \k. \n. \c.
  if (k == n) {} {c k; idoN_rec (k + 1) n c}
end

def idoN: Int -> (Int -> Cmd Unit) -> Cmd Unit = idoN_rec 0
end

def doN: Int -> Cmd Unit -> Cmd Unit
  = \n. \c.
  idoN n (\_. c)
end

def place_turret
  = \row. \col.
  if (mod (2 * row + col) 5 == 0) {
    build {gopher_turret};
    return ()
  } {}
end

def carpet_row
  = \r.
  idoN 28 (\c. place_turret r c; move);
  turn back;
  doN 28 move;
  turn left;
  move;
  turn left
end

def carpet = idoN 19 carpet_row end
