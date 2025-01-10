def fmap: ∀ a b. (a -> b) -> Cmd a -> Cmd b = \f. \x. a <- x; pure (f a) end

def ifC: ∀ a. Cmd Bool -> {Cmd a} -> {Cmd a} -> Cmd a 
  = \test. \then. \else.
  b <- test;
  if b then else
end

def forever: ∀ a b. {Cmd a} -> Cmd b = \c. force c; forever c end

def while: ∀ a. Cmd Bool -> {Cmd a} -> Cmd Unit 
  = \test. \body.
  ifC test {force body; while test body} {}
end

def until = \test. while (fmap not test) end

def waitUntil = \test. until test {wait 1} end

def pass = \thing. forever {waitUntil (has thing); give parent thing} end

def bb =
  log "hi!";
  h <- scan down;
  if (h == inr "lignite mine") {
    make "bucketwheel excavator";
    forever {drill down; give parent "coal lump"}
  } {
    make "solar panel" // unpack repro kit
    ;
    child <- build {
      require "scanner";
      require "ADT calculator";
      require "comparator";
      require "branch predictor";
      require "workbench";
      require "3D printer";
      require "grabber";
      require "mirror";
      require "lodestone";
      require "metal drill";
      log "waiting for repro kits...";
      wait 10;
      move;
      log "moved, unequipping treads...";
      unequip "treads";
      log "reproducing...";
      bb
    };
    while (has "repro kit") {give child "repro kit"};
    if (self == base) {} {pass "coal lump"}
  }
end

bb