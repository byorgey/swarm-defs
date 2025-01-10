tydef Foo a b c = a + ((b * Int) + Cmd c) end

let f1: Foo (Cmd Unit) Int Text = inl move in
let f2: Foo Int (Cmd Unit) Unit = inr (inl (move, 3)) in
let f3: Foo Int Int Text = inr (inr grab) in move