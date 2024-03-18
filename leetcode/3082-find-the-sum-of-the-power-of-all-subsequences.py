class Solution:
    def sumOfPower(self, nums: List[int], k: int) -> int:
        mod = 10**9 + 7
        n = len(nums)
        dp = [[0] * (k + 1) for _ in range(n + 1)]
        dp[0][0] = 1

        for i in range(1, n + 1):
            for j in range(k + 1):
                dp[i][j] = dp[i-1][j]*2  # 不选择第 i 个元素的情况
                if j - nums[i-1] >= 0:
                    dp[i][j] += dp[i-1][j-nums[i-1]]  # 选择第 i 个元素的情况
                dp[i][j] %= mod

        # result = 0
        # for i in range(1, n + 1):
        #     result += dp[i][k]
        #     result %= mod

        return dp[n][k]