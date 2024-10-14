tydef List a = rec l. Unit + a * l end

def length : List a -> Int = \xs.
  case xs
    (\_. 0)
    (\c. 1 + length (snd c))
end
