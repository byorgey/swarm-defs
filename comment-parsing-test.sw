// This function does a cool math thing
def foo : Int -> Int =     // This is an optional type signature
  // pre
  \n. n + 1    // add one
end

/* This is a
   block comment which
   spans multiple lines */

def bar : Int -> Int   // Another type signature, = on the next line
  = \x. foo /* very important to use foo here */ (foo x)   // very cool implementation
end

def baz : Cmd Unit =
  move;
  move;
  turn left;   // don't forget to turn left!
  move
end

// And one last thing
