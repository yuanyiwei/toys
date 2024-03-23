class Solution:
    def trap(self, height: List[int]) -> int:
        n = len(height)
        if n <= 2:
            return 0

        lheight = [height[0]] * n
        rheight = [height[-1]] * n
        for i in range(1,n):
            lheight[i] = max(lheight[i-1], height[i])
        for i in range(n-2,-1,-1):
            rheight[i] = max(rheight[i+1], height[i])

        sum = 0
        for i in range(0,n):
            sum += min(lheight[i], rheight[i]) - height[i]
        return sum