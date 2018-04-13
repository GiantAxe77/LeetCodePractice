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
    
}