//
//  main.swift
//  LeetCode-Swift
//
//  Created by GiantAxe on 18/4/13.
//  Copyright © 2018年 GiantAxe. All rights reserved.
//

import Foundation

//print("Hello, World!")

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

/* =========================================================== */
//                         All For Test
/* =========================================================== */

class NewSolution21 {
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        var res1 = ""
        let tmp1 = preOrder(rootNode: p, &res1)
        print("tmp1=\(tmp1)")
        var res2 = ""
        let tmp2 = preOrder(rootNode: q, &res2)
        print("tmp2=\(tmp2)")
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
        res.append("nil")
        return ""
    }
}
//let pSon = TreeNode.init(2)
//let p = TreeNode.init(1, pSon, nil)
//let qSon = TreeNode.init(2)
//let q = TreeNode.init(1, nil, qSon)
//let res = NewSolution21().isSameTree(p, q)
//print(res)

class NewSolution22 {
    func isSymmetric(_ root: TreeNode?) -> Bool {
        midOrder(rootNode: root)
        
        return false
    }
    func midOrder(rootNode: TreeNode?) -> Void {
        if rootNode != nil {
            if let val = rootNode?.val {
                midOrder(rootNode: rootNode?.left)
                if rootNode?.left == nil && rootNode?.right != nil {
                    print("nil")
                }
                print("\(val)")
                midOrder(rootNode: rootNode?.right)
                if rootNode?.right == nil && rootNode?.left != nil {
                    print("nil")
                }
            }
        }
    }
}
let pSonLeft = TreeNode.init(3)
//let pSonRight = TreeNode.init(4)
let pSon = TreeNode.init(2, pSonLeft, nil)
let pSon1Left = TreeNode.init(4)
let pSon1Right = TreeNode.init(3)
let pSon1 = TreeNode.init(2, pSon1Left, pSon1Right)
let p = TreeNode.init(1, pSon, pSon1)
NewSolution22().isSymmetric(p)


