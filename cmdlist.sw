tydef List a = rec l. Unit + a * l end

def nil : List a = inl () end

def cons : a -> List a -> List a = \a. \l. inr (a,l) end

def sequence : List (Cmd a) -> Cmd (List a) = \cmds.
  case cmds
    (\_. pure nil)
    (\c. a <- fst c; aa <- sequence (snd c); pure (cons a aa))
end
