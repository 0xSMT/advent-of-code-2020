import sequtils, strutils, math, os, re, tables

proc check(p: Table[string, string]): bool =
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

let lines = paramStr(1).open.readAll.splitLines

var passports: seq[Table[string, string]] = @[]
var passport = initTable[string, string]()
for line in lines:
    if line.isEmptyOrWhitespace:
        if passport.len > 0:
            passports.add passport

        passport = initTable[string, string]()
    else:
        let matches = line.findAll(pattern)
        for m in matches:
            let entry = m.split(':')

            passport[entry[0]] = entry[1]

passports.add passport

echo passports.filter(check).len