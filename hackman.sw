
def ifC : cmd bool -> {cmd a} -> {cmd a} -> cmd a = \test. \then. \else.
  b <- test; if b then else
end

def while : cmd bool -> {cmd a} -> cmd unit = \test. \body.
  ifC test {force body ; while test body} {}
end

def unless = \test. \then. \else. ifC test else then end

def until = \test. \body.
  ifC test {} {force body ; until test body}
end

def elsif = \p. \then. \else. {if p then else} end
def elsifC = \p. \then. \else. {ifC p then else} end

def forever : cmd a -> cmd b = \c.
  c; forever c
end

def inverseDir : dir -> dir = \d.
  if (d == left) {right} {if (d == right) {left} {d}}
end

def isBlocked : dir -> cmd bool = \d.
  turn d;
  b <- blocked;
  turn (inverseDir d);
  return b
end

def followLeft =
  unless (isBlocked left) {turn left}
  { unless (isBlocked forward) {}
    { unless (isBlocked right) {turn right} {turn back} } };
  move
end

def followRight =
  unless (isBlocked right) {turn right}
  { unless (isBlocked forward) {}
    { unless (isBlocked left) {turn left} {turn back} } };
  move
end

def isFood = \x. x == inr "pellet" || x == inr "donut" end

def isFoodTo = \d. res <- scan d; return (isFood res) end

def stepToFood =
  ifC (isFoodTo left) {turn left; move}
  $ elsifC (isFoodTo forward) {move}
  $ elsifC (isFoodTo right) {turn right; move}
  $ elsifC (isFoodTo back) {turn back; move} {}
end

def followFood = while (isFoodTo down) { grab; stepToFood } end

def eatAll =
  forever (
    until (isFoodTo down) { followRight; followLeft; followLeft; stepToFood };
    followFood
  )
end
