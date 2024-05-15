def elif: ∀ a. Bool -> {a} -> {a} -> {a}
  = \b. \t. \e.
  {if b t e}
end

def fruit2bit: Text -> Int
  = \t.
  if (t == "apple") {1} $ elif (t == "blueberry") {
    2
  } $ elif (t == "dragonfruit") {4} $ elif (t == "grape") {
    8
  } $ elif (t == "lemon") {16} $ elif (t == "orange") {32} {
    64 // watermelon

  }
end

def bit2fruit: Int -> Text
  = \bit.
  if (bit == 1) {"apple"} $ elif (bit == 2) {
    "blueberry"
  } $ elif (bit == 4) {"dragonfruit"} $ elif (bit == 8) {
    "grape"
  } $ elif (bit == 16) {"lemon"} $ elif (bit == 32) {
    "orange"
  } {"watermelon"}
end

def while = \p. \c. b <- p; if b {c; while p c} {} end

def until = \p. \c. b <- p; if b {} {c; until p c} end

def readCombo: Cmd Int =
  r <- scan down;
  case r (\_. return 0) (
    \fruit. harvest;
    move;
    n <- readCombo;
    return (fruit2bit fruit + n)
  )
end

def scanCombo: Cmd Int =
  turn left;
  move;
  n <- readCombo;
  turn back;
  until (ishere "sand") move;
  turn left;
  move;
  return n
end

def sumCombosR: Int -> Cmd Int
  = \curSum.
  b <- ishere "sand";
  if b {m <- scanCombo; sumCombosR (curSum + m)} {
    return curSum
  }
end

def sumCombos: Cmd Int = move; sumCombosR 0 end

def mod: Int -> Int -> Int = \x. \m. x - m * (x / m) end

def plantCombo: Int -> Int -> Cmd Unit
  = \combo. \curBit.
  if (combo == 0) {place "bell"} {
    if (mod combo 2 == 1) {
      place (bit2fruit curBit);
      move
    } {};
    plantCombo (combo / 2) (curBit * 2)
  }
end

def solution =
  s <- sumCombos;
  turn back;
  move;
  turn right;
  move;
  plantCombo (8001 - s) 1
end
