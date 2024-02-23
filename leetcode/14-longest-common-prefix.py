class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        minlen = min([len(s) for s in strs])
        if minlen == 0:
            return ""
        for idx in range(minlen):
            if self.compare([s[idx] for s in strs]) == False:
                return strs[0][:idx]
        return strs[0][:minlen]


    def compare(self, l):
        if min(l) == max(l):
            return True
        else:
            return False