type MyStack struct {
    q, qback []int
}


func Constructor() MyStack {
    return MyStack{}
}


func (this *MyStack) Push(x int)  {
    this.qback = append(this.qback, x)
    for len(this.q) > 0 {
        this.qback = append(this.qback, this.q[0])
        this.q = this.q[1:]
    }
    this.q, this.qback = this.qback, this.q
}


func (this *MyStack) Pop() int {
    h := this.q[0]
    this.q = this.q[1:]
    return h
}


func (this *MyStack) Top() int {
    return this.q[0]
}


func (this *MyStack) Empty() bool {
    return len(this.q) == 0
}


/**
 * Your MyStack object will be instantiated and called as such:
 * obj := Constructor();
 * obj.Push(x);
 * param_2 := obj.Pop();
 * param_3 := obj.Top();
 * param_4 := obj.Empty();
 */