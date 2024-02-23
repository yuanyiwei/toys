class Solution {
public:
    vector<vector<int>> merge(vector<vector<int>>& intervals) {
        sort(intervals.begin(), intervals.end());
        vector<vector<int>> res;
        int start = intervals[0][0];
        int end = intervals[0][1];
        int n = intervals.size();
        for(int i = 1; i < n; i++){
            if(intervals[i][0] > end){
                vector<int> ans = {start, end};
                res.emplace_back(ans);
                start = intervals[i][0];
                end = intervals[i][1];
            }else{
                end = max(end, intervals[i][1]);
            }
        }
        vector<int> ans = {start, end};
        res.emplace_back(ans);
        return res;
    }
};