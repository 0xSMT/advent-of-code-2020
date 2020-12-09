import sequtils, strutils, os, math

let preamble = paramStr(2).parseInt

let numbers = paramStr(1).open.readAll.splitLines.map(parseInt)
var usables = numbers[0..<preamble]

var secret = 0

block outer:
    for idx, num in numbers[preamble..^1].pairs:
        block inner:
            for i1, n1 in usables.pairs:
                for n2 in usables[i1..^1]:
                    if n1 + n2 == num:
                        usables = numbers[idx + 1..^1]
                        break inner
            
            echo num
            secret = num
            break outer

block outer:
    for start, num1 in numbers.pairs:
        for fin, num2 in numbers[(start)..^1].pairs:
            let true_fin = start + fin
            let s = numbers[start..(true_fin)]
            if s.sum == secret:
                echo s.max + s.min
                break outer
