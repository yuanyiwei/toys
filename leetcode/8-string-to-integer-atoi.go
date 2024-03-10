type Automaton struct {
    state  string
    sign   int
    ans    int
    table  map[string][]string
}

func (this *Automaton) get_col(c rune) int {
    if unicode.IsSpace(c) {
        return 0
    }
    if c == '+' || c == '-' {
        return 1
    }
    if unicode.IsDigit(c) {
        return 2
    }
    return 3
}
func (this *Automaton) get(c rune) {
    this.state = this.table[this.state][this.get_col(c)]
    if this.state == "num" {
        this.ans = this.ans*10 + int(c-'0')
        if this.sign == 1 {
            this.ans = min(this.ans, math.MaxInt32)
        } else {
            this.ans = min(this.ans, -math.MinInt32)
        }
    } else if this.state == "sig" {
        if c == '+' {
            this.sign = 1
        } else {
            this.sign = -1
        }
    }
}

func myAtoi(s string) int {
    automaton := Automaton{
        state: "start",
        sign:  1,
        ans:   0,
        table: map[string][]string {
            "start": {"start", "sig", "num", "end"},
            "sig":   {"end", "end", "num", "end"},
            "num":   {"end", "end", "num", "end"},
            "end":   {"end", "end", "end", "end"},
        },
    }
    for _, c := range s {
        automaton.get(c)
    }
    return automaton.sign * automaton.ans
}

