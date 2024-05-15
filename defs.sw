
////////////////////////////////////////////////////////////
// Various simple turning, moving, + misc abbreviations
////////////////////////////////////////////////////////////
// Turn abbreviations
def tL = turn left end

def tR = turn right end

def tB = turn back end

def tN = turn north end

def tE = turn east end

def tS = turn south end

def tW = turn west end


// Scan abbreviations
def sF = scan forward end

def sL = scan left end

def sR = scan right end

def sB = scan back end

def sD = scan down end

def sN = scan north end

def sE = scan east end

def sS = scan south end

def sW = scan west end

def sA = sL; sR; sF; sB; sD end


// Salvage abbreviation
def slv = salvage end


// m0 - m64, without devices
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

def m17 = m1; m16 end

def m18 = m9; m9 end

def m19 = m1; m18 end

def m20 = m10; m10 end

def m21 = m1; m20 end

def m22 = m11; m11 end

def m23 = m1; m22 end

def m24 = m12; m12 end

def m25 = m1; m24 end

def m26 = m13; m13 end

def m27 = m1; m26 end

def m28 = m14; m14 end

def m29 = m1; m28 end

def m30 = m15; m15 end

def m31 = m1; m30 end

def m32 = m16; m16 end

def m33 = m1; m32 end

def m34 = m17; m17 end

def m35 = m1; m34 end

def m36 = m18; m18 end

def m37 = m1; m36 end

def m38 = m19; m19 end

def m39 = m1; m38 end

def m40 = m20; m20 end

def m41 = m1; m40 end

def m42 = m21; m21 end

def m43 = m1; m42 end

def m44 = m22; m22 end

def m45 = m1; m44 end

def m46 = m23; m23 end

def m47 = m1; m46 end

def m48 = m24; m24 end

def m49 = m1; m48 end

def m50 = m25; m25 end

def m51 = m1; m50 end

def m52 = m26; m26 end

def m53 = m1; m52 end

def m54 = m27; m27 end

def m55 = m1; m54 end

def m56 = m28; m28 end

def m57 = m1; m56 end

def m58 = m29; m29 end

def m59 = m1; m58 end

def m60 = m30; m30 end

def m61 = m1; m60 end

def m62 = m31; m31 end

def m63 = m1; m62 end

def m64 = m32; m32 end


// Doing things "under" transformations, i.e. conjugation
// Under turns
def uL = \c. tL; res <- c; tR; return res end

def uR = \c. tR; res <- c; tL; return res end

def uB = \c. tB; res <- c; tB; return res end


// Under movement, e.g.  uM m5 c
def uM = \m. \c. m; res <- c; tB; m; tB; return res end


// Moving while keeping N orientation
def mN = \m. m end

def mS = uB end

def mE = uR end

def mW = uL end


// Moving around corners while keeping N orientation
def mNE = \x. \y. mN y; mE x end

def mEN = \x. \y. mE x; mN y end

def mNW = \x. \y. mN y; mW x end

def mWN = \x. \y. mW x; mN y end

def mSE = \x. \y. mS y; mE x end

def mES = \x. \y. mE x; mS y end

def mSW = \x. \y. mS y; mW x end

def mWS = \x. \y. mW x; mS y end


// Doing subcommands at relative locations.  e.g.  atS m25 (place "rock")
// will place a rock at the location 25 units south of the robot's
// starting location, and then return to the original location.
//
// Robot is assumed to face N initially.  The subcommand must preserve the robot's direction.
// Robot also faces N
//   1. before executing the subcommand
//   2. after returning the robot to the origin
//
// Note, these could be implemented more simply/transparently using uL, uR, uB, uM,
// but that would result in redundant turning, so we just implement them
// directly like this.
def atN = \y. \c. y; res <- c; tB; y; tB; return res end

def atS = \y. \c. tB; y; tB; res <- c; y; return res end

def atE = \x. \c. tR; x; tL; res <- c; tL; x; tR; return res end

def atW = \x. \c. tL; x; tR; res <- c; tR; x; tL; return res end


// Going "around corners": e.g. NE goes north then east, but EN goes east
// then north.  Note regardless of NE vs EN etc., the x distance
// always comes first, then y distance.
def atNE = \x. \y. \c. y; tR; x; tL; res <- c; tL; x; tL; y; tB; return res end

def atEN = \x. \y. \c. tR; x; tL; y; res <- c; tB; y; tR; x; tR; return res end

def atNW = \x. \y. \c. y; tL; x; tR; res <- c; tR; x; tR; y; tB; return res end

def atWN = \x. \y. \c. tL; x; tR; y; res <- c; tB; y; tL; x; tL; return res end

def atSE = \x. \y. \c. tB; y; tL; x; tL; res <- c; tL; x; tR; y; return res end

def atES = \x. \y. \c. tR; x; tR; y; tB; res <- c; y; tL; x; tR; return res end

def atSW = \x. \y. \c. tB; y; tR; x; tR; res <- c; tR; x; tL; y; return res end

def atWS = \x. \y. \c. tL; x; tL; y; tB; res <- c; y; tR; x; tL; return res end


// For convenience, versions of atXX for grabbing, harvesting, salvaging, and
// scanning specifically
def grabN = \y. atN y grab end

def grabS = \y. atS y grab end

def grabE = \x. atE x grab end

def grabW = \x. atW x grab end

def grabNE = \x. \y. atNE x y grab end

def grabEN = \x. \y. atEN x y grab end

def grabNW = \x. \y. atNW x y grab end

def grabWN = \x. \y. atWN x y grab end

def grabSE = \x. \y. atSE x y grab end

def grabES = \x. \y. atES x y grab end

def grabSW = \x. \y. atSW x y grab end

def grabWS = \x. \y. atWS x y grab end

def hrvN = \y. atN y harvest end

def hrvS = \y. atS y harvest end

def hrvE = \x. atE x harvest end

def hrvW = \x. atW x harvest end

def hrvNE = \x. \y. atNE x y harvest end

def hrvEN = \x. \y. atEN x y harvest end

def hrvNW = \x. \y. atNW x y harvest end

def hrvWN = \x. \y. atWN x y harvest end

def hrvSE = \x. \y. atSE x y harvest end

def hrvES = \x. \y. atES x y harvest end

def hrvSW = \x. \y. atSW x y harvest end

def hrvWS = \x. \y. atWS x y harvest end

def slvN = \y. atN y salvage end

def slvS = \y. atS y salvage end

def slvE = \x. atE x salvage end

def slvW = \x. atW x salvage end

def slvNE = \x. \y. atNE x y salvage end

def slvEN = \x. \y. atEN x y salvage end

def slvNW = \x. \y. atNW x y salvage end

def slvWN = \x. \y. atWN x y salvage end

def slvSE = \x. \y. atSE x y salvage end

def slvES = \x. \y. atES x y salvage end

def slvSW = \x. \y. atSW x y salvage end

def slvWS = \x. \y. atWS x y salvage end

def scanN = \y. atN y sA end

def scanS = \y. atS y sA end

def scanE = \x. atE x sA end

def scanW = \x. atW x sA end

def scanNE = \x. \y. atNE x y sA end

def scanEN = \x. \y. atEN x y sA end

def scanNW = \x. \y. atNW x y sA end

def scanWN = \x. \y. atWN x y sA end

def scanSE = \x. \y. atSE x y sA end

def scanES = \x. \y. atES x y sA end

def scanSW = \x. \y. atSW x y sA end

def scanWS = \x. \y. atWS x y sA end


////////////////////////////////////////////////////////////
// Simple repetition
////////////////////////////////////////////////////////////
// Simple repetition using only lambda
def x0 = \c. noop end

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

def x128 = \c. x64 c; x64 c end

def x256 = \c. x128 c; x128 c end

def x512 = \c. x256 c; x256 c end

def x1024 = \c. x512 c; x512 c end

def x2048 = \c. x1024 c; x1024 c end


////////////////////////////////////////////////////////////
// Utilities
////////////////////////////////////////////////////////////
// cmd monad
def fmap: ∀ a b. (a -> b) -> Cmd a -> Cmd b = \f. \x. a <- x; return (f a) end

def liftA2: ∀ a b c. (a -> b -> c) -> Cmd a -> Cmd b -> Cmd c
  = \f. \x. \y.
  a <- x;
  b <- y;
  return (f a b)
end


// Math & logic
def abs: Int -> Int = \x. if (x < 0) {-x} {x} end

def min: Int -> Int -> Int = \x. \y. if (x < y) {x} {y} end

def mod: Int -> Int -> Int = \a. \b. a - b * (a / b) end

def or: Bool -> Bool -> Bool = \x. \y. x || y end

def and: Bool -> Bool -> Bool = \x. \y. x && y end


// Control
def ifC: ∀ a. Cmd Bool -> {Cmd a} -> {Cmd a} -> Cmd a
  = \test. \then. \else.
  b <- test;
  if b then else
end

def forever: ∀ a b. {Cmd a} -> Cmd b = \c. force c; forever c end

def x: ∀ a. Int -> Cmd a -> Cmd Unit = \n. \c. if (n == 0) {} {c; x (n - 1) c}
end

def while: ∀ a. Cmd Bool -> {Cmd a} -> Cmd Unit
  = \test. \body.
  ifC test {force body; while test body} {}
end

def waitWhile = \test. while test {wait 1} end


// Could do  ifC (fmap not test)  but that requires a lodestone!
def unless = \test. \then. \else. ifC test else then end


// Could define in terms of while but that requires a lodestone!
def until = \test. \body. ifC test {} {force body; until test body} end

def waitUntil = \test. until test {wait 1} end

def moveTo = \thing. until (ishere thing) {move} end

def waitFor = \thing. until (has thing) {wait 4} end

def notempty: Cmd Bool = e <- isempty; return $ if e {false} {true} end


////////////////////////////////////////////////////////////
// Movement
////////////////////////////////////////////////////////////
// Some movement commands.  Require strange loop, calculator,
// comparator.
// Versions that assume robot is facing N as pre/postcondition.
// These do not require a compass.
def moveByN: Int -> Int -> Cmd Unit
  = \dx. \dy.
  if (dy < 0) {tB} {};
  x (abs dy) move;
  if (dy < 0) {tB} {};
  if (dx < 0) {tL} {tR};
  x (abs dx) move;
  if (dx < 0) {tR} {tL}
end

def moveToN: Int * Int -> Cmd Unit
  = \tgt.
  loc <- whereami;
  let dx = fst tgt - fst loc in let dy = snd tgt - snd loc in moveByN dx dy
end


// Arbitrary orientation, requires compass.
def moveBy: Int -> Int -> Cmd Unit
  = \dx. \dy.
  if (dx < 0) {tW} {tE};
  x (abs dx) move;
  if (dy < 0) {tS} {tN};
  x (abs dy) move
end

def moveTo: Int * Int -> Cmd Unit
  = \tgt.
  loc <- whereami;
  let dx = fst tgt - fst loc in let dy = snd tgt - snd loc in moveBy dx dy
end

def excursion: Cmd Unit -> Cmd Unit
  = \m.
  hdg <- heading;
  pos <- whereami;
  m;
  moveTo pos;
  turn hdg
end


// Moving + drilling.
def tryDrill = ifC blocked {drill forward; return ()} {} end

def shove: Cmd Unit = tryDrill; move end

def drillbox
  = \d. \rep1. \rep2.
  rep1 (rep2 shove; tB; rep2 move; tB; turn d; shove; x3 (turn d));
  x3 (turn d);
  rep1 move;
  turn d
end


////////////////////////////////////////////////////////////
// Harvesting + planting
////////////////////////////////////////////////////////////
// harvestline, harvestbox, and friends require only branch predictor + lambda + (e.g. harvester).
def dolineP
  = \act. \rep. \pred.
  rep (ifC pred {act; return ()} {}; move);
  tB;
  rep move;
  tB
end

def harvestline = \rep. dolineP harvest rep notempty end

def grabline = \rep. dolineP grab rep notempty end

def drillline = \rep. dolineP (drill forward) rep blocked end

def doboxP:
    ∀ a. Cmd a ->
         Dir ->
         (Cmd Unit -> Cmd Unit) ->
         (Cmd Unit -> Cmd Unit) ->
         Cmd Bool ->
         Cmd Unit
  = \act. \d. \rep1. \rep2. \pred.
  rep1 (dolineP act rep2 pred; turn d; move; x3 (turn d));
  x3 (turn d);
  rep1 move;
  turn d
end

def harvestbox:
    Dir ->
    (Cmd Unit -> Cmd Unit) ->
    (Cmd Unit -> Cmd Unit) ->
    Cmd Unit
  = \d. \rep1. \rep2.
  doboxP harvest d rep1 rep2 notempty
end

def grabbox:
    Dir ->
    (Cmd Unit -> Cmd Unit) ->
    (Cmd Unit -> Cmd Unit) ->
    Cmd Unit
  = \d. \rep1. \rep2.
  doboxP grab d rep1 rep2 notempty
end

def drillbox = \d. \rep1. \rep2. doboxP (drill forward) d rep1 rep2 blocked end

def clearbox = \d. \rep1. \rep2. drillbox d rep1 rep2; grabbox d rep1 rep2 end


// tend additionally requires strange loop
// Usage example: tend "lambda" (atNE m5 m9)
def tend
  = \thing. \at.
  forever {at (until (ishere thing) {wait 16}; harvest); give base thing}
end

def plant_garden:
    Dir ->
    (Cmd Unit -> Cmd Unit) ->
    (Cmd Unit -> Cmd Unit) ->
    Text ->
    Cmd Unit
  = \d. \rows. \cols. \thing.
  waitFor thing;
  rows (
    cols (place thing; harvest; move; return ());
    tB;
    cols move;
    tB;
    turn d;
    move;
    x3 (turn d)
  );
  x3 (turn d);
  rows move;
  turn d
end

def garden:
    (Cmd Unit -> Cmd Unit) ->
    Dir ->
    (Cmd Unit -> Cmd Unit) ->
    (Cmd Unit -> Cmd Unit) ->
    Text ->
    Cmd Unit
  = \at. \d. \rows. \cols. \thing.
  planter <- build {at (plant_garden d rows cols thing)};
  give planter thing
end

def giveall: Actor -> Text -> Cmd Unit
  = \r. \thing.
  while (has thing) {give r thing}
end


////////////////////////////////////////////////////////////
// Pull-based manufacturing
////////////////////////////////////////////////////////////
def place_atomic
  = \product.
  atomic (here <- isempty; if here {place product; return true} {return false})
end

def grab_atomic
  = \thing.
  atomic (b <- ishere thing; if b {grab; return true} {return false})
end

def get = \thing. waitUntil (grab_atomic thing) end


////////////////////////////////////////////////////////////
// Utilities + specific steps for speedrun strategies
////////////////////////////////////////////////////////////
def makeH =
  x3 (make "log");
  x3 (make "board");
  make "box";
  x2 (make "wooden gear");
  make "harvester"
end

def makeB = x2 (make "log"; make "board"); make "boat" end

def makeBP = make "branch predictor" end

def first_3_trees = makeH; makeBP; place "lambda"; build {harvest} end

def t5 = first_3_trees; makeB end

def grabrow = \x. x (grab; m1); tB; x m1; tB end

def plantrow = \x. \thing. x (m1; place thing; harvest; return ()); tB; x m1; tB
end

def lambdas = \d. build {require 1 "lambda"; turn d; plantrow x4 "lambda"} end

def get_lambdas
  = \d.
  build {turn d; x4 (m1; grab); tB; m4; x4 (give base "lambda")}
end

def get_water = \c. build {require "treads"; require "boat"; c grab} end

def next_trees
  = \n.
  n (make "log");
  x7 (make "branch predictor");
  x3 (make "board"; make "workbench")
end

def makeD =
  make "box";
  x32 (make "wooden gear");
  make "small motor";
  make "drill"
end


////////////////////////////////////////////////////////////
// Pull-based manufacturing with automatic location finding
////////////////////////////////////////////////////////////
def depot_here: Text -> Cmd Unit
  = \thing.

  // setname (thing ++ " depot");
  forever {waitWhile (ishere thing); waitFor thing; place thing}
end

def provide_here: Text -> (Text -> Cmd Unit) -> Cmd Unit
  = \thing. \get_more.

  // setname (thing ++ " provider");
  forever {
    while (has thing) {waitWhile (ishere thing); place_atomic thing};
    get_more thing
  }
end

def provide_row: Text -> (Text -> Cmd Unit) -> Cmd Unit
  = \thing. \get_more.
  until (liftA2 or (ishere thing) (place_atomic thing)) {move};
  turn right;
  move;
  provide_here thing get_more
end

def find_row: Text -> Cmd Unit
  = \thing.
  ifC (ishere thing) {} {
    ifC isempty {turn back; move; until isempty {move}; turn back} {};
    move;
    find_row thing
  }
end

def get_simple: (Cmd Unit -> Cmd Unit) -> Text -> Cmd Unit
  = \rep. \thing.
  until (ishere thing) {move};
  turn right;
  move;
  rep (get thing);
  turn back;
  move;
  turn left;
  until isempty {move};
  turn back;
  move
end

def get_row: Int -> Text -> Cmd Unit
  = \n. \thing.
  find_row thing;
  turn right;
  move;
  x n (get thing);
  turn back;
  move;
  turn left;
  until isempty {move};
  turn back;
  move
end

def make_with: Cmd Unit -> Text -> Cmd Unit
  = \get_ingrs. \thing.
  get_ingrs;
  make thing
end


////////////////////////////////////////////////////////////
// One-row strategy
////////////////////////////////////////////////////////////
// depot command which acts like provide_raw but (1) never tries to
// get more, and (2) does a simple 'place' instead of 'atomic_place'
// (which requires ADT calculator).  Useful earlier in the game for
// collecting basic resources, but have to be careful you don't send
// several out at once.
def depot: (Cmd Unit -> Cmd Unit) -> Text -> Cmd Actor
  = \atShingles. \thing.
  d <- build {
    waitFor thing;
    atShingles (
      until isempty {move};
      place thing;
      turn right;
      move;
      depot_here thing
    )
  };
  give d thing;
  return d
end

def provide_raw: Text -> (Text -> Cmd Unit) -> Cmd Unit
  = \thing. \more.
  unless (has thing) {more thing} {};
  provide_row thing more
end

def provide: Text -> (Text -> Cmd Unit) -> Cmd Unit
  = \thing. \more.
  unless (has thing) {more thing} {};
  provide_row thing (
    \t. turn back;
    move;
    turn right;
    more thing;
    find_row thing;
    turn right;
    move
  )
end

def pr: (Cmd Unit -> Cmd Unit) -> Text -> Cmd Unit -> Cmd Actor
  = \atSh. \thing. \more.
  build {
    require "logger";
    require "comparator";
    require "calculator" // why are these necessary?
    ;
    atSh (provide thing (make_with more))
  }
end


// def prR : (cmd unit -> cmd unit) -> text -> text -> cmd unit -> cmd actor =
//   \atSh. \catalyst. \thing. \more.
//   p <- build {
//     require "comparator"; require "calculator"; // BUG: why are these necessary?
//     until (has catalyst) {};
//     atSh (provide thing (make_with more))
//   };
//   install p catalyst;
//   return p
// end
def deliver: Actor -> Text -> Cmd Unit
  = \r. \thing.
  until (ishere thing) {move};
  turn right;
  move;
  giveall r thing;
  turn back;
  move;
  turn left;
  until isempty {move};
  turn back;
  move
end

def tendbox:
    (Cmd Unit -> Cmd Unit) ->
    Dir ->
    (Cmd Unit -> Cmd Unit) ->
    (Cmd Unit -> Cmd Unit) ->
    Text ->
    (Cmd Unit -> Cmd Unit) ->
    Actor ->
    Cmd Unit
  = \at. \d. \rows. \cols. \thing. \atSh. \r.
  forever {at (harvestbox d rows cols); atSh (deliver r thing)}
end


// Arguments = how to get to shingle row from base; name of thing; function to extract it
// XXX debug this!
def resource: (Cmd Unit -> Cmd Unit) -> Text -> Cmd Unit -> Cmd Actor
  = \atShingles. \thing. \extract.
  d <- depot atShingles thing;
  give d thing;
  build {forever {extract; atShingles (deliver d thing)}};
  return d
end

def process_trees: (Cmd Unit -> Cmd Unit) -> Actor -> Actor -> Cmd Actor
  = \atShingles. \logDepot. \branchDepot.
  build {
    atShingles (
      until (ishere "tree") {move};
      forever {
        tR;
        m1;
        get "tree";
        tB;
        m1;
        tR;
        make "log";
        m1;
        tR;
        m1;
        giveall logDepot "log";
        tB;
        m1;
        tR;
        m1;
        tR;
        m1;
        giveall branchDepot "branch";
        tB;
        m1;
        tL;
        m2;
        tB
      }
    )
  }
end


////////////////////////////////////////////////////////////
// Bootstrapping providers
////////////////////////////////////////////////////////////
def elsif = \p. \then. \else. {if p then else} end

def rmake: Int -> Text -> Cmd Unit
  = \n. \thing.
  require "furnace";
  require "3D printer";
  have <- count thing;
  let m = n - have in
  if (
    thing == "log" || thing == "branch" || thing == "bit (0)" || thing == "bit (1)" || thing == "LaTeX" || thing == "copper ore" || thing == "iron ore" || thing == "quartz" || thing == "sand"
  ) {get_simple (x n) thing} $ elsif (thing == "copper wire") {
    rmake (n / 10) "copper ore";
    make "copper wire"
  } $ elsif (thing == "strange loop") {
    rmake (2 * n) "copper wire";
    make "strange loop"
  } $ elsif (thing == "board") {
    rmake ((n + 3) / 4) "log";
    x n (make "board")
  } {}
end

def make_provider_devices
  = \atShingles.
  require "logger";
  require "furnace";
  require 1 "solar panel";
  atShingles (
    get_simple x8 "log";
    get_simple x1 "copper ore";
    make "copper wire";
    x6 (make "board");
    x10 (make "wooden gear");
    make "teeter-totter";
    make "comparator";
    get_simple x8 "bit (0)";
    get_simple x8 "bit (1)";
    make "flash memory";
    make "counter";
    make "calculator";
    get_simple x1 "LaTeX";
    make "rubber";
    make "strange loop";
    make "rubber band"
  )
end

def get_provider_devices
  = \atShingles.
  atShingles (
    get_simple x1 "comparator";
    get_simple x1 "calculator";
    get_simple x1 "rubber band"
  )
end


// TODO: make version of pr that bootstraps itself by running
// get_provider_devices, equipping the devices, then running pr.
// Need to make a recipe for welder, make some manually first.
////////////////////////////////////////////////////////////
// DEMO
////////////////////////////////////////////////////////////
def toStart = move end

def g = get_row end

def mk = \thing. \more. build {toStart; provide thing (make_with more)} end

def mkR
  = \catalyst. \thing. \more.
  build {toStart; g 1 catalyst; equip catalyst; provide thing (make_with more)}
end

def oracle = \atSh. \thing. build {atSh (provide_raw thing create)} end
