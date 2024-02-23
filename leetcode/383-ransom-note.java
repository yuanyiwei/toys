class Solution {
    public boolean canConstruct(String ransomNote, String magazine) {
        char[] ransomNote_char = ransomNote.toCharArray();
        char[] magazine_char = magazine.toCharArray();
        int[] comp = new int[123]; // a ascii 97
        for (char m : magazine_char) {
            comp[m] += 1;
        }
        for (char r : ransomNote_char) {
            comp[r] -= 1;
        }
        for (int idx = 97; idx < 123; idx ++) {
            if (comp[idx] < 0) return false;
        }
        return true;
    }
}