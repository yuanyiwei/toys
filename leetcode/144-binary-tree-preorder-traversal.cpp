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
    vector<int> preorderTraversal(TreeNode* root) {
        if (root == nullptr) { return {}; }
        vector<int> ret;
        stack<TreeNode*> s;
        TreeNode* ptr = nullptr;
        s.emplace(root);
        // s.push(root);
        while (!s.empty()) {
            ptr = s.top();
            s.pop();
            ret.emplace_back(ptr->val);
            // ret.push_back(ptr->val);
            if (ptr->right != nullptr) { s.emplace(ptr->right); }
            if (ptr->left != nullptr) { s.emplace(ptr->left); }
        }
        return ret;
    }
};