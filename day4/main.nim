import sequtils, strutils, os, re, tables, sugar

proc check1(p: Table[string, string]): bool =
    let needed = @["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

    for key in needed:
        if key notin p: return false
    
    return true

proc check2(p: Table[string, string]): bool =
    try:
        let byr = p["byr"].parseInt
        let iyr = p["iyr"].parseInt
        let eyr = p["eyr"].parseInt
        let hgt = p["hgt"]
        let hcl = p["hcl"]
        let ecl = p["ecl"]
        let pid = p["pid"]

        if byr > 2002 or byr < 1920: return false
        if iyr > 2020 or iyr < 2010: return false
        if eyr > 2030 or eyr < 2020: return false

        let cm   = hgt.find("cm")
        let inch = hgt.find("in")

        if cm > -1:
            let cm = hgt[0..<cm].parseInt
            if cm < 150 or cm > 193: return false
        elif inch > -1:
            let inch = hgt[0..<inch].parseInt
            if inch < 59 or inch > 76: return false
        else: return false

        if not hcl.match(re"^\#[0-9a-f]{6}$"): return false

        if ecl notin @["amb", "blu", "brn", "grn", "gry", "hzl", "oth"]: return false

        if not pid.match(re"^\d{9}$"): return false
    except:
        return false
        
    return true

let pattern = re"([a-z]{3}:\S+)"

let chunks = paramStr(1).open.readAll.split("\n\n")

var passports: seq[Table[string, string]] = @[]
for chunk in chunks:
    var passport = initTable[string, string]()

    let matches = chunk.findAll(pattern)
    for m in matches:
        let entry = m.split(':')
        
        passport[entry[0]] = entry[1]

    passports.add passport

echo passports.filter(check1).len
echo passports.filter(check2).len