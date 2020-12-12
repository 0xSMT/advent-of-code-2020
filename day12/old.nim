import sequtils, strutils, os, math

type
    Instr = object
        dir:    Dir
        amt:    int
    Dir = enum
        North, South, East, West, Left, Right, Forward

proc parse(s: string): Instr =
    case s[0]:
    of 'L':
        return Instr(dir: Left, amt: s[1..^1].parseInt)
    of 'R':
        return Instr(dir: Right, amt: s[1..^1].parseInt)
    of 'F':
        return Instr(dir: Forward, amt: s[1..^1].parseInt)
    of 'N':
        return Instr(dir: North, amt: s[1..^1].parseInt)
    of 'S':
        return Instr(dir: South, amt: s[1..^1].parseInt)
    of 'E':
        return Instr(dir: East, amt: s[1..^1].parseInt)
    of 'W':
        return Instr(dir: West, amt: s[1..^1].parseInt)
    else:
        raise ValueError.newException(s)

proc parse1(actions: seq[Instr]) =
    var x = 0
    var y = 0
    var theta = 0.0

    for action in actions:
        case action.dir:
        of East:
            x = x + action.amt
        of West:
            x = x - action.amt
        of North:
            y = y + action.amt
        of South:
            y = y - action.amt
        of Left:
            theta = theta + math.degToRad(action.amt.float)
        of Right:
            theta = theta - math.degToRad(action.amt.float)
        of Forward:
            x = x + cos(theta).round.int * action.amt
            y = y + sin(theta).round.int * action.amt
        
    echo abs(x) + abs(y)

proc parse2(actions: seq[Instr]) =
    var way_x = 10
    var way_y = 1
    var x = 0
    var y = 0

    for action in actions:
        case action.dir:
        of East:
            way_x = way_x + action.amt
        of West:
            way_x = way_x - action.amt
        of North:
            way_y = way_y + action.amt
        of South:
            way_y = way_y - action.amt
        of Left:
            let theta = math.degToRad(action.amt.float)
            let tway_x = round(cos(theta) * (way_x).float - sin(theta) * (way_y).float).int
            way_y = round(sin(theta) * (way_x).float + cos(theta) * (way_y).float).int
            way_x = tway_x
        of Right:
            let theta = -math.degToRad(action.amt.float)
            let tway_x = round(cos(theta) * (way_x).float - sin(theta) * (way_y).float).int
            way_y = round(sin(theta) * (way_x).float + cos(theta) * (way_y).float).int
            way_x = tway_x
        of Forward:
            x = x + way_x * action.amt
            y = y + way_y * action.amt
        
    echo abs(x) + abs(y)

let actions: seq[Instr] = paramStr(1).open.readAll.splitLines.map(parse)

actions.parse1
actions.parse2