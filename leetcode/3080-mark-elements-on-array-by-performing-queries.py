class Solution:
    def unmarkedSumArray(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        marked = set()
        pq = [(val, idx) for idx, val in enumerate(nums)]
        heapq.heapify(pq)
        ret = []
        sum_unmarked = sum(nums)

        for query in queries:
            index, k = query

            if index not in marked:
                marked.add(index)
                sum_unmarked -= nums[index]
            while k > 0 and pq:
                while pq and pq[0][1] in marked:
                    heapq.heappop(pq)
                if pq:
                    val, idx = heapq.heappop(pq)
                    if idx not in marked:
                        marked.add(idx)
                        sum_unmarked -= nums[idx]
                        k -= 1

            ret.append(sum_unmarked)

        return ret