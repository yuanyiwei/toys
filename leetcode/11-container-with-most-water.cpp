class Solution {
public:
    int maxArea(vector<int>& height) {
        int l = 0, r = height.size()-1;
        int max_area = min(height[l], height[r]) * r;
        while (l < r) {
            if (height[l] < height[r]) {
                int idx = l+1;
                while ((height[idx] <= height[l]) && idx < r) {
                    idx++;
                }
                l = idx;
            } else {
                int idx = r-1;
                while ((height[idx] <= height[r]) && idx > l) {
                    idx--;
                }
                r = idx;
            }
    //        int now_area = min(height[l], height[r]) * (r - l);
    //        if (now_area > max_area) {
    //            max_area = now_area;
    //        }
            max_area = max(min(height[l], height[r]) * (r - l), max_area);
        }
        return max_area;
    }
};