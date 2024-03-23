class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        # for i in range(len(nums)):
        #     for j in range(i+1, len(nums)):
        #         if nums[i] + nums[j] == target:
        #             return [i, j]
        d = {}
        for i in range(len(nums)):
            if target - nums[i] in d.keys():
                return [d[target - nums[i]],i]
            else:
                d[nums[i]] = i
        return [-1]