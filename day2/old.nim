import sequtils, strutils, math, os, re

let pattern = re"(\d+)\-(\d+)\s([a-z])\:\s([a-z]+)"

proc m(s: string): array[4, string] = 
    var matches: array[4, string]
    discard match(s, pattern, matches)
    matches

let lines = paramStr(1).open.readAll.splitLines.map(m)

# version 1
# var total = 0
# for line in lines:
#     let min = line[0].parseInt
#     let max = line[1].parseInt

#     let chr = line[2]

#     let count = line[3].count(chr)
#     if min <= count and count <= max:
#         inc total

# version 2
var total = 0
for line in lines:
    let pos1 = line[0].parseInt
    let pos2 = line[1].parseInt

    let chr = line[2]
    let str = line[3]

    if str[pos1 - 1] == chr[0] xor str[pos2 - 1] == chr[0]:
        inc total

echo total