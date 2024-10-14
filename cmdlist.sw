tydef List a = rec l. Unit + a * l end

def nil : List a = inl () end

def cons : a -> List a -> List a = \a. \l. inr (a,l) end

def sequence : List (Cmd a) -> Cmd (List a)
sequence = \cmds.
  case cmds
    (\_. return nil)
    (\c. a <- fst c; as <- sequence (snd c); return (cons a as))
end
