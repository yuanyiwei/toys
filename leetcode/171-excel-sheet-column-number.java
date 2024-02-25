class Solution {
    public int titleToNumber(String columnTitle) {
        if (columnTitle.length() == 1) {
            return columnTitle.charAt(0)-'A'+1;
        }
        int end = columnTitle.charAt(columnTitle.length()-1)-'A'+1;
        return 26*titleToNumber(columnTitle.substring(0, columnTitle.length()-1))+end;
    }
}