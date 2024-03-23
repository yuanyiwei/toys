# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def hasCycle(self, head: Optional[ListNode]) -> bool:
        p1, p2 = head, head
        # for i in range(9999):
        #     if p2 == None or p2.next == None or p2.next.next == None:
        #         return False
        #     p1 = p1.next
        #     p2 = p2.next.next
        #     if p1 == p2:
        #         return True
        while p2 and p2.next:
            p1 = p1.next
            p2 = p2.next.next
            if p1 == p2:
                return True
        return False
