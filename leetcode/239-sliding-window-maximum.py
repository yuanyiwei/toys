class Solution:
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        l = len(nums)
        q = []
        ret = []
        if k >= 2:
            for i in range(k-1):
                while q and nums[i] > q[-1]:
                    q.pop()
                q.append(nums[i])
            for i in range(k-1,l):
                if q[0] == nums[i-k]:
                    q.pop(0)
                while q and nums[i] > q[-1]:
                    q.pop()
                q.append(nums[i])
                ret.append(q[0])
        else:
            ret = nums
        return ret