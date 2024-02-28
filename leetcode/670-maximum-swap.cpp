class Solution {
public:
    int maximumSwap(int num) {
        // int max_n = -1;
        // int max_flag = 0;
        // int ret = num;
        // int total_flag = 0;
        // while (ret > 9) {
        //     if (ret % 10 > max_n) {
        //         max_n = ret % 10;
        //         max_flag = total_flag;
        //     }
        //     ret = ret / 10;
        //     total_flag += 1;
        // }
        // if (ret < max_n) {
        //     return num + (max_n - ret) * (pow(10, total_flag) - pow(10, max_flag));
        // }
        // return num;
        string charArray = to_string(num);
        int n = charArray.size();
        int maxIdx = n - 1;
        int idx1 = -1, idx2 = -1;
        for (int i = n - 1; i >= 0; i--) {
            if (charArray[i] > charArray[maxIdx]) {
                maxIdx = i;
            } else if (charArray[i] < charArray[maxIdx]) {
                idx1 = i;
                idx2 = maxIdx;
            }
        }
        if (idx1 >= 0) {
            swap(charArray[idx1], charArray[idx2]);
            return stoi(charArray);
        } else {
            return num;
        }
    }
};