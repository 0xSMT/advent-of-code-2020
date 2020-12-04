import sequtils, strutils, math, os, re

proc bin(c: char): int = 
    if c == '#': return 1
    else:        return 0

proc m(s: string): seq[int] = 
    return s.map(bin)

proc calc_trees(dx, dy: int, lines: seq[seq[int]]): int =
    var x = 0
    var y = 0

    let width = lines[0].len
    let height = lines.len

    var total = 0

    while y < height - 1:
        x = (x + dx) mod width
        y = y + dy

        total = total + lines[y][x]
    
    total

let lines = paramStr(1).open.readAll.splitLines.map(m)

echo calc_trees(1, 1, lines) * calc_trees(3, 1, lines) * calc_trees(5, 1, lines) * calc_trees(7, 1, lines) * calc_trees(1, 2, lines)