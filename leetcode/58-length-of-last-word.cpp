class Solution {
public:
    int lengthOfLastWord(string s) {
        int n = s.size();
        int end = -1;
        int start = -1;
        for (int idx = n-1; idx >= 0; idx --) {
            if (s[idx] == ' ') {
                if (start == -1 && end == -1) {
                    continue;
                } else if (start == -1) {
                    start = idx;
                    break;
                }
            } else {
                if (end == -1) {
                    end = idx;
                }
            }
        }
        return end - start;
    }
};