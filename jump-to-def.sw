def f : Int -> Int = \y.
  y + ((\x. y + 2) 3)
end

def g = \x. [x = x] end

def h =
  move;
  move;
  x <- drill down;
  x <- drill down;
  y <- scan down;
  pure x
end
