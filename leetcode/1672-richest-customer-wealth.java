class Solution {
    public int maximumWealth(int[][] accounts) {
        int[] wealth = new int[accounts.length];

        int maxflag = 0;

        for (int idx = 0; idx < accounts.length; idx ++) {
            int sum = 0;
            for (int value : accounts[idx]) {
                sum += value;
            }
            wealth[idx] = sum;
            if (sum > wealth[maxflag]) {
                maxflag = idx;
            }
        }
        return wealth[maxflag];
    }
}