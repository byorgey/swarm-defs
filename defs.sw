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
def m2 = move;m1 end
def m3 = move;m2 end
def m4 = move;m3 end
def m5 = move;m4 end
def m6 = move;m5 end
def m7 = move;m6 end
def m8 = move;m7 end
def m9 = move;m8 end
def m10 = move;m9 end
def m11 = move;m10 end
def m12 = move;m11 end
def m13 = move;m12 end
def m14 = move;m13 end
def m15 = move;m14 end
def m16 = move;m15 end
def m32 = m16;m16 end
def m64 = m32;m32 end
def m128 = m64;m64 end

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

def x2 = \c. c;c end
def x3 = \c. c; x2 c end
def x4 = \c. x2 c; x2 c end
def x6 = \c. x2 c; x4 c end
def x8 = \c. x4 c; x4 c end
def x16 = \c. x8 c; x8 c end
def x32 = \c. x16 c; x16 c end
def x64 = \c. x32 c; x32 c end
def x128 = \c. x64 c; x64 c end
def x256 = \c. x128 c; x128 c end
def x512 = \c. x256 c; x256 c end
def x1024 = \c. x512 c; x512 c end

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

// Processing

def process_tree =
  num_trees <- count "tree";
  if (num_trees >= 2) { x2 (make "log"); x2 (make "branch predictor"); make "board" } {};
  num_boards <- count "board";
  if (num_boards >= 30) { x6 (make "wooden gear"); make "boat"; x2 (make "box"); make "seesaw" } {};
  giveall base "log";
  giveall base "branch predictor";
  giveall base "wooden gear";
  giveall base "boat";
  giveall base "box";
  giveall base "seesaw"
end

def process_bits =
  num_0 <- count "bit (0)";
  num_1 <- count "bit (1)";
  if (num_0 >= 10 && num_1 >= 10) { make "counter"; x2 (make "drill bit") } {};
  giveall base "counter"; giveall base "drill bit"
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
  moveBy x y;
  forever (
    ifC (fmap not (has thing)) {
      while (cur <- count thing; return (cur < 8)) (
        moveBy (ix - x) (iy - y);
        repeat n (get ingr);
        moveBy (x - ix) (y - iy);
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
  moveBy x y;
  forever (
    ifC (fmap not (has thing)) {
      while (cur <- count thing; return (cur < 8)) (
        moveBy (i1x - x) (i2y - y);
        repeat n1 (get ingr1);
        moveBy (i2x - i1x) (i2y - i1y);
        repeat n2 (get ingr2);
        moveBy (x - i2x) (y - i2y);
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

// Trees have to be dealt with specially

def process_trees = \r1. \r2. forever (
  ifC (has "tree") {
    make "log";
    give r1 "log";
    give r2 "branch"; give r2 "branch"
  }
  {}
  )
end

// Make sure to have a workbench, branch predictors, strange loops first!
// Be sure to save output!
def build_tree_factory = \toloc.
  log_depot <- build {toloc; m1; provide0 "log"};
  branch_depot <- build {toloc; tB; m1; provide0 "branch"};
  build {toloc; process_trees log_depot branch_depot}
end

// World-specific stuff

def harvestbits =
  wait 3; tL; m32; m8;
  harvestboxP right x16 x16 bithere;
  tB; m32; m8;
  giveall base "bit (0)";
  giveall base "bit (1)";
end
