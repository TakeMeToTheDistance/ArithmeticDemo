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
}

@end
