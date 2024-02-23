/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode() : val(0), left(nullptr), right(nullptr) {}
 *     TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
 *     TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
 * };
 */
class Solution {
public:
    long long kthLargestLevelSum(TreeNode* root, int k) {
        queue<TreeNode*> layer, layer_next;
        priority_queue<long long, vector<long long>, greater<long long>> topk;
        layer.push(root);
        while (!layer.empty()) {
            long long sum = 0;
            while (!layer.empty()) {
                sum += layer.front()->val;
                if (layer.front()->left != nullptr) {
                    layer_next.push(layer.front()->left);
                }
                if (layer.front()->right != nullptr) {
                    layer_next.push(layer.front()->right);
                }
                layer.pop();
            }
            topk.push(sum);
            layer.swap(layer_next);
        }

        if (size(topk)<k) {
            return -1;
        }
        while (size(topk)>k) {
            topk.pop();
        }
        return topk.top();

        // vector<long long> levelSumArray;
        // sort(levelSumArray.begin(), levelSumArray.end());
        // return *(levelSumArray.end() - k);
    }
};
