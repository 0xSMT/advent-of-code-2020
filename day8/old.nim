import sequtils, strutils, math, os, re, tables

let regex  = re"(\S+)\s+\+?(\S+)"

type
    Instr = object
        code: string
        amt:  int
    Exit = enum
        INF, TERM
    Status = object
        exit:       Exit
        code:       int

proc parse(line: string): Instr =
    var matches: array[2, string]
    discard line.match(regex, matches)
    return Instr(code: matches[0], amt: matches[1].parseInt)

proc sim(code: seq[Instr]): Status =
    var step = 0
    var visited: seq[int] = @[]
    var acc = 0

    while step < code.len:
        if step in visited:
            return Status(exit: INF, code: acc)
        else: 
            visited.add step

        let ins = code[step]

        case ins.code:
        of "acc":
            acc = acc + ins.amt
            step = step + 1
        of "nop":
            step = step + 1
        of "jmp":
            step = step + ins.amt
    
    return Status(exit: TERM, code: acc)

let code = paramStr(1).open.readAll.splitLines.map(parse)

echo sim(code).code

for idx, ins in code.pairs:
    var temp = code.deepCopy()

    case ins.code:
    of "jmp":   temp[idx] = Instr(code: "nop", amt: ins.amt)
    of "nop":   temp[idx] = Instr(code: "jmp", amt: ins.amt)
    else:       continue

    let status = sim(temp)

    if status.exit == TERM:
        echo status.code