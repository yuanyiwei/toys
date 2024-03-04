func resultArray(nums []int) []int {
    n := len(nums)
    arr1, arr2 := make([]int, 0, n/2), make([]int, 0, n/2)
    arr1 = append(arr1, nums[0])
    arr2 = append(arr2, nums[1])
    for i := 2; i < n; i++ {
        if len(arr1) > 0 && len(arr2) > 0 {
            if arr1[len(arr1)-1] > arr2[len(arr2)-1] {
                arr1 = append(arr1, nums[i])
            } else {
                arr2 = append(arr2, nums[i])
            }
        } else if len(arr1) > 0 {
            arr1 = append(arr1, nums[i])
        } else {
            arr2 = append(arr2, nums[i])
        }
    }
    return append(arr1, arr2...)
}
