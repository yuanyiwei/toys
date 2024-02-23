class Solution {
    public int search(int[] nums, int target) {
        return binsearch(nums, target, 0, nums.length-1);
    }

    public int binsearch(int[] nums, int target, int low, int high) {
        if (low > high) {
            return -1;
        }
        int mid = (high + low) / 2;
        if (nums[mid] == target) {
            return mid;
        } else if (nums[mid] < target) {
            return binsearch(nums, target, mid + 1, high);
        } else if (nums[mid] > target) {
            return binsearch(nums, target, low, mid - 1);
        }
        return 0;
    }
}