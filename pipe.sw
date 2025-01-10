def forever : Cmd () -> Cmd () = \c. c ; forever c end

def pass_to : Actor -> Cmd () = \tgt.
  forever (w <- has "water"; if w { give tgt "water" } {})
end

def pump_to : Actor -> Cmd () = \tgt.
  require "boat";
  forever (w <- grab; give tgt w)
end

def lay_pipe_to : Actor -> Cmd () = \tgt.
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
