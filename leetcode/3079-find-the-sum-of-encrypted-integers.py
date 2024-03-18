class Solution:
    def sumOfEncryptedInt(self, nums: List[int]) -> int:
        sum = 0
        for num in nums:
            num_origin = num
            max_digit = 0
            while num > 0:
                max_digit = max(max_digit, num % 10)
                num = num // 10
            length = len(str(num_origin))
            sum += int(str(max_digit) * length)
        return(sum)
