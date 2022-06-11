// Old bitrotted stuff, keeping it just for reference

def m2 = move;move end
def m4 = m2;m2 end
def m8 = m4;m4 end
def m16 = m8;m8 end
def h = move;grab end
def h2 = h;h end
def tocop = m8;m2;turn right; m4 end
def harvestcop = h;h;h; turn back;m2;turn left end
def gc = give "base" "copper ore" end
def cop = tocop; harvestcop; tocop; move; gc; gc; gc end
def copadj = move; turn left; move; turn right end
def cop2 = tocop; copadj; h2; h; turn back; m2; move; copadj; turn left; tocop; gc; gc; gc end
def gr = give "base" "rock" end
def rocks1 = turn north; m2; move; turn west; m8; m4; m4; grab; m2; grab; m2; move; grab; turn back; m16; m4; move; turn right; m2; move; gr; gr; gr end
def rocks2 = turn west; m8; m4; m2; turn south; move; h2; h; turn north; m4; turn east; m8; m4; m2; gr; gr; gr end
def gt = give "base" "tree" end
def gt2 = gt; gt end
def trees = turn west; m4; move; h2; h2; h2; turn east; m8; m2; move; gt2; gt2; gt2 end
def gl = give "base" "lambda" end
def lambdas = turn east; m4; m2; move; turn north; m16; m2; grab; turn right; move; turn left; move; grab; move; turn left; move; grab; turn south; m16; m4; turn west; m4; m2; move; gl; gl; gl end
def tobit1 = m16; m8; m4; m2; turn right; m4 end
def bit1 = turn west; tobit1; grab; turn east; tobit1; give "base" "bit (1)" end
def tobit0 = m16; m16; m2; turn left; m8; m2; move end
def bit0 = turn west; tobit0; grab; turn east; tobit0; give "base" "bit (0)" end
def x2 = \c. c;c end
def x4 = \c. x2 c; x2 c end
def x8 = \c. x4 c; x4 c end
def x16 = \c. x8 c; x8 c end
def x32 = \c. x16 c; x16 c end
def x64 = \c. x32 c; x32 c end
def x128 = \c. x64 c; x64 c end
def x256 = \c. x128 c; x128 c end
def x512 = \c. x256 c; x256 c end
def x1024 = \c. x512 c; x512 c end
def craft = make "furnace"; (let lg = make "log" in lg;lg;lg;lg;lg); make "copper wire"; x4 (make "strange loop"); make "branch predictor"; x4 (make "board") end
// ; x2 (make "boat")
def forever : cmd () -> cmd () = \c. c ; forever c end
def harvest_lambdas : cmd () = forever (lambdas; wait 1280) end
def ifC : forall a. cmd bool -> cmd a -> cmd a -> cmd a =
  \test. \thn. \els. b <- test; if b thn els end
def dfs : cmd () = {
  ifC (ishere "tree") {
    grab;
    turn west;
    ifC blocked {} {move; dfs; turn east; move};
    turn north;
    ifC blocked {} {move; dfs; turn south; move};
  } {}
}
end
def while : cmd bool -> cmd () -> cmd () =
  \test. \body. ifC test {body ; while test body} {} end
def forest : cmd () = {
  turn south; move; turn west; m4; move; dfs; turn east; m4; move; turn north; move; x64 (give "base" "tree")
}
end
def harvest_forest : cmd () = forever {forest; wait 1024} end
def harvest_bits : cmd () = forever {
  bit0;
  wait 512;
  bit1;
  wait 512
}
end
def build_harvesters : cmd () = {
  build "hf" {{harvest_forest}};
  build "hl" {{harvest_lambdas}};
  build "hb" {{harvest_bits}};
  return ()
}
end
// def buildB = \n. \c.
//   n_ <- build n {wait 1; c};
//   install n_ "boat";
//   return n_
// end
def gotoX : int -> cmd () = \tgt.
  cur <- whereami;
  if (fst cur == tgt)
    {}
    (if (fst cur < tgt)
       {turn east}
       {turn west};
     try move {turn south; move};
     gotoX tgt
    )
end
def gotoY : int -> cmd () = \tgt.
  cur <- whereami;
  if (snd cur == tgt)
    {}
    (if (snd cur < tgt)
       {turn north}
       {turn south};
     try move {turn east; move};
     gotoY tgt
    )
end
def goto : int -> int -> cmd () = \x. \y. gotoX x; gotoY y; gotoX x; gotoY y end
def toWater = {turn right; m2; turn right; m16; m4; m2; move} end
def startup =
  build "t" {{trees; selfdestruct}};
  build "c" {{cop; selfdestruct}};
  build "c" {{cop2; selfdestruct}};
  build "r" {{rocks1; selfdestruct}};
  build "r" {{rocks2; selfdestruct}};
  build "l" {{lambdas; selfdestruct}};
  wait 64;
  craft;
  // wait 2000;
  // build_harvesters
end
