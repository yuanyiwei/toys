class Solution {
    public int countDigits(int num) {
        List<Integer> dig = new ArrayList<>();
        int n = num, count = 0;
        while (n > 0){
            dig.add(n % 10);
            n = n/10;
        }
        for (int d : dig) {
            if (num % d == 0) {
                count += 1;
            }
        }
        return count;
    }
}