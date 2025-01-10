def tR = turn right end

def tL = turn left end

def tB = turn back end

def m1 = move end

def m2 = m1; m1 end

def m3 = m2; m1 end

def m4 = m2; m2 end

def m5 = m3; m2 end

def m6 = m3; m3 end

def m7 = m4; m3 end

def m8 = m4; m4 end

def m9 = m5; m4 end

def m11 = m6; m5 end

def m12 = m6; m6 end

def m13 = m7; m6 end

def m14 = m7; m7 end

def m15 = m8; m7 end

def m29 = m15; m14 end

def m30 = m15; m15 end

def x2 = \c. c; c end

def x4 = \c. x2 c; x2 c end

def x8 = \c. x4 c; x4 c end

def x16 = \c. x8 c; x8 c end

def x32 = \c. x16 c; x16 c end

def x64 = \c. x32 c; x32 c end

def paired: Text -> Text 
  = \t.
  if (t == "thymine") {"adenine"} {
    if (t == "adenine") {"thymine"} {
      if (t == "cytosine") {"guanine"} {"cytosine"}
    }
  }
end

def changeSide: Cmd Unit = tR; m2; tR; m4; tL; m4; tL; m4; tR; m2; tR end

def complementAndCopy: Int -> Cmd Unit 
  = \n.
  if (n == 0) {changeSide; m1} {
    s <- scan left;
    case s (\_. pure ()) (
      \b. place (paired b);
      move;
      complementAndCopy (n - 1);
      place b;
      move
    )
  }
end

def pickup: Cmd Unit =
  wait 128;
  tL;
  m6;
  tL;
  m29;
  tL;
  m2;
  tL;
  m1;
  grab;
  tB;
  m1;
  tR;
  m2;
  tR;
  m29;
  tR;
  m6;
  tL
end

def button: Cmd Unit = m3; drill forward; tB; m3; tB end

def clone: Text -> Cmd Unit 
  = \thing.
  m5;
  place thing;
  tB;
  m5;
  tL;
  m4;
  tL;
  m1;
  wait 128;
  make "specimen slide";
  complementAndCopy 32;
  button;
  pickup;
  button;
  changeSide;
  tL;
  m4;
  tR
end

def solution: Cmd Unit =
  m6;
  grab;
  tB;
  m6;
  tR;
  m9;
  grab;
  m6;
  grab;
  tB;
  m15;
  m11;
  tR;
  x8 (use "siphon" forward; m1);
  x64 (make "cytosine");
  tB;
  m13;
  tR;
  m14;
  grab;
  tB;
  m14;
  m8;
  tR;
  m7;
  clone "dahlia";
  clone "daisy";
  clone "clover";
  clone "mushroom";
  pure ()
end