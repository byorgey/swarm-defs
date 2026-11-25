// Implementing unfoldArrayC in terms of more primitive things

import "~swarm/lib/control"
import "~swarm/lib/list"

def reverse : List a -> List a = \xs.
  let rev : List a -> List a -> List a = \acc. λcase
    (\_. acc)
    (λmatch \x. rev (inr (x, acc)))
  in  rev (inl ()) xs
end

def unfoldArrayCPrim : b -> (b -> Cmd (Unit + a * b)) -> Cmd (Array a) = \seed. \next.
  let go : List a -> b -> Cmd (Array a) = \acc. \seed.
    res <- next seed;
    case res
      (\_. pure (unfoldArray (reverse acc) (\l.l)))
      (λmatch \e. \seed'. go (inr (e, acc)) seed')
  in go (inl ()) seed
end
