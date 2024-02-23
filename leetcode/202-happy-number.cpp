class Solution {
public:
    bool isHappy(int n) {
        // if (n < 0) return false;
        int input = n;
        for (int idx = 0; idx < 1000; idx ++) {
            input = p(input);
            if (input == 1) return true;
            if (input == n) return false;
        }
        return false;
    }

    int p(int n) {
        int sum = 0;
        int input = n;
        while (input > 0) {
            int r = input % 10;
            sum += r*r;
            input = input/10;
        }
        return sum;
    }
};