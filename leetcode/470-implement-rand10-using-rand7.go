func rand10() int {
    for {
        row := rand7()
        col := rand7()
        idx := (row-1)*7 + col
        if idx <= 40 {
            return 1 + (idx-1)%10
            // equal to 4/49
        }
    }
}