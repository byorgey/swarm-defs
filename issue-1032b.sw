def go = \n. if (n > 0) {i <- pure n; s <- go (n - 1); pure (s + i)} {pure 0}
end

go 4