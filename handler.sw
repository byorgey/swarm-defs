def cons : a * b -> (a -> b) -> (a -> b) = \p. \k. \a.
  if (a == fst p) {snd p} {k a}
end

def nil : a -> cmd unit = \a. return () end

def handlerB : {key -> cmd unit} -> key -> cmd unit = \hA. \k.
  cons (key "b", move) nil k;
  installKeyHandler "" (force hA)
end

def handlerA : key -> cmd unit =
  cons (key "a", installKeyHandler "" (handlerB {handlerA})) nil
end
