//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"


// Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int, _ next: ListNode?) {
        self.val = val
        self.next = next
    }
}

var head: ListNode?
func createList() {
    if head == nil {
        head = ListNode(0, nil)
    }
}

func addNode(_ node: ListNode) -> Bool {
    if head == nil {
        return false
    } else {
        var p = head?.next
        var q: ListNode! = head
        while (p != nil) {
            q = p
            p = p!.next
        }
        q.next = node
        
        //        print(head!.next!)
        //        print(q.next!)
        return true
    }
}

func outPut() -> Void {
    var p = head?.next
    while (p != nil) {
        print(p!.val)
        p = p?.next
    }
}

func getCount() -> Int {
    var length = 0
    var p = head?.next
    while p != nil {
        length += 1
        p = p!.next
    }
    return length
}

func deleteNode(index: Int) -> Bool {
    if head == nil || index > getCount() {
        return false
    } else {
        var p = head?.next
        var q:ListNode!
        for _ in 0 ..< index {
            q = p
            p = p!.next
        }
        q.next = p
        return true
    }
}

var arr = [46,23,45,2,78,32,46,24,11,99]

createList()
for i in 0  ..< arr.count
{
    //    addNode(ListNode(arr[i],nil))
    addNode(ListNode.init(arr[i], nil))
}
//outPut()
let count = getCount()
deleteNode(index: 3)
outPut()









