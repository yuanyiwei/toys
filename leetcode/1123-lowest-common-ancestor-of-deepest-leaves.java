/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    // public HashMap<TreeNode, Integer> map = new HashMap<TreeNode, Integer>();

    public TreeNode lcaDeepestLeaves(TreeNode root) {
        if (root == null)
            return null;
        else {
            int ldep = maxDepth(root.left), rdep = maxDepth(root.right);
            if (ldep == rdep)
                return root;
            else if (ldep>rdep)
                return lcaDeepestLeaves(root.left);
            else
                return lcaDeepestLeaves(root.right);
       }
    }

    int maxDepth(TreeNode root) {
    	if (root == null)
    		return 0;
    	// else if (map.containsKey(root))
        //     return map.get(root);
        else {
            // map.put(root, Math.max(maxDepth(root.left), maxDepth(root.right))+1);
            // return map.get(root);
            return Math.max(maxDepth(root.left), maxDepth(root.right))+1;
        }
    }
}