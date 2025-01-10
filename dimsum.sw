def x4 = \c. c; c; c; c end

def x8 = \c. x4 c; x4 c end

def x32 = \c. x4 (x8 c) end

def swapfwd = move; move; turn back; push; turn back end

def swap8 = x8 swapfwd end

def swapSq = x4 (swap8; turn right) end

def feeding = x32 swapSq end

def solution = feeding; feeding end