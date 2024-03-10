/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
 func hasPathSum(root *TreeNode, targetSum int) bool {
    if root == nil { return false }
    var visitednode []*TreeNode
    var tovisitnode []*TreeNode
    visitednode = append(visitednode, root)
    for len(visitednode) != 0 {
        for _, v := range visitednode {
            if v.Left == nil && v.Right == nil && v.Val == targetSum {
                return true
            }
            if v.Left != nil {
                v.Left.Val += v.Val
                tovisitnode = append(tovisitnode, v.Left)
            }
            if v.Right != nil {
                v.Right.Val += v.Val
                tovisitnode = append(tovisitnode, v.Right)
            }
        }
        visitednode = make([]*TreeNode, len(tovisitnode))
        copy(visitednode, tovisitnode)
        tovisitnode = tovisitnode[:0]
    }
    return false
}