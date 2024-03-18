class Solution:
    def isSubstringPresent(self, s: str) -> bool:
        reversed_s = s[::-1]
        for i in range(len(s) - 1):
            sub_str = s[i:i+2]
            if sub_str in reversed_s:
                return True
        return False