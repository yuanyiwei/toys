class Solution:
    def wonderfulSubstrings(self, word: str) -> int:
        cnt = [0] * 1024
        cnt[0] = 1
        ans = s = 0
        for c in word:
            # partial_sum
            s ^= 1 << (ord(c) - ord('a'))
            ans += cnt[s]
            ans += sum(cnt[s ^ (1 << i)] for i in range(10))
            cnt[s] += 1
        return ans