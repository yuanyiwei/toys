func sortArray(nums []int) []int {
    max := -99999
    min := 99999
    // l := len(nums)
    for _, v := range nums {
        if v > max {
            max = v
        }
        if v < min {
            min = v
        }
    }
    span := max - min + 1
    count := make([]int, span)
    for _, v := range nums {
        count[v-min]++
    }

    var ret []int
    for k, v := range count {
        for v != 0 {
            ret = append(ret, k+min)
            v--
        }
    }
    return ret
	// qsort 居然直接超时..
}