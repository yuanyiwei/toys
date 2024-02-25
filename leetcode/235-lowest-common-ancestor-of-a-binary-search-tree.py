# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def lowestCommonAncestor(self, root: 'TreeNode', p: 'TreeNode', q: 'TreeNode') -> 'TreeNode':
        ptr = root
        while ptr != None:
            if p.val > ptr.val and q.val > ptr.val:
                ptr = ptr.right
            elif p.val < ptr.val and q.val < ptr.val:
                ptr = ptr.left
            else:
                break

        return ptr
