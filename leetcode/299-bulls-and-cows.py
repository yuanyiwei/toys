class Solution:
    def getHint(self, secret: str, guess: str) -> str:
        l = len(secret)
        s = {}
        g = {}
        a = 0
        b = 0

        for idx in range(l):
        # for s, g in zip(secret, guess):
            if secret[idx] == guess[idx]:
                a += 1
            else:
                if secret[idx] not in s:
                    s[secret[idx]] = 1
                else:
                    s[secret[idx]] += 1

                if guess[idx] not in g:
                    g[guess[idx]] = 1
                else:
                    g[guess[idx]] += 1

        for k in s:
            if k in g:
                b += min(s[k], g[k])
        # cows = sum(min(s, g) for s, g in zip(cntS, cntG))

        return f"{a}A{b}B"