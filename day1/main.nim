import sequtils, strutils, math, os

proc simple1(numbers: seq[int], amt: int): int =
    for idx, num1 in numbers.pairs:
        for num2 in numbers[idx..^1]:
            if num1 + num2 == amt:
                return num1 * num2
    
    return 0

proc simple2(numbers: seq[int], amt: int): int =
    for idx1, num1 in numbers.pairs:
        for idx2, num2 in numbers[idx1..^1]:
            for num3 in numbers[idx2..^1]:
                if sum(@[num1, num2, num3]) == amt:
                    return num1 * num2 * num3
    
    return 0

proc recursive(numbers: seq[int], amt: int, size: int, sum: int = 0): int =
        if size > 1:
            for idx, num in numbers.pairs:
                let total = num * recursive(numbers[idx..^1], amt, size - 1, sum + num)

                if total > 0:
                    return total
            
            return 0
        else:
            for idx, num in numbers.pairs:
                if sum + num == amt:
                    return num

            return 0


let numbers = paramStr(1).open.readAll.splitLines.map(parseInt)

echo numbers.recursive(2020, 3)