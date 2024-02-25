class Solution {
    public int[] plusOne(int[] digits) {
        int length = digits.length;
        int carry = 1;
        for (int idx = length - 1; idx > -1; idx --) {
            digits[idx] += carry;
            carry = digits[idx] / 10;
            digits[idx] = digits[idx] % 10;
            if (carry == 0) break;
        }
        if (carry == 1) {
            int[] digits_new = new int[length+1];
            // for (int idx = 0; idx < length; idx ++) {
            //     digits_new[idx+1] = digits[idx];
            // }
            digits_new[0] = carry;
            return digits_new;
        }
        return digits;
    }
}