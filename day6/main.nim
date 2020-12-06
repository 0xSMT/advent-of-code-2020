import sequtils, strutils, math, os, sugar, tables

type
    Report = object
        answers:    CountTable[char]
        people:     int

proc m(str: string): Report =
    var answers = initCountTable[char]()

    var num_people = str.splitLines.len
    for line in str.splitLines:
        for chr in line:
            answers.inc(chr)

    return Report(answers: answers, people: num_people)

let reports = paramStr(1).open.readAll.split("\n\n").map(m)

echo reports.map(
    r => toSeq(r.answers.keys).len
).sum

echo reports.map(
    r => toSeq(r.answers.values).filter(
        t => t == r.people
    ).len
).sum
