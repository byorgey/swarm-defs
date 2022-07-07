def forever : cmd () -> cmd () = \c. c ; forever c end

def pass_to : robot -> cmd () = \tgt.
  forever (w <- has "water"; if w { give tgt "water" } {})
end

def pump_to : robot -> cmd () = \tgt.
  require "boat";
  forever (w <- grab; give tgt w)
end

def lay_pipe_to : robot -> cmd () = \tgt.
  require "boat";
  require 1 "boat";
  w <- ishere "water";
  if w {
    build {pump_to tgt}; turn back
  } {
    next <- build {
      // appear (if (d == north || d == south) {"|"} {"="});
      pass_to tgt
    };
    move;
    lay_pipe_to next;
    move
  }
end
