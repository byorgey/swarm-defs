def cons: ∀ a b. a * b -> (a -> b) -> a -> b
  = \p. \k. \a.
  if (a == fst p) {snd p} {k a}
end

def nil: ∀ a. a -> Cmd Unit = \a. return () end

def handlerB: {Key -> Cmd Unit} -> Key -> Cmd Unit
  = \hA. \k.
  cons (key "b", move) nil k;
  installkeyhandler "" (force hA)
end

def handlerA: Key -> Cmd Unit =
  cons (key "a", installkeyhandler "" (handlerB {handlerA})) nil
end
