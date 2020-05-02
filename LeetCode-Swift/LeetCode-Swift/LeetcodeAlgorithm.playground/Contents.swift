//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

//// Definition for singly-linked list.
//public class ListNode {
//    public var val: Int
//    public var next: ListNode?
//    public init(_ val: Int, _ next: ListNode?) {
//        self.val = val
//        self.next = next
//    }
//}
/**
 * Definition for singly-linked list.
 */
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

/**
 * Definition for a binary tree node.
 */
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}


class Solution {
    
    // leetcode 7
    func reverse(_ x: Int) -> Int {
        var isBelowZero = 1
        var result = 0
        var num = x
        if x < 0 {
            isBelowZero = -1
            num = -x
        }
        
        while num > 0 {
            if result > (Int(Int32.max) - num % 10) / 10 { // 2147483647 - 7 = 2147483640 214748364
                return 0
            }
            result = result * 10 + num % 10
            num = num / 10
        }
        
        return result * isBelowZero
    }
    
    // leetcode 9-1
    func isPalindrome(_ x: Int) -> Bool {
        if x < 0 {
            return false
        }
        let x1 = reverse(x)
        if x1 == x {
            return true
        }
        return false
    }
    
    // leetcode 9-2
    func isPalindrome2(_ x: Int) -> Bool {
        guard x >= 0 else {
            return false
        }
        
        var divider = 1
        while divider * 10 <= x { // 找出最大的除数,和x位数相同
            divider *= 10
        }
        
        var target = x
        while divider >= 10 {
            if target / divider != target % 10 { // 比较最高位和最低位是否相同
                return false
            }
            
            target = (target % divider) / 10 // 去掉最高位和最低位剩下的数
            divider = divider / 100 // 除数减少两个0(最高位和最低位)
        }
        
        return true
    }
    
    
    // leetcode 13
    func romanToInt(_ s: String) -> Int {
        let dict = ["I":1,
                    "V":5,
                    "X":10,
                    "L":50,
                    "C":100,
                    "D":500,
                    "M":1000]
        var result = 0
        let chars = [Character](s.characters)
        
        // 正向遍历字符串，比较第一位和下一位，小于则减去第一位,反之相反
        for i in 0..<chars.count {
            print(chars[i])
            let tmp = (dict[String(chars[i])])
            if i == chars.count-1 { // 最后一位加上即可
                return result + tmp!
            }
            let afterTmp = (dict[String(chars[i+1])])
            if afterTmp! > tmp! {
                result -= tmp!
            } else {
                result += tmp!
            }
        }
        return result
    }
    
    
    // leetcode 66
    func plusOne(_ digits: [Int]) -> [Int] {
        var result = [Int]()
        var tmp = digits
        var count = tmp.count
        var flag = false // 是否需要进位
        var plusFlag = false // 是否加过1
        var flagCount = 0
        
        while count > 0 {
            var lastDigit = tmp.last // 最后一位
            if flag {
                lastDigit! += 1
                plusFlag = true
                flagCount += 1
            }
            if lastDigit! + 1 > 9 {
                let value = plusFlag ? (lastDigit! == 10 ? 0 : lastDigit!) : 0
                result.insert(value, at: 0)
                flag = value == 0
            } else {
                result.insert(plusFlag ? lastDigit! : lastDigit!+1, at: 0)
                plusFlag = true
                flag = false
            }
            tmp.removeLast()
            
            count -= 1
        }
        let firstDig = digits.first
        if flagCount == digits.count-1 && firstDig == 9 {
            result.insert(1, at: 0)
        }
        return result
    }
    
    
    // leetcode 14-1
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard strs.count > 0 else {
            return ""
        }
        for tmp in strs { // 数组中有一个为空,则返回""
            if tmp.isEmpty {
                return ""
            }
        }
        var reslut = ""
        var tmpArr = strs
        let firstWord = strs.first! // 拿出第一个元素
        var index = 1
        var currentLetter = firstWord.substring(to: firstWord.index(firstWord.startIndex, offsetBy: index))
        tmpArr.remove(at: 0) // 遍历剩下的元素
        let count = tmpArr.count
        if count == 0 && !firstWord.isEmpty {
            return firstWord
        }
        
        var eqFlag = false
        repeat {
            var tmpStr = ""
            for i in 0..<count {
                tmpStr = tmpArr[i]
                if tmpStr.hasPrefix(currentLetter) {
                    eqFlag = true
                    continue
                } else {
                    eqFlag = false
                    break
                }
            }
            if eqFlag { // 如果2个字符相等
                index += 1
                if index > tmpStr.characters.count { // 处理临界情况
                    eqFlag = false
                    if index > firstWord.characters.count {
                        return currentLetter
                    }
                    let content = firstWord.substring(to: firstWord.index(firstWord.startIndex, offsetBy: index))
                    return tmpStr.characters.count == 1 ? tmpStr : content.characters.count > tmpStr.characters.count ? tmpStr : content
                }
                currentLetter = firstWord.characters.count == 1 ? firstWord : (index > firstWord.characters.count) ? firstWord : firstWord.substring(to: firstWord.index(firstWord.startIndex, offsetBy: index))
                reslut = currentLetter
            } else {
                reslut = currentLetter.substring(to: currentLetter.index(currentLetter.startIndex, offsetBy: currentLetter.characters.count-1))
            }
            
        } while (eqFlag == true && currentLetter != "")
        return reslut
    }
    
    // leetcode 14-2
    func longestCommonPrefix2(_ strs: [String]) -> String {
        guard strs.count > 0 else {
            return ""
        }
        
        var res = [Character](strs[0].characters)
        
        for str in strs {
            var strContent = [Character](str.characters)
            print(strContent)
            
            if res.count > strContent.count {
                res = Array(res[0..<strContent.count])
            }
            
            for i in 0..<res.count {
                if res[i] != strContent[i] {
                    res = Array(res[0..<i])
                    break
                }
            }
        }
        
        return String(res)
    }
    
    // leetcode 67
    func addBinary(_ a: String, _ b: String) -> String {
        
        var sum = 0, carry = 0, result = ""
        var aArr = Array(a.characters), bArr = Array(b.characters)
        var i = aArr.count - 1, j = bArr.count - 1
        
        while carry > 0 || i >= 0 || j >= 0 { // 有进位或者还没读取完字符串
            sum = carry
            if i >= 0 { // 避免数组越界,取出最右边一位相加
                sum += Int(String(aArr[i]))!
                i -= 1
            }
            if j >= 0 { // 避免数组越界,取出最右边一位相加
                sum += Int(String(bArr[j]))!
                j -= 1
            }
            carry = sum / 2 // 计算是否有进位
            sum = sum % 2   // 计算当前位是多少（sum = 0/1/2）求余后sum = 0/1
            result = String(sum) + result
        }
        
        return result
    }
    
    // leetcode 20
    func isValid(_ s: String) -> Bool {
        
        // 用栈的思想，先进后出，比较栈内的括号是否和当前括号匹配
        var chars = Array(s.characters)
        let count = chars.count
        var stack = [Character]()
        for i in 0..<count {
            let current = chars[i]
            if current == "(" || current == "[" || current == "{" {
                stack.append(current) // 压栈
            } else if current == ")" {
                if stack.last == "(" && stack.count != 0 {
                    stack.removeLast()
                } else {
                    return false
                }
            } else if current == "]" {
                if stack.last == "[" && stack.count != 0 {
                    stack.removeLast()
                } else {
                    return false
                }
            } else if current == "}" {
                if stack.last == "{" && stack.count != 0 {
                    stack.removeLast()
                } else {
                    return false
                }
            }
        }
        return stack.isEmpty
    }
    
    // leetcode 21
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        // 递归查找：函数输出可以作为输入，进而更新输入，直到两个链表都为空。
        if l1 == nil {
            return l2
        }
        if l2 == nil {
            return l1
        }
        if l1!.val < l2!.val {
            l1?.next = mergeTwoLists(l1?.next, l2)
            return l1
        } else {
            l2?.next = mergeTwoLists(l2?.next, l1)
            return l2
        }
    }
    
    // leetcode 69
    func mySqrt(_ x: Int) -> Int {
        if x <= 0 {
            return x
        }
        
        var left = 0
        var right = x / 2 + 1
        var mid = 0
        
        while left <= right {
            mid = (right - left) / 2 + left
            if mid * mid == x {
                return mid
            } else if mid * mid < x {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return right
    }
    
    // leetcode 69-2（牛顿迭代法）
    func mySqrt2(_ x: Double) -> Double {
        var k = x
        while k * k - x > pow(1, -9) {
            k = 0.5 * (k + x / k)
        }
        return k
    }
    
    // leetcode 26
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        if nums.count <= 1 {
            return nums.count
        }
        var lastIndex = 0
        for num in nums {
            if num != nums[lastIndex] {
                nums[lastIndex+1] = num
                lastIndex += 1
            }
        }
        
        return lastIndex + 1
    }
}

Solution().reverse(123)

//var head: ListNode?
//func createList() {
//    if head == nil {
//        head = ListNode(0, nil)
//    }
//}
//
//func addNode(_ node: ListNode) -> Bool {
//    if head == nil {
//        return false
//    } else {
//        var p = head?.next
//        var q: ListNode! = head
//        while (p != nil) {
//            q = p
//            p = p!.next
//        }
//        q.next = node
//        return true
//    }
//}
//
//var arr = [1,2,4]
//createList()
//for i in 0  ..< arr.count {
//    addNode(ListNode.init(arr[i], nil))
//}
//
//var head2: ListNode?
//func createList2() {
//    if head2 == nil {
//        head2 = ListNode(0, nil)
//    }
//}
//createList2()
//var arr1 = [1,3,4]
//for i in 0  ..< arr1.count {
//    addNode(ListNode.init(arr1[i], nil))
//}
//
//let res = Solution().mergeTwoLists(head, head2)
//func outPut() -> Void {
//    var p = res?.next
//    while (p != nil) {
//        print(p!.val)
//        p = p?.next
//    }
//}
//outPut()

Solution().mySqrt2(9)

//Solution().plusOne([1,9,9])
Solution().plusOne([2,4,9,3,9])

Solution().longestCommonPrefix2(["flower", "flow", "floght"])
//Solution().longestCommonPrefix(["b", "bcb"])
//Solution().longestCommonPrefix(["ab", "abcc"])
//Solution().longestCommonPrefix(["a"])
//Solution().longestCommonPrefix(["aa","ab"])
//Solution().longestCommonPrefix(["aaba","aa"])

Solution().addBinary("1101", "1001")

//Solution().isValid("[])")
//Solution().isValid("()[]{}")
//Solution().isValid("([])")
//Solution().isValid("([)]")


var nums = [1, 1, 2, 2, 3]
//var nums = [1, 2, 2, 2, 3]
Solution().removeDuplicates(&nums)


// New Task

// leetcode1
class NewSolution1 {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int : Int]()
        for (i, num) in nums.enumerated() {
            if let lastIndex = dict[target-num] {
                return [lastIndex, i];
            }
            dict[num] = i
        }
        fatalError("error")
    }
    
}

NewSolution1().twoSum([3,2,4], 6)

class NewSolution2 {
    func reverse(_ x: Int) -> Int {
        var obj = 0
        var num = x
        let isMinus = x < 0 ? -1 : 1
        if isMinus == -1 {
            num = -num
        }
        var remainder = 0
        while num > 0 {
            if obj > INT32_MAX / 10 {
                return 0
            }
            remainder = num % 10 // 3 2 1
            obj = obj * 10 + remainder // 3 32 321
            num = num / 10 // 12 1 0
        }
        return obj * isMinus
    }
    
    func isPalindrome(_ x: Int) -> Bool {
        //        if x < 0 {
        //            return false
        //        }
        //        let revNum = reverse(x)
        //        if revNum == x {
        //            return true
        //        } else {
        //            return false
        //        }
        let string = String(x)
        let reverseStr = String(string.reversed())
        return string == reverseStr
    }
}

NewSolution2().reverse(120)
NewSolution2().isPalindrome(-1221)

class NewSolution3 {
    func romanToInt(_ s: String) -> Int {
        var map = [String : Int]()
        map = ["I":1,
               "V":5,
               "X":10,
               "L":50,
               "C":100,
               "D":500,
               "M":1000
        ]
        var res = 0
        for i in 0..<s.count {
            let currentIndex = s.index(s.startIndex, offsetBy: i)
            let current:Character = s[currentIndex]
            let currentNum = map[current.description]!
            if i == s.count-1 {
                res += currentNum
            } else {
                let after:Character = s[s.index(after: currentIndex)]
                if currentNum >= map[after.description]! {
                    res += currentNum
                } else {
                    res -= currentNum
                }
            }
        }
        return res
    }
}

NewSolution3().romanToInt("IIV")

class SolutionTest {
    enum Roman: Int {
        case I = 1
        case V = 5
        case X = 10
        case L = 50
        case C = 100
        case D = 500
        case M = 1000
        case NotHandled = -1
        
        init(char: String.Element) {
            switch char {
            case "I":
                self = .I
            case "V":
                self = .V
            case "X":
                self = .X
            case "L":
                self = .L
            case "C":
                self = .C
            case "D":
                self = .D
            case "M":
                self = .M
            default:
                self = .NotHandled
            }
        }
    }
    
    func romanToInt(_ s: String) -> Int {
        var previousChar: Roman?
        var result = 0
        for char in s {
            let roman = Roman(char: char)
            print(roman)
            if let previous = previousChar, previous.rawValue < roman.rawValue {
                if result < roman.rawValue {
                    result = roman.rawValue - previous.rawValue
                } else {
                    result = (result - previous.rawValue) + (roman.rawValue - previous.rawValue)
                }
                previousChar = nil
            } else {
                result = result + roman.rawValue
                previousChar = roman
            }
        }
        
        return result
    }
    
}
SolutionTest().romanToInt("MCM")

class NewSolution4 {
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard strs.count != 0 else {
            return ""
        }
        guard strs.count > 1 else {
            return strs.first!
        }
        var res = ""
        var firstStr = [Character]()
        var otherStrArr = [[Character]]()
        for i in 0..<strs.count {
            let tempStr = strs[i]
            let tempArr = Array(tempStr)
            if i == 0 {
                firstStr = tempArr
            } else {
                otherStrArr.append(tempArr)
            }
        }
        for i in 0..<firstStr.count { // ["a", "c", "a"]
            let letter = firstStr[i] // a c
            for j in 0..<otherStrArr.count {
                let charArr = otherStrArr[j] // ["c", "b", "a"]
                if i > charArr.count-1 {
                    return res
                }
                let objChar = charArr[i] // c
                if objChar == letter {
                    if j == otherStrArr.count-1 {
                        res = String(firstStr[0...i]) //
                    }
                    continue
                } else {
                    if i == 0 { // 比较首位就不一样的时候，直接返回
                        return ""
                    }
                    break
                }
            }
        }
        return res
    }
    
    func longestCommonPrefixNotMe(_ strs: [String]) -> String {
        
        if strs.isEmpty { return "" }
        if strs.count == 1 { return strs.first! }
        
        let sortedString = strs.sorted()
        
        let firstWord = sortedString.first!
        let secondWord = sortedString.last!
        
        var prefix = ""
        
        for char in firstWord {
            if secondWord.hasPrefix("\(prefix)\(char)") {
                prefix.append(char)
            } else {
                return prefix
            }
        }
        
        return prefix
    }
}

//NewSolution4().longestCommonPrefix(["aca","cba"])
//NewSolution4().longestCommonPrefixNotMe(["flow", "flower", "fly"])

class NewSolution5 { // 笨方法太耗时了不能行
    func search(_ array: [Character]) -> Bool {
        
        var arr = array
        var needDeleteArr = [Int]()
        for i in 0..<arr.count {
            let currentChar = arr[i]
            if i == 0 && (currentChar == "}" || currentChar == "]" || currentChar == ")") {
                return false
            } else if arr.count == 1 {
                return false
            }
            if i != arr.count-1 {
                let nextChar = arr[i+1]
                if currentChar == "{" && nextChar == "}" ||
                    currentChar == "[" && nextChar == "]" ||
                    currentChar == "(" && nextChar == ")" {
                    needDeleteArr.append(i)
                    needDeleteArr.append(i+1)
                    break
                } else if arr.count == 2 {
                    return false
                }
            } else {
                return false
            }
        }
        //        print("before:\(arr)")
        //        print("needDeleteArr:\(needDeleteArr)")
        //        arr = arr.filter{!needDeleteArr.contains($0)}
        for i in 0..<needDeleteArr.count {
            if i == 0 {
                arr.remove(at: needDeleteArr[i])
            } else {
                arr.remove(at: needDeleteArr[i-1])
            }
        }
        //        print("after:\(arr)")
        if arr.count == 0 {
            return true
        }
        return search(arr)
    }
    func isValid(_ s: String) -> Bool {
        guard !s.isEmpty else {
            return true
        }
        guard s.count != 1 else {
            return false
        }
        let arr = Array(s)
        let res = search(arr)
        return res
    }
}

//NewSolution5().isValid("[]()")
//NewSolution5().isValid("[{}()]")
//NewSolution5().isValid("[()]")
//NewSolution5().isValid("[[[]]")
//NewSolution5().isValid("[)")
//NewSolution5().isValid("[([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([([()])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])]")

class NewSolution6 {
    func isValid(_ s: String) -> Bool {
        guard !s.isEmpty else {
            return true
        }
        guard s.count != 1 else {
            return false
        }
        let chars = Array(s)
        var array = [Character]()
        for i in 0..<chars.count {
            let char = chars[i]
            if char == "(" || char == "[" || char == "{" {
                array.append(char)
            } else {
                if i == 0 { return false }
                switch char {
                case "}":
                    if array.isEmpty {
                        return false
                    } else {
                        if array.last! == "{" {
                            array.popLast()
                        } else {
                            return false
                        }
                    }
                case "]":
                    if array.isEmpty {
                        return false
                    } else {
                        if array.last! == "[" {
                            array.popLast()
                        } else {
                            return false
                        }
                    }
                default:
                    if array.isEmpty {
                        return false
                    } else {
                        if array.last! == "(" {
                            array.popLast()
                        } else {
                            return false
                        }
                    }
                }
            }
            
        }
        return array.isEmpty
    }
}
//NewSolution6().isValid("[]{")
//NewSolution6().isValid("{}][}}{[))){}{}){(}]))})[({")


public class LinkedList {
    fileprivate var head: ListNode?
    private var tail: ListNode?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: ListNode? {
        return head
    }
    
    public var last: ListNode? {
        return tail
    }
    
    public func append(value: Int) {
        let newNode = ListNode.init(value)
        if let tailNode = tail { // 单链表
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
        
    }
    
    public func nodeAt(index: Int) -> ListNode? {
        if index >= 0 {
            var node = head
            var i = index
            while node != nil {
                if i == 0 {
                    return node
                }
                i -= 1
                node = node!.next
            }
        }
        return nil
    }
    
    public func removeAll() {
        head = nil
        tail = nil
    }
    
    //    public func remove(node: ListNode) -> Int {
    //        let next = node.next
    //
    //    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var text = "["
        var node = head
        while node != nil {
            text += "\(node!.val)"
            node = node!.next
            if node != nil {
                text += ","
            }
        }
        return text + "]"
    }
}

let l1 = LinkedList()
l1.append(value: 1)
l1.append(value: 2)
l1.append(value: 4)
//print(l1)

let l2 = LinkedList()
l2.append(value: 1)
l2.append(value: 3)
l2.append(value: 4)
//print(l2)

//Input: 1->2->4, 1->3->4
//Output: 1->1->2->3->4->4
class NewSolution7 {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil {
            return l2
        }
        if l2 == nil {
            return l1
        }
        if l1!.val < l2!.val {
            l1?.next = mergeTwoLists(l1?.next, l2)
            return l1
        } else {
            l2?.next = mergeTwoLists(l1, l2?.next)
            return l2
        }
    }
    
}
let list1 = ListNode.init(1)
let list2 = ListNode.init(2)
let res = NewSolution7().mergeTwoLists(list1, list2)

class NewSolution8 {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        //        guard nums.count != 0 else {
        //            return 0
        //        }
        //        var index = 0
        //        for num in nums {
        //            if num != nums[index] {
        //                index += 1 // 1 2 3 4
        //                nums[index] = num
        //            }
        //        }
        //        for num in nums {
        //            print(num)
        //        }
        //
        //        return index+1
        
        
        // 循环记录
        // 0,0,1,1,1,2,2,3,3,4
        // 0,1,1,1,1,2,2,3,3,4
        // 0,1,2,1,1,2,2,3,3,4
        // 0,1,2,3,4,2,2,3,3,4
        
        //        // 解法二：确实屌（利用了Set）
        //        let removed = Set(nums)
        //        nums = Array(removed).sorted()
        //        return nums.count
        
        // 解法三
        for (index, element) in nums.enumerated().reversed() {
            if index > 0 {
                if nums[index] == nums[index-1] {
                    // print(nums[index])
                    nums.remove(at: index)
                }
            } else {
                break
            }
        }
        return nums.count
    }
}

//var dupNums = [0,0,1,1,1,2,2,3,3,4]
//NewSolution8().removeDuplicates(&dupNums)

class NewSolution9 {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        //        guard nums.count > 0 else {
        //            return 0
        //        }
        //        for num in nums {
        //            if let index = nums.index(of: num) {
        //                if num == val {
        //                    nums.remove(at: index)
        //                }
        //            }
        //        }
        //        return nums.count
        var index = 0
        var revNums = Array(nums.reversed())
        for num in revNums {
            //            print(nums)
            if num == val {
                revNums.remove(at: index)
                continue
            }
            index += 1
        }
        print(revNums)
        return revNums.count
    }
}

//var eleArray = [0,1,2,2,3,0,4,2]
//NewSolution9().removeElement(&eleArray, 2)

extension String {
    func findFirst(_ sub:String)->Int {
        var pos = -1
        if let range = range(of:sub, options: .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
}

class NewSolution10 {
    
    func strStr(_ haystack: String, _ needle: String) -> Int {
        guard !needle.isEmpty else {
            return 0
        }
        guard haystack.count != needle.count else {
            return haystack != needle ? -1 : 0
        }
        if let range = haystack.range(of: needle) {
            return haystack.distance(from: haystack.startIndex, to: range.lowerBound)
        } else {
            return -1
        }
        
        //        let res = haystack.findFirst(needle)
        //        return res
    }
    
}
//NewSolution10().strStr("hello", "ll")

class NewSolution11 {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        for i in 0..<nums.count {
            if nums[i] == target {
                return i
            } else if nums[i] > target {
                return i < 0 ? 0 : i
            } else if nums[i] < target && i == nums.count-1 {
                return i+1
            }
        }
        return -1
    }
}
//NewSolution11().searchInsert([1,3,5,6], 0)

//1.     1
//2.     11
//3.     21
//4.     1211
//5.     111221
//6.     312211
//7.     13112221
class NewSolution12 {
    func countAndSay(_ n: Int) -> String {
        guard n != 1 else {
            return "1"
        }
        
        var index = 1
        var res = "1"
        while index < n { // index = 1
            //            print("index=\(index)")
            var cur = ""
            let array = Array(res) // ["1"] ["1","1"]
            for var i in 0..<array.count { // i = 0 1
                var count = 1
                while i+1 < array.count && array[i] == array[i+1] {
                    count += 1
                    i += 1
                }
                cur += "\(count)\(array[i])" // "21"
                //                print("cur=\(cur)")
            }
            index += 1
            res = cur
            //            print("res=\(res)")
        }
        
        //        var index = 1
        //        var res = "1"
        //        while index < n {
        //            var cur = ""
        //            let array = Array(res)
        //            var count = 1
        //            for i in 0..<array.count {
        //                if i+1 < array.count && array[i] == array[i+1] {
        //                    count += 1
        //                } else {
        //                    cur += "\(count)\(array[i])"
        //                    count = 1
        //                }
        //            }
        //            index += 1
        //            res = cur
        //        }
        return res
    }
}
//5.     111221
//6.     312211
NewSolution12().countAndSay(3)

class NewSolution13 {
    func maxSubArray(_ nums: [Int]) -> Int {
        var res = nums[0] // -2 1 4 5 6
        var sum = nums[0] // -2 1 -2 4 3 5 6 1 5
        for i in 1..<nums.count {
            sum = max(sum+nums[i], nums[i])
            if sum > res {
                res = sum
            }
        }
        
        return res
    }
    
}
NewSolution13().maxSubArray([-2,1,-3,4,-1,2,1,-5,4])

class NewSolution14 {
    func lengthOfLastWord(_ s: String) -> Int {
        guard !s.isEmpty else {
            return 0
        }
        let array = Array(s)
        let res = array.split(separator: " ")
        if res.last != nil {
            return (res.last?.count)!
        } else {
            return 0
        }
    }
}
NewSolution14().lengthOfLastWord("")

class NewSolution15 {
    func plusOne(_ digits: [Int]) -> [Int] {
        let newArr = digits.filter { (num) -> Bool in
            return num == 9
        }
        if digits.count == newArr.count {
            var res = [Int](repeatElement(0, count: digits.count+1))
            res[0] = 1
            return res
        }
        var needPlus = false, alreadyPlus = false
        var res = Array(digits.reversed())
        for i in 0..<res.count {
            if alreadyPlus == false && res[i] == 9 && i != res.count-1 {
                res[i] = 0
                needPlus = true
            } else if needPlus == true {
                needPlus = false
                if res[i]+1 > 9 {
                    needPlus = true
                }
                res[i] = res[i]+1 > 9 ? 0 : res[i]+1
                alreadyPlus = true
            } else {
                if i == 0 {
                    res[i] = res[i]+1
                    alreadyPlus = true
                }
            }
        }
        return Array(res.reversed())
    }
    
    // 网上大神算法
    func plusOne1(_ digits: [Int]) -> [Int] {
        var mutable = digits
        for i in stride(from: mutable.count - 1, to: -1, by: -1) {
            if mutable[i] != 9 {
                mutable[i] += 1
                return mutable
            } else {
                mutable[i] = 0
            }
        }
        mutable.insert(1, at: 0)
        return mutable
    }
}
// [0,1]
// [0,1,9]
// [1,9,9]
//NewSolution15().plusOne1([9,8,9])

class NewSolution16 {
    func addBinary(_ a: String, _ b: String) -> String {
        var arrA = Array(a)
        var arrB = Array(b)
        if arrA.count > arrB.count { // 高位补0使位数相等
            for i in 0..<arrA.count-arrB.count {
                arrB.insert("0", at: 0)
            }
        } else if arrA.count < arrB.count {
            for i in 0..<arrB.count-arrA.count {
                arrA.insert("0", at: 0)
            }
        }
        //        print("arrA=\(arrA),arrB=\(arrB)")
        var res = [Character]()
        var needPlus = false
        for i in stride(from: arrA.count-1, through: 0, by: -1) {
            //            print("i=\(i),needPlus=\(needPlus)")
            if arrA[i] == "1" && arrB[i] == "1" {
                if needPlus == false {
                    res.insert("0", at: 0)
                } else {
                    res.insert("1", at: 0)
                }
                needPlus = true
            } else if arrA[i] == "0" && arrB[i] == "0" {
                if needPlus == false {
                    res.insert("0", at: 0)
                } else {
                    res.insert("1", at: 0)
                }
                needPlus = false
            } else {
                if needPlus == false {
                    res.insert("1", at: 0)
                    needPlus = false
                } else {
                    res.insert("0", at: 0)
                    needPlus = true
                }
            }
        }
        if needPlus == true {
            res.insert("1", at: 0)
        }
        
        return String(res)
    }
}
//NewSolution16().addBinary("1011", "1010")

class NewSolution17 {
    func mySqrt(_ x: Int) -> Int {
        var lower = 1
        var upper = x
        var mid = 1
        while lower < upper {
            mid = lower + (upper-lower)/2
            print("mid=\(mid), lower=\(lower), upper=\(upper)")
            if mid * mid == x {
                return mid
            } else if mid * mid < x {
                lower = mid + 1
            } else {
                upper = mid
            }
        }
        if mid * mid > x {
            mid -= 1
        }
        return mid
    }
}
//NewSolution17().mySqrt(1)

class NewSolution18 {
    func climbStairs(_ n: Int) -> Int {
        guard n != 1 else {
            return 1
        }
        var dp = [Int](repeating: 0, count: n+1)
        dp[1] = 1
        dp[2] = 2
        for i in 3...n {
            dp[i] = dp[i-1] + dp[i-2]
        }
        return dp[n]
    }
}
//NewSolution18().climbStairs(6)

class NewSolution19 {
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        var cur = head
        while cur != nil && cur?.next != nil {
            if cur?.val == cur?.next?.val {
                cur?.next = cur?.next?.next
            } else {
                cur = cur?.next
            }
        }
        return head
    }
}
// 1-1-1
// 1-()-1
// 1-()-()

let sol19List = LinkedList()
sol19List.append(value: 1)
sol19List.append(value: 1)
sol19List.append(value: 1)
//print(sol19List)

//let res19 = NewSolution19().deleteDuplicates(sol19List.head)
//print(res19!.val)

class NewSolution20 {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var i = m-1
        var j = n-1
        while i >= 0 && j >= 0 {
            if nums2[j] > nums1[i] {
                nums1[i+j+1] = nums2[j]
                j-=1
                //                print("1==\(nums1)")
            } else {
                (nums1[i], nums1[i+j+1]) = (nums1[i+j+1], nums1[i])
                i-=1
                //                print("2==\(nums1)")
            }
        }
        if i < 0 && j >= 0 {
            nums1[0...j] = nums2[0...j]
        }
    }
}

//var nums1 = [0]
//var nums2 = [1]
//NewSolution20().merge(&nums1, 0, nums2, 1)

class NewSolution21 {
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        var res1 = ""
        let tmp1 = preOrder(rootNode: p, &res1)
//        print("tmp1=\(tmp1)")
        var res2 = ""
        let tmp2 = preOrder(rootNode: q, &res2)
//        print("tmp2=\(tmp2)")
        return tmp1 == tmp2
    }
    func preOrder(rootNode: TreeNode?, _ res: inout String) -> String {
        if rootNode != nil {
            if let val = rootNode?.val {
                res.append(String(val))
                preOrder(rootNode: rootNode?.left, &res)
                preOrder(rootNode: rootNode?.right, &res)
            }
            return res
        }
        return ""
    }
    
//    // 网上解法
//    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
//        if p == nil && q == nil {
//            return true
//        }
//        if p == nil || q == nil {
//            return false
//        }
//        return (p?.val == q?.val) && isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
//    }
}
//let pSonLeft = TreeNode.init(1)
//let pSonRight = TreeNode.init(2)
//let pSon = TreeNode.init(2, pSonLeft, pSonRight)
//let pRight = TreeNode.init(3)
//let p = TreeNode.init(1, pSon, pRight)
//
//let qSonLeft = TreeNode.init(1)
//let qSonRight = TreeNode.init(2)
//let qSon = TreeNode.init(2, qSonLeft, qSonRight)
//let qRight = TreeNode.init(3)
//let q = TreeNode.init(1, qSon, qRight)
//NewSolution21().isSameTree(p, q)

class NewSolution22 {
    /*
     // 一开始想到的方法是采用中序遍历，然后比较数组中元素是否对称最后得出结果，但是经过试验不行，比如像这种树：[5,4,1,null,1,null,4,2,null,2,null]
    func isSymmetric(_ root: TreeNode?) -> Bool {
        var res = [Int]()
        midOrder(rootNode: root, &res)
        print("midOrder = \(res)")
        if res.count == 0 {
            return true
        }
        var start = 0, end = res.count-1
        while start != end {
            if res[start] == res[end] {
                start+=1
                end-=1
            } else {
                return false
            }
        }
        return true
    }
    func midOrder(rootNode: TreeNode?, _ res: inout [Int]) -> Void {
        if rootNode != nil {
            if let val = rootNode?.val {
                midOrder(rootNode: rootNode?.left, &res)
                if rootNode?.left == nil && rootNode?.right != nil {
                    res.append(-1)
                }
                res.append(val)
                midOrder(rootNode: rootNode?.right, &res)
                if rootNode?.left != nil && rootNode?.right == nil {
                    res.append(-1)
                }
            }
        }
    }
 */
    func isSymmetric(_ root: TreeNode?) -> Bool {
        return isMirror(root, root)
    }
    func isMirror(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
        if root1 == nil && root2 == nil {
            return true
        }
        if root1 == nil || root2 == nil {
            return false
        }
        return root1?.val == root2?.val &&
            isMirror(root1?.left, root2?.right) &&
            isMirror(root1?.right, root2?.left)
    }
}
let pSonLeft = TreeNode.init(3)
let pSonRight = TreeNode.init(4)
let pSon = TreeNode.init(2, pSonLeft, nil)
let pSon1Left = TreeNode.init(4)
let pSon1Right = TreeNode.init(3)
let pSon1 = TreeNode.init(2, pSon1Left, pSon1Right)
let p = TreeNode.init(1, pSon, pSon1)

//let pSonLeft = TreeNode.init(2)
////let pSonRight = TreeNode.init(4)
//let pSon = TreeNode.init(2, pSonLeft, nil)
//let pSon1Left = TreeNode.init(2)
////let pSon1Right = TreeNode.init(3)
//let pSon1 = TreeNode.init(2, pSon1Left, nil)
//let p = TreeNode.init(1, pSon, pSon1)

NewSolution22().isSymmetric(p)
