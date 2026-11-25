import "~swarm/lib/control"
import "~swarm/lib/list"

def belt : Int -> Actor -> Cmd Unit = \n. \target.
  doN n move;
  forever (
    ifC (has "rock") {
      give target "rock"
    }
    {}
  )
end

def buildRobots : Int -> Cmd (List Actor) = \n.
  for n (\_. build {})
end

def zip : List a -> List b -> List (a * b) = \l1. \l2.
  case l1 (\_. inl ()) (λmatch \hd1. \tl1.
  case l2 (\_. inl ()) (λmatch \hd2. \tl2.
  inr ((hd1, hd2), zip tl1 tl2)))
end

def upto : Int -> Int -> List Int = \k. \n.
  if (k > n) {inl ()} {inr (k, upto (k+1) n)}
end

def index : Int -> List a -> a = \i. λcase
  (\_. fail "bad index")
  (λmatch \hd. \tl. if (i == 0) {hd} {index (i-1) tl})
end

def makeBelt : Int -> Cmd (Actor * Actor) = \n.
  robots <- buildRobots n;
  mapM_ (λmatch \i. \r. if (i < n) {reprogram r {turn east; belt i (index i robots)}} {}) (zip (upto 1 n) robots);
  reprogram (index (n-1) robots) {turn east; doN n move};
  pure (index 0 robots, index (n-1) robots)
end

// In a Creative world, run 'makeBelt 10', then create a "rock", pause
// the game, and give the rock to the first robot in the chain (the
// first one returned by makeBelt).  Now 'view' the last robot in the
// chain (the second one returned by makeBelt), single-step the game,
// and notice that it takes only one tick for the last robot to get the
// rock.
