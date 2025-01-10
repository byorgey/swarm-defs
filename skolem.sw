def for_each_bit: Int -> Int -> (Int -> Int -> Cmd a) -> Cmd Unit 
  = \i. \xs. \act.
  if (xs == 0) {} {
    let ht = (xs - 2 * (xs / 2), xs / 2) in
    act i (fst ht);
    for_each_bit (i + 1) (snd ht) act
  }
end