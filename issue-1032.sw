def go 
  = \n.
  if (n > 0) {
    idx <- random 4;
    (log $ "In: " ++ format idx);
    (go $ n - 1);
    (log $ "Out: " ++ format idx);
    move
  } {}
end

go 4