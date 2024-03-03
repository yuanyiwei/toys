class Solution:
    def reachableNodes(self, n: int, edges: List[List[int]], restricted: List[int]) -> int:
        is_restricted = [0] * n
        for x in restricted:
            is_restricted[x] = 1

        g = [[] for _ in range(n)]
        for v in edges:
            g[v[0]].append(v[1])
            g[v[1]].append(v[0])

        cnt = 0

        def dfs(x, f):
            nonlocal cnt
            cnt += 1
            for y in g[x]:
                if y != f and not is_restricted[y]:
                    dfs(y, x)

        dfs(0, -1)
        return cnt