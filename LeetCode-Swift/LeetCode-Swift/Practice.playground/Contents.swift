//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"


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
            if result > (Int(Int32.max) - num % 10) / 10 {
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
//    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
//
//    }
}

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
        
        print(head!.next!)
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

var arr = [46,23,45,2,78,32,46,24,11,99,66,88,199,100,156,27,175]

createList()
for i in 0  ..< arr.count 
{
//    addNode(ListNode(arr[i],nil))
    addNode(ListNode.init(arr[i], nil))
}
outPut()


//Solution().plusOne([1,9,9])
Solution().plusOne([2,4,9,3,9])

Solution().longestCommonPrefix2(["flower", "flow", "floght"])
//Solution().longestCommonPrefix(["b", "bcb"])
//Solution().longestCommonPrefix(["ab", "abcc"])
//Solution().longestCommonPrefix(["a"])
//Solution().longestCommonPrefix(["aa","ab"])
//Solution().longestCommonPrefix(["aaba","aa"])

Solution().addBinary("1101", "1001")

Solution().isValid("[])")
//Solution().isValid("()[]{}")
//Solution().isValid("([])")
//Solution().isValid("([)]")





