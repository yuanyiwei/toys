class Solution:
    def moveZeroes(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        zeronum = 0
        l = len(nums)
        for i in range(l):
            if nums[i] == 0:
                zeronum += 1
            elif zeronum != 0:
                nums[i-zeronum] = nums[i]
        for i in range(l-1,l-1-zeronum,-1):
            nums[i] = 0