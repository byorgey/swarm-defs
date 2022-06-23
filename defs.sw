// Turn and move abbreviations

def tL = turn left end
def tR = turn right end
def tB = turn back end
def tN = turn north end
def tE = turn east end
def tS = turn south end
def tW = turn west end

def mg = move; grab end

def m1 = move end
def m2 = m1;m1 end
def m3 = m1;m2 end
def m4 = m2;m2 end
def m5 = m1;m4 end
def m6 = m3;m3 end
def m7 = m1;m6 end
def m8 = m4;m4 end
def m9 = m1;m8 end
def m10 = m5;m5 end
def m11 = m1;m10 end
def m12 = m6;m6 end
def m13 = m1;m12 end
def m14 = m7;m7 end
def m15 = m1;m14 end
def m16 = m8;m8 end
def m17 = m1;m16 end
def m18 = m9;m9 end
def m19 = m1;m18 end
def m20 = m10;m10 end
def m21 = m1;m20 end
def m22 = m11;m11 end
def m23 = m1;m22 end
def m24 = m12;m12 end
def m25 = m1;m24 end
def m26 = m13;m13 end
def m27 = m1;m26 end
def m28 = m14;m14 end
def m29 = m1;m28 end
def m30 = m15;m15 end
def m31 = m1;m30 end
def m32 = m16;m16 end
def m33 = m1;m32 end
def m34 = m17;m17 end
def m35 = m1;m34 end
def m36 = m18;m18 end
def m37 = m1;m36 end
def m38 = m19;m19 end
def m39 = m1;m38 end
def m40 = m20;m20 end
def m41 = m1;m40 end
def m42 = m21;m21 end
def m43 = m1;m42 end
def m44 = m22;m22 end
def m45 = m1;m44 end
def m46 = m23;m23 end
def m47 = m1;m46 end
def m48 = m24;m24 end
def m49 = m1;m48 end
def m50 = m25;m25 end
def m51 = m1;m50 end
def m52 = m26;m26 end
def m53 = m1;m52 end
def m54 = m27;m27 end
def m55 = m1;m54 end
def m56 = m28;m28 end
def m57 = m1;m56 end
def m58 = m29;m29 end
def m59 = m1;m58 end
def m60 = m30;m30 end
def m61 = m1;m60 end
def m62 = m31;m31 end
def m63 = m1;m62 end
def m64 = m32;m32 end

// Startup

def scan1 =
  m1; tR;
  scan down; scan left; m1;
  scan down; scan left; scan forward; tR; m1;
  scan down; scan left; m1;
  scan down; scan left; scan forward; tR; m1;
  scan down; scan left; m1;
  scan down; scan left; scan forward; tR; m1;
  scan down; scan left; m1;
  scan down; scan left; scan forward; tR; m1;
  upload base;
  tR; m1
end

def scan2 =
  m2; tR;
  scan left; m1;
  scan left; m1;
  scan left; tR; m1;
  scan left; m1;
  scan left; m1;
  scan left; m1;
  scan left; tR; m1;
  scan left; m1;
  scan left; m1;
  scan left; m1;
  scan left; tR; m1;
  scan left; m1;
  scan left; m1;
  scan left; m1;
  scan left; tR; m1;
  scan left; m1;
  tR; m1; m1;
  upload base;
end

def startup =
  build {scan1}; build {scan2};
  build {salvage};
  wait 2;
  build {salvage; give base "plasma cutter"};
  wait 16;
  install base "plasma cutter";
  salvage;
  wait 16; salvage; salvage
end

// Repetition

def x1 = \c. c end
def x2 = \c. c; c end
def x3 = \c. c; x2 c end
def x4 = \c. x2 c; x2 c end
def x5 = \c. c; x4 c end
def x6 = \c. x3 c; x3 c end
def x7 = \c. c; x6 c end
def x8 = \c. x4 c; x4 c end
def x9 = \c. c; x8 c end
def x10 = \c. x5 c; x5 c end
def x11 = \c. c; x10 c end
def x12 = \c. x6 c; x6 c end
def x13 = \c. c; x12 c end
def x14 = \c. x7 c; x7 c end
def x15 = \c. c; x14 c end
def x16 = \c. x8 c; x8 c end
def x17 = \c. c; x16 c end
def x18 = \c. x9 c; x9 c end
def x19 = \c. c; x18 c end
def x20 = \c. x10 c; x10 c end
def x21 = \c. c; x20 c end
def x22 = \c. x11 c; x11 c end
def x23 = \c. c; x22 c end
def x24 = \c. x12 c; x12 c end
def x25 = \c. c; x24 c end
def x26 = \c. x13 c; x13 c end
def x27 = \c. c; x26 c end
def x28 = \c. x14 c; x14 c end
def x29 = \c. c; x28 c end
def x30 = \c. x15 c; x15 c end
def x31 = \c. c; x30 c end
def x32 = \c. x16 c; x16 c end
def x33 = \c. c; x32 c end
def x34 = \c. x17 c; x17 c end
def x35 = \c. c; x34 c end
def x36 = \c. x18 c; x18 c end
def x37 = \c. c; x36 c end
def x38 = \c. x19 c; x19 c end
def x39 = \c. c; x38 c end
def x40 = \c. x20 c; x20 c end
def x41 = \c. c; x40 c end
def x42 = \c. x21 c; x21 c end
def x43 = \c. c; x42 c end
def x44 = \c. x22 c; x22 c end
def x45 = \c. c; x44 c end
def x46 = \c. x23 c; x23 c end
def x47 = \c. c; x46 c end
def x48 = \c. x24 c; x24 c end
def x49 = \c. c; x48 c end
def x50 = \c. x25 c; x25 c end
def x51 = \c. c; x50 c end
def x52 = \c. x26 c; x26 c end
def x53 = \c. c; x52 c end
def x54 = \c. x27 c; x27 c end
def x55 = \c. c; x54 c end
def x56 = \c. x28 c; x28 c end
def x57 = \c. c; x56 c end
def x58 = \c. x29 c; x29 c end
def x59 = \c. c; x58 c end
def x60 = \c. x30 c; x30 c end
def x61 = \c. c; x60 c end
def x62 = \c. x31 c; x31 c end
def x63 = \c. c; x62 c end
def x64 = \c. x32 c; x32 c end

// cmd monad

def fmap : (a -> b) -> cmd a -> cmd b = \f. \x.
  a <- x; return (f a)
end
def liftA2 : (a -> b -> c) -> cmd a -> cmd b -> cmd c = \f.\x.\y.
  a <- x;
  b <- y;
  return (f a b)
end

// Logic

def or = \x.\y. if x {x} {y} end

def orC = \xC.\yC. x <- xC; y <- yC; return (or x y) end

// Math

def abs : int -> int = \x. if (x < 0) {-x} {x} end

// Control

def ifC : cmd bool -> {cmd a} -> {cmd a} -> cmd a = \test. \then. \else.
  b <- test; if b then else
end

def forever : cmd a -> cmd b = \c.
  c; forever c
end

def repeat : int -> cmd a -> cmd () = \n. \c.
  if (n == 0) {} {c ; repeat (n-1) c}
end

def while : cmd bool -> cmd a -> cmd () = \test. \body.
  ifC test {body ; while test body} {}
end

def waitWhile = \test. while test noop end

def until = \test. while (fmap not test) end

def waitUntil = \test. until test noop end

def moveto = \thing. until (ishere thing) move end

// Movement

// Some movement commands.  Requires strange loop, calculator,
// comparator.

// Arbitrary orientation, requires compass.
def moveBy : int -> int -> cmd () = \dx. \dy.
  if (dx < 0) {tW} {tE}; repeat (abs dx) move;
  if (dy < 0) {tS} {tN}; repeat (abs dy) move
end

def moveTo : int -> int -> cmd () = \x. \y.
  loc <- whereami;
  let dx = x - fst loc in
  let dy = y - snd loc in
  moveBy dx dy
end

// Versions that assume robot is facing N as pre/postcondition.
// These do not require a compass.
def moveByN : int -> int -> cmd () = \dx. \dy.
  if (dy < 0) {tB} {}; repeat (abs dy) move; if (dy < 0) {tB} {};
  if (dx < 0) {tL} {tR}; repeat (abs dx) move; if (dx < 0) {tR} {tL};
end

def moveToN : int -> int -> cmd () = \x. \y.
  loc <- whereami;
  let dx = x - fst loc in
  let dy = y - snd loc in
  moveByN dx dy
end

// Harvesting/scanning

def scanAt = \to. \fro. \d.
  to;
  scan d;
  fro;
  upload base
end

def fetch = \to. \fro.
  to;
  thing <- grab;
  fro;
  give base thing
end

def harvestlineP = \rep. \pred.
  rep (
    ifC pred {grab; return ()} {};
    move
  );
  tB; rep move; tB
end
def harvestline = \rep. \thing. harvestlineP rep (ishere thing) end
def harvestboxP : dir -> (cmd () -> cmd ()) -> (cmd () -> cmd ()) -> cmd bool -> cmd () = \d. \rep1. \rep2. \pred.
  rep1 (
    harvestlineP rep2 pred;
    turn d; move; x3 (turn d)
  );
  x3 (turn d); rep1 move; turn d
end
def harvestbox : dir -> (cmd () -> cmd ()) -> (cmd () -> cmd ()) -> string -> cmd () = \d. \rep1. \rep2. \thing.
  harvestboxP d rep1 rep2 (ishere thing)
end

def bithere = liftA2 or (ishere "bit (0)") (ishere "bit (1)") end

def tend = \to. \fro. \thing.
  forever (
    to;
    until (ishere thing) (wait 16);
    grab;
    fro;
    give base thing
  )
end

def giveall : robot -> string -> cmd () = \r. \thing. while (has thing) (give r thing) end

def mg = move; grab end
def gt = give base "tree" end
def gc = give base "copper ore" end

def plant_garden : dir -> (cmd () -> cmd ()) -> (cmd () -> cmd ()) -> string -> cmd () = \d. \rows. \cols. \thing.
  while (fmap not (has thing)) (wait 4);
  rows (
    cols (place thing; grab; move; return ()); tB;
    cols move; tB;
    turn d; move; x3 (turn d)
  );
  x3 (turn d); rows move; turn d
end

def harvest : dir -> (cmd () -> cmd ()) -> (cmd () -> cmd ()) -> string -> robot -> cmd ()
  = \d. \rows. \cols. \thing. \r.
    forever (
      harvestbox d rows cols thing;
      tB; m1;
      giveall r thing;
      tB; m1
    )
end

// Pull-based manufacturing

def get = \thing.
  waitUntil (ishere thing);
  grab
end

def provide0 = \thing. forever (
  waitWhile (ishere thing);
  waitUntil (has thing);
  place thing;
  )
end

// provide1, provide2, etc. need calculator + comparator

def provide1 = \x. \y. \thing. \n. \ingr. \ix. \iy.
  moveByN x y;
  forever (
    ifC (fmap not (has thing)) {
      while (cur <- count thing; return (cur < 8)) (
        moveByN (ix - x) (iy - y);
        repeat n (get ingr);
        moveByN (x - ix) (y - iy);
        make thing
      )
    } {};
    waitWhile (ishere thing);
    place thing;
  )
end

def provide2 : int -> int -> string -> int -> string -> int -> int
                                    -> int -> string -> int -> int -> cmd ()
  = \x. \y. \thing. \n1. \ingr1. \i1x. \i1y.
                               \n2. \ingr2. \i2x. \i2y.
  moveByN x y;
  forever (
    ifC (fmap not (has thing)) {
      while (cur <- count thing; return (cur < 8)) (
        moveByN (i1x - x) (i2y - y);
        repeat n1 (get ingr1);
        moveByN (i2x - i1x) (i2y - i1y);
        repeat n2 (get ingr2);
        moveByN (x - i2x) (y - i2y);
        make thing
      )
    } {};
    waitWhile (ishere thing);
    place thing;
  )
end

// Automated setup of standard 4x8 plantation + depot.
// It will look like this:
//
//   >........
//    ........
//    ........
//    ........
//
// where > is the location and orientation of a robot after executing
// build {there}.  > will be the location of the depot.  To obtain
// resources from the depot, go to its cell and execute 'get
// <resource>'.
//
// Requirements:
//   - branch predictor (2)
//   - lambda (2)
//   - strange loop (2)

def plantation : string -> cmd () -> cmd () = \product. \there.
  depot <- build {there; provide0 product};
  harvester <- build {
    wait 3; there; m1;
    plant_garden right x4 x8 product;
    harvest right x4 x8 product depot
  };
  give harvester product
end

// Trees have to be dealt with specially, because the recipe for processing
// trees has two outputs.
//
// Requirements:
//   - branch predictor (3)
//   - lambda (3)
//   - strange loop (3)
//   - workbench

def process_trees = \there.
  log_depot <- build {there; tR; m1; provide0 "log"};
  branch_depot <- build {there; tR; m2; provide0 "branch"};
  build {
    there;
    forever (
      get "tree"; make "log";
      tR; m1; give log_depot "log";
      m1; x2 (give branch_depot "branch");
      tB; m2; tR
    )
  }
end

// Requirements:
//   - branch predictor (5)
//   - lambda (5)
//   - strange loop (5)
//   - workbench
def tree_plantation = \there.
  plantation "tree" there; process_trees there
end

// World-specific stuff

def harvestbits =
  wait 3; tL; m32; m8;
  harvestboxP right x16 x16 bithere;
  tB; m32; m8;
  giveall base "bit (0)";
  giveall base "bit (1)";
end
