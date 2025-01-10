def tL = turn left end

def tR = turn right end

def tB = turn back end

def tN = turn north end

def tE = turn east end

def tS = turn south end

def tW = turn west end

def x0 = \c. noop end

def x1 = \c. c end

def x2 = \c. c; c end

def x3 = \c. c; x2 c end

def x4 = \c. x2 c; x2 c end

def m0 = noop end

def m1 = move end

def m2 = m1; m1 end

def m3 = m1; m2 end

def m4 = m2; m2 end

def m5 = m1; m4 end

def m6 = m3; m3 end

def m7 = m1; m6 end

def m8 = m4; m4 end

def m9 = m1; m8 end

def m10 = m5; m5 end

def m11 = m1; m10 end

def m12 = m6; m6 end

def m13 = m1; m12 end

def m14 = m7; m7 end

def m15 = m1; m14 end

def m16 = m8; m8 end

def buildBeehive =
  x4 (x4 (place "board"; move); turn right);
  move;
  tR;
  x3 (x3 (move; place "honey frame"); tB; m3; tR; m1; tR)
end