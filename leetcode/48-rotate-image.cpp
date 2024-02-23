class Solution {
public:
    void swap(vector<vector<int>>& matrix, int i, int j) {
        int n = matrix[0].size();
        int save = matrix[i][j];
        matrix[i][j] = matrix[n-1-j][i];
        matrix[n-1-j][i] = matrix[n-1-i][n-1-j];
        matrix[n-1-i][n-1-j] = matrix[j][n-1-i];
        matrix[j][n-1-i] = save;
    }

    void rotate(vector<vector<int>>& matrix) {
        int n = matrix[0].size();
        int half = n/2;
        for (int i=0; i<half; i++) {
            int j_max = n-1-i;
            for (int j=i; j<j_max; j++) {
                swap(matrix, i, j);
            }
        }
    }

};