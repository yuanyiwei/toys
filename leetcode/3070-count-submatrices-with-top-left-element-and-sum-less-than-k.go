func countSubmatrices(grid [][]int, k int) int {
    m, n := len(grid), len(grid[0])
    sum := make([][]int, m+1)
    for i := range sum {
        sum[i] = make([]int, n+1)
    }
    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            sum[i][j] = sum[i-1][j] + sum[i][j-1] - sum[i-1][j-1] + grid[i-1][j-1]
        }
    }

    ans := 0

    for j := 1; j <= n; j++ {
        left, right := 1, m+1
        for left < right {
            mid := (left + right) >> 1
            if sum[mid][j] <= k {
                left = mid + 1
            } else {
                right = mid
            }
        }
        ans += left - 1
    }

    return ans
}