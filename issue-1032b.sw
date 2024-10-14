def go
  = \n.
  if (n > 0) {
    i <- return n;
    s <- go (n - 1);
    return (s + i)
  }
  {return 0}
end;

go 4
