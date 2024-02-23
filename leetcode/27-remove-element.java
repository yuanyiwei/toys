class Solution {
    public int removeElement(int[] nums, int val) {
        if (nums.length == 0) {
            return 0;
        }
        int start_flag = 0;
        int final_flag = nums.length-1;
        while (start_flag < final_flag) {
            if (nums[final_flag] == val) {
                final_flag -= 1;
            } else if (nums[start_flag] != val) {
                start_flag += 1;
            } else if (nums[start_flag] == val && nums[final_flag] != val) {
                nums[start_flag] = nums[final_flag];
                nums[final_flag] = val;
            }
        }

        if (start_flag == 0 && nums[start_flag] == val) {
            return 0;
        }
        return start_flag+1;
    }
}