class Solution:
    def subarraySum(self, nums: List[int], k: int) -> int:
        l = len(nums)
        # d = {}
        pre = 0
        # d[0] = 1
        d = {0: 1}
        ret = 0
        for idx in range(l):
            pre += nums[idx]
            if pre-k in d.keys():
                ret += d[pre-k]
            d[pre] = d.get(pre, 0) + 1

        # presum = [0] * (l+1)
        # presum[0] = 0
        # n = set()
        ## [-1,-1,1]
        # for idx in range(1,l+1):
        #     presum[idx] = presum[idx-1]+nums[idx-1]
        #     n.add(presum[idx])

        # print(presum, n)
        ## [0, -1, -2, -1] {-1, -2}

        # for idx in range(l):
        #     if presum[idx]+k in n:
        #         ret += 1
        return ret
