/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode reverseList(ListNode head) {
        if (head == null || head.next == null) return head;
        ListNode p = head, p_next = head.next;
        p.next = null;

        while (p_next != null) {
            ListNode p_next_next = p_next.next;

            p_next.next = p;

            p = p_next;
            p_next = p_next_next;
        }
        return p;
    }
}
