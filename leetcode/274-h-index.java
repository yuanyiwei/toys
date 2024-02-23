class Solution {
    public int hIndex(int[] citations) {
        int n = citations.length;
        quickSort(citations, 0, n-1);
        // Arrays.sort(citations);
        int h = 0;
        while (h < n && citations[n-1-h]>h) {
            h+=1;
        }
        return h;
    }
    public static void quickSort(int[] a, int l, int r) {
        if (l < r) {
            int i,j,x;

            i = l;
            j = r;
            x = a[i];
            while (i < j) {
                while(i < j && a[j] > x)
                    j--;
                if(i < j)
                    a[i++] = a[j];
                while(i < j && a[i] < x)
                    i++;
                if(i < j)
                    a[j--] = a[i];
            }
            a[i] = x;
            quickSort(a, l, i-1);
            quickSort(a, i+1, r);
        }
    }
}