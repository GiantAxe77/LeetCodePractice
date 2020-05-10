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
//let pSonLeft = TreeNode.init(3)
////let pSonRight = TreeNode.init(4)
//let pSon = TreeNode.init(2, pSonLeft, nil)
//let pSon1Left = TreeNode.init(4)
//let pSon1Right = TreeNode.init(3)
//let pSon1 = TreeNode.init(2, pSon1Left, pSon1Right)
//let p = TreeNode.init(1, pSon, pSon1)
//NewSolution22().isSymmetric(p)

class NewSolution27 {
    func minDepth(_ root: TreeNode?) -> Int {
        guard root != nil else {
            return 0
        }
        let leftCount = minDepth(root?.left)
        let rightCount = minDepth(root?.right)
        let res = min(leftCount, rightCount)
        return res + 1
    }
}
//let root = TreeNode.init(1)
//root.left = TreeNode.init(2)
//NewSolution27().minDepth(root)

//class NewSolution28 {
//    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
//        guard root != nil else {
//            return false
//        }
//        return helper(root, sum, Int.max)
//    }
//    private func helper(_ root: TreeNode?, _ sum: Int, _ count: Int) -> Bool {
//        var count = count
//        guard root != nil else {
//            return false
//        }
//        if root?.left == nil && root?.right == nil {
//            count+=(root?.val)!
//            if count == sum {
//                return true
//            } else {
//                return false
//            }
//        }
//        if count == Int.max {
//            count = 0
//            count+=(root?.val)!
//        }
//        if let left = root?.left {
//            count+=left.val
//            if count > sum {
//                count-=left.val
//                if let right = root?.right {
//                    return helper(right, sum, count)
//                } else {
//                    return false
//                }
//            } else if count == sum {
//                if left.left == nil && left.right == nil {
//                    return true
//                } else {
//                    return false
//                }
//            } else {
//                return helper(root?.left, sum, count) || helper(root?.right, sum, count)
//            }
//        } else {
//            count+=(root?.right?.val)!
//            if count > sum {
//                return false
//            } else {
//                if root?.right?.left == nil && root?.right?.right == nil && count == sum {
//                    return true
//                } else {
//                    return helper(root?.right, sum, count)
//                }
//            }
//
//        }
//    }
//}
////let root = TreeNode.init(5)
////root.left = TreeNode.init(4)
////root.right = TreeNode.init(8)
//root.left?.left = TreeNode.init(11)
//root.left?.left?.left = TreeNode.init(7)
//root.left?.left?.right = TreeNode.init(2)
//root.right?.left = TreeNode.init(13)
//root.right?.right = TreeNode.init(4)
//root.right?.right?.right = TreeNode.init(1)
//let res = NewSolution28().hasPathSum(root, 22)
//print(res)

//let root = TreeNode.init(1)
//root.left = TreeNode.init(2)
//let res = NewSolution28().hasPathSum(root, 3)
//print(res)

class NewSolution28 {
    // 这道题给了一棵二叉树，问是否存在一条从跟结点到叶结点到路径，使得经过到结点值之和为一个给定的 sum 值，这里需要用深度优先算法 DFS 的思想来遍历每一条完整的路径，也就是利用递归不停找子结点的左右子结点，而调用递归函数的参数只有当前结点和 sum 值。首先，如果输入的是一个空结点，则直接返回 false，如果如果输入的只有一个根结点，则比较当前根结点的值和参数 sum 值是否相同，若相同，返回 true，否则 false。 这个条件也是递归的终止条件。下面就要开始递归了，由于函数的返回值是 Ture/False，可以同时两个方向一起递归，中间用或 || 连接，只要有一个是 True，整个结果就是 True。递归左右结点时，这时候的 sum 值应该是原 sum 值减去当前结点的值，参见代码如下：
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        guard let root = root else {
            return false
        }
        if sum == root.val && root.left == nil && root.right == nil {
            return true
        }
        return hasPathSum(root.left, sum-root.val) || hasPathSum(root.right, sum-root.val)
    }
}

let root = TreeNode.init(1)
root.left = TreeNode.init(-2)
root.right = TreeNode.init(-3)
root.left?.left = TreeNode.init(1)
root.left?.right = TreeNode.init(3)
root.left?.left?.left = TreeNode.init(-1)
root.right?.left = TreeNode.init(-2)
let res = NewSolution28().hasPathSum(root, 2)
print(res)

