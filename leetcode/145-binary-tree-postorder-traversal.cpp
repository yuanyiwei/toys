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
    vector<int> postorderTraversal(TreeNode *root) {
        if (root == nullptr) { return {}; }
        vector<int> ret;
        stack<TreeNode *> s;
        TreeNode *ptr = root, *last = nullptr;
        while (!s.empty() || ptr != nullptr) {
            while (ptr != nullptr) {
                s.emplace(ptr);
                ptr = ptr->left;
            }
            ptr = s.top();
            s.pop();

            if (ptr->right == nullptr || ptr->right == last) {
                ret.emplace_back(ptr->val);
                last = ptr;
                ptr = nullptr;
            } else {
                s.emplace(ptr);
                ptr = ptr->right;
            }
        }
        return ret;
    }
};