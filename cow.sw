def ifC: ∀ a. Cmd Bool -> {Cmd a} -> {Cmd a} -> Cmd a 
  = \test. \then. \else.
  b <- test;
  if b then else
end

def orC: Cmd Bool -> Cmd Bool -> Cmd Bool 
  = \t1. \t2.
  b1 <- t1;
  b2 <- t2;
  pure (b1 || b2)
end

def until = \test. \body. ifC test {} {force body; until test body} end

def x3 = \c. c; c; c end

def w = \c. ifC (ishere "capital W") {turn back; x3 (drill down; move)} {c} end

def o = \c. ifC (ishere "capital O") {try {move; w c} {c}} {c} end

def c =
  ifC (orC isempty blocked) {
    ifC isempty {turn back; move} {turn back};
    try {until isempty {move}; turn back; move} {turn back};
    turn right;
    move;
    turn left;
    ifC isempty {turn left; move; c} {c}
  } {ifC (ishere "capital C") {move; o c} {move; c}}
end

def sol = move; move; turn left; move; move; move; move; turn right; c end