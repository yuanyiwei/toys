class Solution {
    public int removeDuplicates(int[] nums) {
        int length = nums.length;
        if (length == 1) {
            return 1;
        }

        int ins_pos = 0;
        boolean ins_flag = false;
        for (int idx = 1; idx < length; idx ++) {
            if (ins_flag == false) {
                if (nums[idx] != nums[ins_pos]) {
                    ins_pos += 1;
                } else {
                    ins_flag = true;
                }
            } else {
                if (nums[idx] != nums[ins_pos]) {
                    ins_pos += 1;
                    nums[ins_pos] = nums[idx];
                }
            }
        }
        return ins_pos+1;
    }
}