# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        l = ListNode(val=(l1.val+l2.val)%10)
        lt = l
        addone = (l1.val+l2.val)//10
        l1 = l1.next
        l2 = l2.next

        while True:
            if l1 == None and l2 == None:
                if addone != 0:
                    lt.next = ListNode(val=1)
                return l
            lt.next = ListNode()
            lt = lt.next
            if l1 == None:
                lt.val = (addone + l2.val)%10
                addone = (addone + l2.val)//10
                l2 = l2.next
            elif l2 == None:
                lt.val = (addone + l1.val)%10
                addone = (addone + l1.val)//10
                l1 = l1.next
            else:
                lt.val = (addone + l1.val + l2.val)%10
                addone = (addone + l1.val + l2.val)//10
                l1 = l1.next
                l2 = l2.next
