class Solution {

    public int strStr(String haystack, String needle) {
        int i = 0, j = 0;
        char[] src = haystack.toCharArray();
        char[] pattern = needle.toCharArray();
        int sLen = src.length, patternLen = pattern.length;
        int[] next = getNext(pattern);
        while (i < sLen && j < patternLen) {
            if (j == -1 || src[i] == pattern[j]) {
            i++;
            j++;
            } else {
            j = next[j];
            }
        }
        if (j == patternLen) {
            return i - j;
        }
        return -1;
    }

    public int[] getNext(char[] p) {
        // kmp
        int patternLen = p.length;
        int[] next = new int[patternLen];
        int k = -1;
        int j = 0;

        next[0] = -1;
        while (j < patternLen - 1) {
            if (k == -1 || p[j] == p[k]) {
            k++;
            j++;
            if (p[j] != p[k]) {
                next[j] = k;
            } else {
                next[j] = next[k];
            }
            } else {
            k = next[k];
            }
        }
        return next;
    }
  }