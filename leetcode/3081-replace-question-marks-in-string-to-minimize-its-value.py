class Solution:
    def minimizeStringValue(self, s: str) -> str:
        used = [0] * 26
        question_marks = []

        for i, char in enumerate(s):
            if char == '?':
                question_marks.append(i)
            else:
                used[ord(char) - ord('a')] += 1

        used_pq = [(used[i], i) for i in range(26)]
        heapify(used_pq)

        changeval = []

        s = list(s)
        for i in question_marks:
            min_used, char_index = heappop(used_pq)
            changeval.append(char_index)
            heappush(used_pq, (min_used + 1, char_index))
            # min_used = min(used)
            # for j in range(26):
            #     if used[j] == min_used:
            #         changeval.append(j)
            #         used[j] += 1
            #         break

        heapify(changeval)
        for i in question_marks:
            # minchangeval = min(changeval)
            minchangeval = heappop(changeval)
            s[i] = chr(minchangeval + ord('a'))
            # changeval.remove(minchangeval)

        return ''.join(s)