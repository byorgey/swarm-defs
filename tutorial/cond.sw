def x4 = \c. c;c;c;c end

def tR = turn right end
def tL = turn left end
def tB = turn back end

def m =
  move;
  b <- ishere "very small rock";
  if b {grab; pure ()} {}
end

def col = move; tR; x4 m; tB; x4 move; tR end

def sol = build {
  tR; x4 col; tB; x4 move; x4 (give base "very small rock")
}
end
