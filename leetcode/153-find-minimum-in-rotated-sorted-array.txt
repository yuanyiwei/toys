func findMin(nums []int) int {
    // min_num := nums[0]
    // for _, num := range nums {
    //     if num < min_num {
    //         return num
    //     }
    // }
    // return min_num

    if nums[len(nums) - 1] > nums[0] { return nums[0] }

    l, r := 0, len(nums) - 1
    for l < r {
        mid := (l + r) / 2
        if nums[r] > nums[mid] {
            r = mid
        } else {
            l = mid + 1
        }
    }
    return nums[l]
}