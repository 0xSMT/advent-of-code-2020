import sequtils, strutils, math, os, re, tables

proc m(str: string): int =
    var answers = initTable[char, int]()

    var num_people = str.splitLines.len
    for line in str.splitLines:
        for chr in line:
            if answers.hasKey(chr):
                inc answers[chr]
            else:
                answers[chr] = 1

    var t = 0
    for k in answers.keys:
        if answers[k] == num_people:
            inc t

    return t  

echo paramStr(1).open.readAll.split("\n\n").map(m).sum