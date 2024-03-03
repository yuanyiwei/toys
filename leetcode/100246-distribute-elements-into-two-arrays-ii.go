func resultArray(nums []int) []int {
    n := len(nums)
    arr1, arr2 := make([]int, 0, n/2+1), make([]int, 0, n/2+1)
    sortedarr1, sortedarr2 := make([]int, 0, n/2+1), make([]int, 0, n/2+1)

    arr1 = append(arr1, nums[0])
    sortedarr1 = append(sortedarr1, nums[0])
    arr2 = append(arr2, nums[1])
    sortedarr2 = append(sortedarr2, nums[1])
    for _, numsiter := range nums[2:] {
        idx1 := sort.SearchInts(sortedarr1, numsiter)
        for idx1 < len(sortedarr1) && sortedarr1[idx1] == numsiter {
            idx1 += 1
        }
        idx2 := sort.SearchInts(sortedarr2, numsiter)
        for idx2 < len(sortedarr2) && sortedarr2[idx2] == numsiter {
            idx2 += 1
        }
        count1, count2 := len(arr1)-idx1, len(arr2)-idx2

        // count1, count2 := 0, 0
        // for _, arr1iter := range arr1 {
        //     if arr1iter > numsiter {
        //         count1 += 1
        //     }
        // }
        // for _, arr2iter := range arr2 {
        //     if arr2iter > numsiter {
        //         count2 += 1
        //     }
        // }
        if count1 > count2 || (count1 == count2 && len(arr1) <= len(arr2)) {
            arr1 = append(arr1, numsiter)
            // sortedarr1 = append(sortedarr1[:idx1], append([]int{numsiter}, sortedarr1[idx1:]...)...)
            if idx1 == len(sortedarr1) {
                sortedarr1 = append(sortedarr1, numsiter)
            } else {
                sortedarr1 = append(sortedarr1, 0)
                copy(sortedarr1[idx1+1:], sortedarr1[idx1:])
                sortedarr1[idx1] = numsiter
            }
        } else {
            arr2 = append(arr2, numsiter)
            // sortedarr2 = append(sortedarr2[:idx2], append([]int{numsiter}, sortedarr2[idx2:]...)...)
            if idx2 == len(sortedarr2) {
                sortedarr2 = append(sortedarr2, numsiter)
            } else {
                sortedarr2 = append(sortedarr2, 0)
                copy(sortedarr2[idx2+1:], sortedarr2[idx2:])
                sortedarr2[idx2] = numsiter
            }
        }
    }
    return append(arr1, arr2...)
}

// slice to slow
