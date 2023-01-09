////////////////////////////////////////////////////////////
// Startup
////////////////////////////////////////////////////////////

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

// Execute this *from* the depot, i.e.  atDepot (mine ...)
def mine = \thing. \atMine. \r.
  setname (thing ++ " miner");
  forever {
    atMine (x16 (drill down));
    giveall r thing
  }
end

def transport = \thing. \x1. \y1. \r. \x2. \y2.
  moveByN x1 y1;
  forever {
    x8 (get thing);
    moveByN (x2 - x1) (y2 - y1);
    x8 (give r thing);
    moveByN (x1 - x2) (y1 - y2)
  }
end

// Making specific things needed for bootstrapping

def make_counter = \atB0. \atB1.
  build {
    atB0 (x8 (get "bit (0)"));
    atB1 (x8 (get "bit (1)"));
    make "counter"
  }
end

def make_comparator = \atLog. \atCopper.
  r <- build {
    wait 3;
    atLog (x3 (get "log"));
    x2 (make "board");
    x2 (make "wooden gear");
    make "teeter-totter";
    atCopper (get "copper ore");
    make "copper wire";
    make "comparator";
    give parent "comparator"
  };
  give r "furnace"
end

def prep_provider = \atLog. \atBranch. \atCopper. \atB0. \atB1.
  r <- build {
    wait 5;
    atLog (x4 (get "log"));
    make "logger";
    x2 (make "board");
    x2 (make "wooden gear");
    make "teeter-totter";
    atCopper (get "copper ore");
    make "copper wire";
    make "comparator";
    atB0 (x16 (get "bit (0)"));
    atB1 (x16 (get "bit (1)"));
    x2 (make "counter"); make "calculator";
    make "strange loop";
    atBranch (x4 (get "branch"));
    make "workbench";
    make "branch predictor"
  };
  give r "furnace";
  give r "solar panel";  // make this!
  return r
end

def prep_provider_C = \atLog. \atBranch. \atCopper. \atCounter.
  r <- build {
    wait 5;
    atLog (x4 (get "log"));
    make "logger";
    x2 (make "board");
    x2 (make "wooden gear");
    make "teeter-totter";
    atCopper (get "copper ore");
    make "copper wire";
    make "comparator";
    atCounter (x2 (get "counter")); make "calculator";
    make "strange loop";
    atBranch (x4 (get "branch"));
    make "workbench";
    make "branch predictor"
  };
  give r "furnace";
  give r "solar panel";  // make this!
  return r
end

// Generic producers

// provide1, provide2, etc. need:
//   - calculator
//   - comparator
//   - lambda
//   - strange loop
//   - workbench
//   - branch predictor
//   - logger

def provide0 = \product.
  setname (fst product ++ " depot");
  snd product (
    forever {
      waitWhile (ishere (fst product));
      waitUntil (has (fst product));
      place (fst product);
    }
  )
end

def provide1 = \buffer. \product. \ingr1.
  setname (fst product ++ " provider");
  forever {
    snd product (
      while (has (fst product)) {
        waitWhile (ishere (fst product));
        place (fst product)
      }
    );
    snd (snd ingr1) (x (buffer * fst ingr1) (get (fst (snd ingr1))));
    x buffer (make (fst product));
  }
end

def provide2 = \buffer. \product. \ingr1. \ingr2.
  setname (fst product ++ " provider");
  forever {
    snd product (
      while (has (fst product)) {
        waitWhile (ishere (fst product));
        place (fst product)
      }
    );
    snd (snd ingr1) (x (buffer * fst ingr1) (get (fst (snd ingr1))));
    snd (snd ingr2) (x (buffer * fst ingr2) (get (fst (snd ingr2))));
    x buffer (make (fst product));
  }
end

// Automated setup of standard 4x8 plantation + depot.
// It will look like this:
//
//   >........
//    ........
//    ........
//    ........
//
// where > is the location and orientation of a robot under execution of 'there'.
// > will be the location of the depot.  To obtain
// resources from the depot, go to its cell and execute 'get
// <resource>'.
//
// Requirements:
//   - branch predictor (2)
//   - lambda (2)
//   - strange loop (2)
//   - logger (2)   -- or whatever is needed for ++
//   - harvester
//
// example:
//
//   def atB0 = \c. atSW m2 m5 (uB c) end
//   plantation "bit (0)" atB0

def plantation : text -> (cmd unit -> cmd unit) -> cmd unit = \product. \there.
  depot <- build {provide0 (product, there)};
  harvester <- build {
    setname (product ++ " harvester");
    waitFor product;
    there (
      m1;
      plant_garden right x4 x8 product;
      tendbox right x4 x8 product depot
    )
  };
  give harvester product
end

def natural_plantation : text -> (cmd unit -> cmd unit) -> cmd unit = \product. \there.
  depot <- build {provide0 (product, there)};
  build {
    setname (product ++ " harvester");
    there (
      m1;
      tendbox right x4 x8 product depot
    )
  };
  return ()
end

// Trees have to be dealt with specially, because the recipe for processing
// trees has two outputs.
//
// Requirements:
//   - branch predictor (3)
//   - lambda (3)
//   - strange loop (3)
//   - logger (3)
//   - workbench

def process_trees = \there.
  log_depot <- build {there (tR; m1; provide0 ("log", \c.c))};
  branch_depot <- build {there (tR; m2; provide0 ("branch", \c.c))};
  build {
    setname "tree processor";
    there (
      forever {
        get "tree"; make "log";
        tR; m1; give log_depot "log";
        m1; x2 (give branch_depot "branch");
        tB; m2; tR
      }
    )
  }
end

// Requirements:
//   - branch predictor (5)
//   - lambda (5)
//   - strange loop (5)
//   - logger (5)
//   - workbench
//   - harvester
def tree_plantation = \there.
  plantation "tree" there; process_trees there
end
