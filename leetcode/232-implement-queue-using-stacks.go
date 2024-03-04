type MyQueue struct {
    s, sback []int
}


func Constructor() MyQueue {
    return MyQueue{}
}


func (this *MyQueue) Push(x int)  {
    this.s = append(this.s, x)
}


func (this *MyQueue) Pop() int {
    if len(this.sback) == 0 {
        for len(this.s) > 0 {
            this.sback = append(this.sback, this.s[len(this.s)-1])
            this.s = this.s[:len(this.s)-1]
        }
    }
    x := this.sback[len(this.sback)-1]
    this.sback = this.sback[:len(this.sback)-1]
    return x
}


func (this *MyQueue) Peek() int {
    if len(this.sback) == 0 {
        for len(this.s) > 0 {
            this.sback = append(this.sback, this.s[len(this.s)-1])
            this.s = this.s[:len(this.s)-1]
        }
    }
    return this.sback[len(this.sback)-1]
}


func (this *MyQueue) Empty() bool {
    return len(this.s) == 0 && len(this.sback) == 0
}


/**
 * Your MyQueue object will be instantiated and called as such:
 * obj := Constructor();
 * obj.Push(x);
 * param_2 := obj.Pop();
 * param_3 := obj.Peek();
 * param_4 := obj.Empty();
 */