//
//  FourNumbersPlusTest.m
//  ArithmeticDemo
//
//  Created by 陈刚 on 2020/11/27.
//  Copyright © 2020 chengang. All rights reserved.
//

#import "FourNumbersPlusTest.h"

@implementation FourNumbersPlusTest
/**
 给定四个包含整数的数组列表 A , B , C , D ,计算有多少个元组 (i, j, k, l) ，使得 A[i] + B[j] + C[k] + D[l] = 0。

 为了使问题简单化，所有的 A, B, C, D 具有相同的长度 N，且 0 ≤ N ≤ 500 。所有整数的范围在 -228 到 228 - 1 之间，最终结果不会超过 231 - 1 。

 例如:

 输入:
 A = [ 1, 2]
 B = [-2,-1]
 C = [-1, 2]
 D = [ 0, 2]

 输出:
 2

 解释:
 两个元组如下:
 1. (0, 0, 0, 1) -> A[0] + B[0] + C[0] + D[1] = 1 + (-2) + (-1) + 2 = 0
 2. (1, 1, 0, 0) -> A[1] + B[1] + C[0] + D[0] = 2 + (-1) + (-1) + 0 = 0


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/4sum-ii
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

struct Group {

        int num1;
        int num2;

};
struct Result {
       int idx1;
       int idx2;
       int sum;
    
};
+ (void)fourNumbersPlus {
    struct Group A, B, C, D;
    A.num1 = 1;
    A.num2 = 2;
    B.num1 = -2;
    B.num2 = -1;
    C.num1 = -1;
    C.num2 = 2;
    D.num1 = 0;
    D.num2 = 2;
    [FourNumbersPlusTest fourSumCountA:A B:B C:C D:D];
    
}


+ (void)fourSumCountA:(struct Group)A B:(struct Group)B C:(struct Group)C D:(struct Group)D {
    
    int length = 2;
    NSMutableArray *pointsAB = @[].mutableCopy;
    NSMutableArray *pointsCD = @[].mutableCopy;
    for (int i = 0; i < length; i ++) {
        for (int j = 0; j < length; j ++) {
            struct Result res;
            int sum = (i == 0 ? A.num1 : A.num2) + (j == 0 ? B.num1 : B.num2);
            NSValue *value = nil;
            res.idx1 = i;
            res.idx2 = j;
            res.sum = sum;
            value = [NSValue valueWithBytes:&res  objCType:@encode(struct Result)];
            [pointsAB addObject:value];
        }
    }
    for (int i = 0; i < length; i ++) {
        for (int j = 0; j < length; j ++) {
            struct Result res;
            int sum = (i == 0 ? C.num1 : C.num2) + (j == 0 ? D.num1 : D.num2);
            NSValue *value = nil;
            res.idx1 = i;
            res.idx2 = j;
            res.sum = sum;
            value = [NSValue valueWithBytes:&res  objCType:@encode(struct Result)];
            [pointsCD addObject:value];
        }
    }
    int ans = 0;
    for (int i = 0; i < length *length; i ++) {
        struct Result AB;
        NSValue *value1 = pointsAB[i];
        [value1 getValue:&AB];
        for (int j = 0; j < length *length; j ++) {
            struct Result CD;
            NSValue *value2 = pointsCD[j];
            [value2 getValue:&CD];
            if (AB.sum + CD.sum == 0) {
                ans ++;
            }
        }
    }
    NSLog(@"ans === %d",ans);
    char ch[] = "hello world!";

    char_reverse(ch);
}
void char_reverse (char *cha) {
    // 定义头部指针
    char *begin = cha;
    // 定义尾部指针
    char *end = cha + strlen(cha) -1;
    while (begin < end) {
        char temp = *begin;
        *(begin++) = *end;
        *(end--) = temp;
    }
    NSLog(@"%s",cha);
}


/**
 复杂度分析

 时间复杂度：O(n^2)
  )。我们使用了两次二重循环，时间复杂度均为 O(n^2)
  )。在循环中对哈希映射进行的修改以及查询操作的期望时间复杂度均为 O(1)O(1)，因此总时间复杂度为 O(n^2)O(n
 2
  )。

 空间复杂度：O(n^2)，即为哈希映射需要使用的空间。在最坏的情况下，A[i]+B[j]A[i]+B[j] 的值均不相同，因此值的个数为 n^2n
 2
  ，也就需要 O(n^2)O(n
 2
  ) 的空间。

 作者：LeetCode-Solution
 链接：https://leetcode-cn.com/problems/4sum-ii/solution/si-shu-xiang-jia-ii-by-leetcode-solution/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */
@end
