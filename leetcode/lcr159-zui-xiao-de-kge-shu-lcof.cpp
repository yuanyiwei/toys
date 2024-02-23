class Solution {
public:
    vector<int> inventoryManagement(vector<int>& stock, int cnt) {
        int len = stock.size();
        if (cnt == len) {
            return stock;
        }
        if (cnt == 0) {
            return {};
        }


        // vector<int> s(stock.begin(), stock.begin()+cnt);
        // // for (int i = 0; i < cnt; i++) {
        // //     s[i] = stock[i];
        // // }
        // sort(s.begin(), s.end());
        // for (int i = cnt; i < len; i++) {
        //     if (stock[i] < s[cnt-1]) {
        //         s[cnt-1] = stock[i];
        //         sort(s.begin(), s.end());
        //     }
        // }


        // sort(stock.begin(), stock.end());
        // vector<int> s(stock.begin(), stock.begin()+cnt);


        priority_queue<int> pq;
        for (int i = 0; i < cnt; i++) {
            pq.push(stock[i]);
        }
        for (int i = cnt; i < len; i++) {
            if (stock[i] < pq.top()) {
                pq.pop();
                pq.push(stock[i]);
            }
        }

        vector<int> s(cnt);
        for (int i = 0; i < cnt; i++) {
            s[i] = pq.top();
            pq.pop();
        }

        return s;
    }
};