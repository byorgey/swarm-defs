def cons: ∀ a b. a -> b -> (a -> b) -> a -> b
  = \k. \v. \f. \a.
  if (a == k) {v} {f a}
end

def nil: ∀ a. a -> Cmd Unit = \a. return () end

def go: Dir -> Cmd Unit = \d. turn d; move end

def drive: Key -> Cmd Unit =
  cons (key "Up") (go north) $ cons (key "Down") (
    go south
  ) $ cons (key "Left") (go west) $ cons (key "Right") (
    go east
  ) $ cons (key "g") (grab; return ()) $ cons (key "h") (
    harvest;
    return ()
  ) $ cons (key "d") (drill forward; return ()) $ cons (
    key "s"
  ) (scan forward; return ()) $ cons (key "u") (
    upload base
  ) $ cons (key "p") push $ nil
end
