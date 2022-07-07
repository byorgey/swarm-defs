def forever : {cmd a} -> cmd b = \c.
  force c; forever c
end

def ifC : cmd bool -> {cmd a} -> {cmd a} -> cmd a = \test. \then. \else.
  b <- test; if b then else
end

def busyWhile = \tst. ifC tst {busyWhile tst} {} end
def busyUntil = \tst. ifC tst {} {busyUntil tst} end

def x2 = \c. c; c end
def x4 = \c. x2 (x2 c) end
def x16 = \c. x4 (x4 c) end

// Doesn't seem to cause a race condition...
def frenzy = x16 (
    build {
      require 1 "tree";
      forever {
        busyWhile (ishere "tree");
        place "tree";
        n <- random 8;
        wait n;
        busyUntil (ishere "tree");
        grab
      }
    }
  )
end
