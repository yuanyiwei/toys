# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def reverseKGroup(self, head: Optional[ListNode], k: int) -> Optional[ListNode]:
        # total len
        length = 0
        curr = head
        while curr:
            length += 1
            curr = curr.next

        plastgroup = dummy = ListNode(next=head)
        pre = None
        cur = head
        while length >= k:
            length -= k
            for _ in range(k):
                nxt = cur.next
                cur.next = pre
                pre = cur
                cur = nxt

            nxt = plastgroup.next
            nxt.next = cur
            plastgroup.next = pre
            plastgroup = nxt
        return dummy.next