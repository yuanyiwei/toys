class Solution {
public:
    int findKthLargest(vector<int>& nums, int k) {
        int l = size(nums);
        priority_queue<int, vector<int>, greater<int>> topk;

        for (int i = 0; i < l; i++) {
            topk.emplace(nums[i]);
        }

        if (size(topk)<k) {
            return -1;
        }
        while (size(topk)>k) {
            topk.pop();
        }
        return topk.top();

        // see quickselect
    }
};