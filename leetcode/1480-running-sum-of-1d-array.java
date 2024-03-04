class Solution {
    public int[] runningSum(int[] nums) {
        int[] sumout = new int[nums.length];
        sumout[0] = nums[0];
        for (int idx = 1; idx < nums.length; idx++) {
            sumout[idx] = sumout[idx-1] + nums[idx];
        }
        return sumout;
    }
}