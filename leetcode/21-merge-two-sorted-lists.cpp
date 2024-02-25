/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode() : val(0), next(nullptr) {}
 *     ListNode(int x) : val(x), next(nullptr) {}
 *     ListNode(int x, ListNode *next) : val(x), next(next) {}
 * };
 */
class Solution {
public:
    ListNode* mergeTwoLists(ListNode* list1, ListNode* list2) {
        if (list1 == nullptr) return list2;
        if (list2 == nullptr) return list1;

        ListNode* n1 = list1;
        ListNode* n2 = list2;
        ListNode* r = nullptr;
        ListNode* cur = nullptr;

        if (n1->val < n2->val) {
            r = n1;
            cur = n1;
            n1 = n1->next;
        } else {
            r = n2;
            cur = n2;
            n2 = n2->next;
        }

        while (n1 != nullptr && n2 != nullptr) {
            if (n1->val < n2->val) {
                cur->next = n1;
                cur = cur->next;
                n1 = n1->next;
            } else {
                cur->next = n2;
                cur = cur->next;
                n2 = n2->next;
            }
        }
        if (n1 != nullptr) {
            cur->next = n1;
        } else {
        // if (n2 != nullptr) {
            cur->next = n2;
        }
        return r;
    }
};