def forever : cmd () -> cmd () = \c. c ; forever c end

def pass_to : robot -> cmd () = \tgt.
  forever (w <- has "water"; if w { give tgt "water" } {})
end

def lay_pipe_to : robot -> dir -> int -> cmd () = \tgt. \d. \n.
  turn d;
  if (n == 0) {
    forever (w <- grab; give tgt w)
  } {
    next <- build {appear (if (d == north || d == south) {"|"} {"="}); pass_to tgt};
    move;
    lay_pipe_to next d (n-1)
  }
end
