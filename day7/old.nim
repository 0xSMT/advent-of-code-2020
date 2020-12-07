import sequtils, strutils, math, os, re, tables

type
    Rule = object
        name: string
        contains: CountTable[string]

let rule_regex  = re"(\S+\s\S+)\sbags contain\s(.*)\."
let amt_regex   = re"(\d+)\s(.*?)\sbags?"

proc parse_rule(line: string): Rule =
    var matches: array[2, string]
    discard line.match(rule_regex, matches)

    let name = matches[0]
    let contains = matches[1].split(',')

    var ct = initCountTable[string]()

    for c in contains:
        if "no other bags" != c:
            var amt_matches: array[2, string]
            discard c.strip.match(amt_regex, amt_matches)

            ct.inc(amt_matches[1], amt_matches[0].parseInt)
        else:
            discard
    
    return Rule(name: name, contains: ct)

let rules = paramStr(1).open.readAll.splitLines.map(parse_rule)

var bagset = @["shiny gold"]
var fresh = true

while fresh:
    fresh = false
    for rule in rules:
        for bag in bagset:
            if rule.contains.hasKey(bag) and rule.name notin bagset:
                bagset.add rule.name
                fresh = true
                break

echo bagset.len - 1

proc num_bags(bagname: string, rules: seq[Rule]): int =
    for rule in rules:
        if rule.name == bagname:
            if rule.contains.len == 0:
                return 0
            else:
                var tot = toSeq[rule.contains.values].sum
                for key in rule.contains.keys:
                    tot = tot + rule.contains[key] * num_bags(key, rules)
                return tot

echo "shiny gold".num_bags(rules)