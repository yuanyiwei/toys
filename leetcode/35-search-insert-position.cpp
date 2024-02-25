class Solution {
public:
    int searchInsert(vector<int>& nums, int target) {
        if (target < nums[0]) return 0;
        int n = nums.size();
        int b = bisec(nums, 0, n-1, target);
        if (nums[b] < target) {
            return b+1;
        } else {
            return b;
        }
    }
    int bisec(vector<int>& nums, int l, int r, int target) {
        if (l > r) return r;
        int m = (l+r)/2;
        if (target == nums[m]) {
            return m;
        } else if (target > nums[m]) {
            return bisec(nums, m+1, r, target);
        } else {
            return bisec(nums, l, m-1, target);
        }
    }
};