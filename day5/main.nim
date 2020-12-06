import sequtils, strutils, os

proc m(str: string): int =
    let row = str.replace('F', '0').replace('B', '1')[0..<7].parseBinInt
    let col = str.replace('L', '0').replace('R', '1')[7..^1].parseBinInt

    return row * 8 + col

let seats = paramStr(1).open.readAll.splitLines.map(m)

echo seats.max
for row in countup(1, 126):
    for col in countup(0, 7):
        let id = row * 8 + col

        if id notin seats and (id + 1 in seats) and (id - 1 in seats):
            echo id