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
def uL = \c. tL; res <- c; tR; pure res end

def uR = \c. tR; res <- c; tL; pure res end

def uB = \c. tB; res <- c; tB; pure res end


// Under movement, e.g.  uM m5 c
def uM = \m. \c. m; res <- c; tB; m; tB; pure res end


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
def atN = \y. \c. y; res <- c; tB; y; tB; pure res end

def atS = \y. \c. tB; y; tB; res <- c; y; pure res end

def atE = \x. \c. tR; x; tL; res <- c; tL; x; tR; pure res end

def atW = \x. \c. tL; x; tR; res <- c; tR; x; tL; pure res end


// Going "around corners": e.g. NE goes north then east, but EN goes east
// then north.  Note regardless of NE vs EN etc., the x distance
// always comes first, then y distance.
def atNE = \x. \y. \c. y; tR; x; tL; res <- c; tL; x; tL; y; tB; pure res end

def atEN = \x. \y. \c. tR; x; tL; y; res <- c; tB; y; tR; x; tR; pure res end

def atNW = \x. \y. \c. y; tL; x; tR; res <- c; tR; x; tR; y; tB; pure res end

def atWN = \x. \y. \c. tL; x; tR; y; res <- c; tB; y; tL; x; tL; pure res end

def atSE = \x. \y. \c. tB; y; tL; x; tL; res <- c; tL; x; tR; y; pure res end

def atES = \x. \y. \c. tR; x; tR; y; tB; res <- c; y; tL; x; tR; pure res end

def atSW = \x. \y. \c. tB; y; tR; x; tR; res <- c; tR; x; tL; y; pure res end

def atWS = \x. \y. \c. tL; x; tL; y; tB; res <- c; y; tR; x; tL; pure res end


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
def x0 = \_. noop end

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
def fmap: ∀ a b. (a -> b) -> Cmd a -> Cmd b = \f. \x. a <- x; pure (f a) end

def liftA2: ∀ a b c. (a -> b -> c) -> Cmd a -> Cmd b -> Cmd c 
  = \f. \x. \y.
  a <- x;
  b <- y;
  pure (f a b)
end


// Math & logic
def abs: Int -> Int = \x. if (x < 0) {-x} {x} end

def min: Int -> Int -> Int = \x. \y. if (x < y) {x} {y} end

def mod: Int -> Int -> Int = \a. \b. a - b * (a / b) end

def or: Bool -> Bool -> Bool = \x. \y. if x {true} {y} end

def and: Bool -> Bool -> Bool = \x. \y. if x {y} {false} end

def compose: (b -> c) -> (a -> b) -> a -> c = \g. \f. \x. g (f x) end


// Control
def ifC: ∀ a. Cmd Bool -> {Cmd a} -> {Cmd a} -> Cmd a 
  = \test. \then. \else.
  b <- test;
  if b then else
end

def andC: Cmd Bool -> Cmd Bool -> Cmd Bool 
  = \x. \y.
  xb <- x;
  yb <- y;
  pure (and xb yb)
end

def forever: ∀ a b. {Cmd a} -> Cmd b = \c. force c; forever c end

tydef Rep = Cmd Unit -> Cmd Unit end

tydef Ctx = Cmd Unit -> Cmd Unit end

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

def notempty: Cmd Bool = e <- isempty; pure $ if e {false} {true} end


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

def moveToN: (Int * Int) -> Cmd Unit 
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

def moveTo: (Int * Int) -> Cmd Unit 
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
def tryDrill = ifC blocked {drill forward; pure ()} {} end

def shove: Cmd Unit = tryDrill; move end


////////////////////////////////////////////////////////////
// Harvesting, grabbing, + drilling
////////////////////////////////////////////////////////////
// harvestline, harvestbox, and friends require only branch predictor
// + lambda + (e.g. harvester).
def dolineP 
  = \act. \rep. \pred.
  rep (ifC pred {act; pure ()} {}; move);
  tB;
  rep move;
  tB
end

def harvestline = \rep. dolineP harvest rep notempty end

def grabline = \rep. dolineP grab rep notempty end

def drillline = \rep. dolineP (drill forward) rep blocked end

def doboxP: ∀ a. Cmd a -> Dir -> Rep -> Rep -> Cmd Bool -> Cmd Unit 
  = \act. \d. \rep1. \rep2. \pred.
  rep1 (dolineP act rep2 pred; turn d; move; x3 (turn d));
  x3 (turn d);
  rep1 move;
  turn d
end

def harvestbox = \d. \rep1. \rep2. doboxP harvest d rep1 rep2 notempty end

def grabbox = \d. \rep1. \rep2. doboxP grab d rep1 rep2 notempty end

def drillbox = \d. \rep1. \rep2. doboxP (drill forward) d rep1 rep2 blocked end


// tend additionally requires strange loop
// Usage example: tend "lambda" (atNE m5 m9)
def tend 
  = \thing. \at.
  forever {at (until (ishere thing) {wait 16}; harvest); give base thing}
end

def giveall: Actor -> Text -> Cmd Unit 
  = \r. \thing.
  while (has thing) {give r thing}
end


////////////////////////////////////////////////////////////
// Atomic grab + place
////////////////////////////////////////////////////////////
def placeAtomic: Text -> Cmd Bool 
  = \product.
  atomic (here <- isempty; if here {place product; pure true} {pure false})
end

def grabAtomic: Text -> Cmd Bool 
  = \thing.
  atomic (b <- ishere thing; if b {grab; pure true} {pure false})
end

def get: Text -> Cmd Unit = \thing. waitUntil (grabAtomic thing) end


////////////////////////////////////////////////////////////
// Fields
////////////////////////////////////////////////////////////
// Plant a rectangular box of a harvestable item.
// Requires harvester + lambda.
def plantField: Dir -> Rep -> Rep -> Text -> Cmd Unit 
  = \d. \rows. \cols. \thing.
  rows (
    cols (place thing; harvest; move; pure ());
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


// Create a rectangular box of a harvestable item at a specific location,
// by spawning a robot to plant it.
def buildField: Ctx -> Dir -> Rep -> Rep -> Text -> Cmd Unit 
  = \ctx. \d. \rows. \cols. \thing.
  planter <- build {waitFor thing; ctx (plantField d rows cols thing)};
  give planter thing
end


// Tend a field, given the context of the field, direction, size, and finally
// a command to run in between each harvesting loop (i.e. to deliver the produce).
def tendField: Ctx -> Dir -> Rep -> Rep -> Cmd Unit -> Cmd Unit 
  = \ctx. \d. \rows. \cols. \deliver.
  forever {ctx (harvestbox d rows cols); deliver}
end


////////////////////////////////////////////////////////////
// Shingle row stragegy
////////////////////////////////////////////////////////////
/* There is a single row of "shingles" which are entities placed on
   the ground to advertise the availability of a certain resource.
   Robots sit next to the shingles and respond to requests for the
   resource.
*/
//////////////////////////////////////////////////
// Shingle utilities
//////////////////////////////////////////////////
// In the context of the shingle row, find the provider
// for a given item.
def findProvider: Text -> Cmd Unit 
  = \thing.
  until (ishere thing) {move};
  turn right;
  move
end


// Return from a provider to the shingle context.
def returnFromProvider: Cmd Unit =
  turn back;
  move;
  turn left;
  until isempty {move};
  turn back;
  move
end


// In the context of the shingle row, carry out an action at the
// provider of a specific item.
def atProvider: Text -> Cmd Unit -> Cmd Unit 
  = \thing. \action.
  findProvider thing;
  action;
  returnFromProvider
end


// In the shingle context, get some items from their provider.
def getProvided: Rep -> Text -> Cmd Unit 
  = \rep. \thing.
  atProvider thing (rep (get thing))
end


//////////////////////////////////////////////////
// Depots
//////////////////////////////////////////////////
/* A depot robot:
     1. Goes to the shingles row
     2. Finds the first empty spot in the row
     3. Places one item there
     4. Sits next to it and provides the resource.
   The depot never tries to obtain more of the resource, it just
   assumes the resource will be given to it.  It also does a simple
   'place' instead of 'place_atomic' (which requires XXX). Useful
   earlier in the game for collecting basic resources, but have to
   be careful you don't send several out at once.
*/
def depotHere: Text -> Cmd Unit 
  = \thing.

  // setname (thing ++ " depot");
  forever {waitWhile (ishere thing); waitFor thing; place thing}
end

def buildDepot: Ctx -> Text -> Cmd Actor 
  = \atShingles. \thing.
  waitFor thing;
  depot <- build {
    require "grabber" // make sure we get a grabber and not a harvester!
    ;
    waitFor thing;
    atShingles (
      until isempty {move};
      place thing;
      turn right;
      move;
      depotHere thing
    )
  };
  give depot thing;
  pure depot
end


//////////////////////////////////////////////////
// Delivery + farming
//////////////////////////////////////////////////
// Deliver all of the specified item to the given robot (a depot).
// Should be executed in the context of the shingle row.
def deliver: Actor -> Text -> Cmd Unit 
  = \r. \thing.
  atProvider thing (giveall r thing)
end


/* Create a farm:
   - Builds a depot to hold produce
   - Builds a robot to plant the field and then
     tend it, delivering items to the depot

   Arguments are: shingle context, field context, direction, and size;
   item to plant/harvest.

   Returns a reference to the depot.
*/
def buildFarm: Ctx -> Ctx -> Dir -> Rep -> Rep -> Text -> Cmd Actor 
  = \atShingles. \atFarm. \d. \rows. \cols. \thing.
  log "Make sure you have two of the item...";
  depot <- buildDepot atShingles thing;
  waitFor thing;
  worker <- build {
    waitFor thing;
    atFarm (plantField d rows cols thing);
    tendField atFarm d rows cols (atShingles (deliver depot thing))
  };
  give worker thing;
  pure depot
end


// Build a standard (right, 8x4) farm.
def buildStdFarm: Ctx -> Ctx -> Text -> Cmd Actor 
  = \atShingles. \atFarm. \thing.
  buildFarm atShingles atFarm right x8 x4 thing
end


// Defining relative contexts one standard farm width away.
// E.g. could define the context for a new farm to be 'rightOf atFarm'
// if 'atFarm' is the context for the tree farm.
def above: Ctx -> Ctx = \at. compose at (atN m4) end

def rightOf: Ctx -> Ctx = \at. compose at (atE m8) end

def leftOf: Ctx -> Ctx = \at. compose at (atW m8) end

def below: Ctx -> Ctx = \at. compose at (atS m4) end


//////////////////////////////////////////////////
// Tree processing
//////////////////////////////////////////////////
// In the shingles context, process trees by getting them from the
// tree provider, processing them into logs and branches, and delivering
// to the log and branch depots (which must already exist).
//
// Arguments are log and branch depots.
def processTrees: Actor -> Actor -> Cmd Unit 
  = \logDepot. \branchDepot.
  forever {
    getProvided x4 "tree";
    x4 (make "log");
    deliver logDepot "log";
    deliver branchDepot "branch"
  }
end


// Build a tree processing pipeline.  A tree depot must already exist.
// Returns a reference to the processor robot.
def buildTreeProcess: Ctx -> Cmd Actor 
  = \atShingles.
  logDepot <- buildDepot atShingles "log";
  branchDepot <- buildDepot atShingles "branch";
  build {atShingles (processTrees logDepot branchDepot)}
end


//////////////////////////////////////////////////
// Mining
//////////////////////////////////////////////////
// Create a depot for ore and a miner.  Arguments are the shingles
// context, mine context, rock depot, and ore name.  Returns a reference to the depot.
def buildMine: Ctx -> Ctx -> Actor -> Text -> Cmd Actor 
  = \atShingles. \atMine. \rockDepot. \ore.
  depot <- buildDepot atShingles ore;
  build {
    forever {
      atMine (x16 (drill down); pure ());
      atShingles (deliver depot ore; deliver rockDepot "rock")
    }
  }
end


//////////////////////////////////////////////////
// Bootstrapping
//////////////////////////////////////////////////
// All these are to be executed in the shingles context.
def getBranchPredictor: Cmd Unit =
  getProvided x2 "branch";
  make "branch predictor"
end

def getHarvester: Cmd Unit =
  getProvided x3 "log";
  x3 (make "board");
  make "box";
  x2 (make "wooden gear");
  make "harvester"
end

def get5StrangeLoops: Cmd Unit =
  hf <- has "furnace";
  if hf {} {getProvided x5 "rock"; make "furnace"};
  getProvided x1 "copper ore";
  getProvided x1 "log";
  make "copper wire";
  x5 (make "strange loop")
end

def getWelder: Cmd Unit =
  require "furnace";
  getProvided x5 "log";
  getProvided x2 "copper ore";
  make "copper wire";
  make "copper pipe";
  getProvided x1 "iron ore";
  make "iron plate";
  getProvided x1 "LaTeX";
  make "rubber";
  make "I/O cable";
  make "welder"
end

def getBigMotor: Cmd Unit =
  getProvided x5 "rock";
  make "furnace";
  getProvided x9 "log";
  getProvided x4 "iron ore";
  x4 (make "iron plate");
  x8 (make "iron gear");
  getProvided x1 "copper ore";
  make "copper wire";
  make "big motor"
end

def getMetalDrill: Cmd Unit =
  getProvided x2 "log";
  x2 (make "board");
  make "box";
  getProvided x3 "bit (0)";
  getProvided x3 "bit (1)";
  x3 (make "drill bit");
  getBigMotor;
  make "metal drill"
end

def getFlashMemory: Cmd Unit =
  getProvided x8 "bit (0)";
  getProvided x8 "bit (1)";
  make "flash memory"
end

def getCounter: Cmd Unit =
  getFlashMemory;
  getProvided x4 "log";
  x4 (make "board");
  x8 (make "wooden gear");
  make "counter"
end


// needs pull-based provider for silicon, with big furnace
def getCircuit: Cmd Unit =
  getProvided x4 "silicon";
  hf <- has "furnace";
  if hf {} {getProvided x5 "rock"; make "furnace"};
  getProvided x2 "copper ore";
  getProvided x2 "log";
  x2 (make "copper wire");
  make "strange loop";
  getProvided x8 "bit (0)";
  getProvided x8 "bit (1)"
end


// Needs sand provider (just put some sand down)
def getGlass: Cmd Unit =
  hf <- has "furnace";
  if hf {} {getProvided x5 "rock"; make "furnace"};
  getProvided x1 "sand";
  make "glass"
end

def getSolarPanel: Cmd Unit =
  require "3D printer";
  getGlass;
  getProvided x1 "copper ore";
  getProvided x1 "log";
  x1 (make "copper wire");
  make "solar panel"
end

def getCalculator: Cmd Unit = getCounter; getSolarPanel; make "calculator" end


// Needs pixel farm/providers
def getCamera: Cmd Unit =
  getGlass;
  getProvided x10 "pixel (R)";
  getProvided x10 "pixel (G)";
  getProvided x10 "pixel (B)";
  make "camera"
end

def getScanner: Cmd Unit = getCamera; getCircuit; make "scanner" end


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

def grabrow = \x. x (grab; m1); tB; x m1; tB end

def plantrow = \x. \thing. x (m1; place thing; harvest; pure ()); tB; x m1; tB
end

def lambdas = \d. build {require 1 "lambda"; turn d; plantrow x4 "lambda"} end

def get_lambdas 
  = \d.
  build {turn d; x4 (m1; grab); tB; m4; x4 (give base "lambda")}
end

def get_water = \c. build {require "treads"; require "boat"; c grab} end

def makeD =
  make "box";
  x32 (make "wooden gear");
  make "small motor";
  make "drill"
end


// In case we drill out a quartz mine but don't note its location, since it looks
// the same as a mountain tunnel.
//
// Run this like   atXX (findQuartzMines right xM xN)  to search for quartz mines
// within an MxN box in context XX.  Will create a pattern of gears on the ground
// in the adjacent MxN box in direction d corresponding to the locations of quartz mines.
def findQuartzMines 
  = \d. \rows. \cols.
  require 5 "wooden gear";
  doboxP (
    turn d;
    rows move;
    place "wooden gear";
    tB;
    rows move;
    x3 (turn d)
  ) d rows cols (ishere "quartz mine")
end

def getMithril: Ctx -> Ctx -> Cmd Unit 
  = \atShingles. \atDeep.
  build {atShingles getMetalDrill; give base "metal drill"};
  waitFor "metal drill";
  build {
    require "metal drill";
    atDeep (until (has "mithril") {drill down});
    give base "mithril"
  };
  salvage
end


////////////////////////////////////////////////////////////
// Classic mode automation
////////////////////////////////////////////////////////////
def step0: Cmd Unit =
  log "Please (1) Get a lambda manually (2) Get 5 trees (grabXX, grabrow) (3) run step1"
end

def step1: Cmd Unit =
  log "Making harvester, branch predictor, + boat...";
  makeH;
  makeBP;
  makeB;
  log "Planting lambda under the base...";
  place "lambda";
  build {harvest};
  wait 1;
  slv;
  log "Please obtain >= 18 trees using harvestline/harvestbox (save def), then run step2"
end

def step2: Cmd Unit =
  log "Making logs, branch predictors, workbenches, + a second harvester...";
  x15 (make "log");
  x9 (make "branch predictor");
  equip "branch predictor";
  x3 (make "board"; make "workbench");
  makeH;
  log "Please grab 5 rocks, harvest more trees, >= 4 copper ore, then run step3"
end

def step3: Cmd Unit =
  log "Making furnace...";
  make "furnace";
  equip "furnace";
  log "Making copper wire and strange loops...";
  while (andC (has "copper ore") (has "log")) {make "copper wire"};
  x20 (make "strange loop");
  log "Building lambda harvester...";
  build {tend "lambda" (\c. c)};
  log "Building extra harvester...";
  makeH;
  log "Please (1) harvest more trees, (2) get 2 LaTeX, (3) define shingle context + farm context (maybe clear some land first), (4) ensure you have >= 5 lambdas, then (5) run step4 with contexts."
end


// Prep for farms.  Gets 2 branch predictors + 1 harvester per farm.
def prepFarms1: Ctx -> Rep -> Cmd Actor 
  = \atShingles. \rep.
  fetcher <- build {atShingles (rep (x2 getBranchPredictor; getHarvester))};
  pure fetcher
end

def step4: Ctx -> Ctx -> Cmd Unit 
  = \atShingles. \atFarm.
  buildStdFarm atShingles atFarm "tree";
  x4 (make "log");
  x2 (make "rubber"; make "rubber band");
  buildTreeProcess atShingles;
  prepFarms1 atShingles x2;
  log "Please (1) salvage fetcher bot (2) ensure >= 4 strange loops (3) get two of each bit and start bit farms (4) ensure 24 copper wire, then run step5 atShingles."
end

def step5: Ctx -> Cmd Unit 
  = \atShingles.
  log "Obtaining devices and materials for mining operations...";
  fetcher <- build {
    require 24 "copper wire";
    atShingles (
      getProvided x4 "bit (0)";
      getProvided x4 "bit (1)";
      x4 (make "drill bit");
      getProvided x64 "log";
      x64 (make "board");
      getProvided x6 "log";
      x6 (make "board");
      x4 makeD;
      getProvided x14 "branch";
      x7 (
        make "branch predictor" // for the rock depot + 3 mines

      )
    )
  };
  log "Please (1) salvage drill fetcher robot (2) ensure 7 strange loops (3) build rock depot (save reference) (4) drill mountains (5) define contexts for mines and run buildMine for each, (6) run step6."
end


// Prep for farms, once we have copper + rock depots.  Gets 2 branch
// predictors + 1 harvester + 5 strange loops per farm (we only need 2
// strange loops per farm, but at this point it's easier to just make
// too many than to calculate the correct number, since we don't yet
// have anything like a calculator or counter etc.)
def prepFarms2: Ctx -> Rep -> Cmd Actor 
  = \atShingles. \rep.
  fetcher <- build {
    atShingles (rep (x2 getBranchPredictor; getHarvester; get5StrangeLoops))
  };
  pure fetcher
end

def step6: Ctx -> Cmd Unit 
  = \atShingles.
  prepFarms2 atShingles x1;
  log "Please (1) salvage fetcher robot (2) get 2 LaTeX (3) build LaTeX farm (4) run step7"
end // atNE, uL, etc.
 // x5, etc.
