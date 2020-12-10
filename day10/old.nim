import sequtils, strutils, os, math, algorithm, tables

let numbers = @[0] & paramStr(1).open.readAll.splitLines.map(parseInt).sorted
let phone = numbers.max + 3
let sorted = numbers & @[phone]
var diffs: seq[int] = @[]

for idx, num in sorted[0..<sorted.high].pairs:
    diffs.add sorted[idx + 1] - num

echo diffs.count(1) * diffs.count(3)

let reversed = sorted[0..^2].reversed

var record = initTable[int, int]()
record[phone] = 1

for elem in reversed:
    record[elem] = 0
    for i in countup(1, 3):
        if (elem + i) in record:
            record[elem] = record[elem] + record[elem + i]
    
echo record[0]