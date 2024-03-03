func longestPalindrome(s string) string {
    if s == "" {
        return ""
    }

    start, end, l := 0, 0, 0
    for i := 0; i < len(s); i++ {
        left1, right1, l1 := findlr(s, i, i)
        left2, right2, l2 := findlr(s, i, i + 1)
        if l1 > l {
            start, end = left1, right1
            l = end - start
        }
        if l2 > l {
            start, end = left2, right2
            l = end - start
        }
    }
    return s[start:end+1]
}

func findlr(s string, left, right int) (int, int, int) {
    for left >= 0 && right < len(s) && s[left] == s[right] {
        left -= 1
        right += 1
    }
    return left + 1, right - 1, right - left - 2
}