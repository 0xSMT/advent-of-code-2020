import sequtils, strutils, math, os, re

let pattern = re"(\d+)\-(\d+)\s([a-z])\:\s([a-z]+)"

proc m(s: string): array[4, string] = 
    var matches: array[4, string]
    discard match(s, pattern, matches)
    matches

proc v1(passwd: string, min, max: int, chr: char): bool =
    return min <= passwd.count(chr) and passwd.count(chr) <= max

proc v2(passwd: string, pos1, pos2: int, chr: char): bool =
    return passwd[pos1 - 1] == chr xor passwd[pos2 - 1] == chr

let lines = paramStr(1).open.readAll.splitLines.map(m)

var total = 0
for line in lines:
    let n1 = line[0].parseInt
    let n2 = line[1].parseInt

    let chr = line[2][0]
    let str = line[3]

    if str.v2(n1, n2, chr):
        inc total

echo total