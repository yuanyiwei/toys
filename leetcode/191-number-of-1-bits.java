public class Solution {
    // you need to treat n as an unsigned value
    public int hammingWeight(int n) {
      // Integer.bitCount(n)
      int sum = 0;
      int in = n;
      if (in >= 0) {
        while (in != 0) {
          sum += in - ((in >> 1) << 1);
          in /= 2;
        }
      } else {
        sum = 32;
        while (in != -1) {
          if (in == ((in >> 1) << 1)) {
            sum -= 1;
          }
          in = in >> 1;
        }
      }
      return sum;
    }
}
