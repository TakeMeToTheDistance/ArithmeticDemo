//
//  LargestSpacingTest.m
//  ArithmeticDemo
//
//  Created by 陈刚 on 2020/11/26.
//  Copyright © 2020 chengang. All rights reserved.
//

#import "LargestSpacingTest.h"

@implementation LargestSpacingTest
/**
 给定一个无序的数组，找出数组在排序之后，相邻元素之间最大的差值。

 如果数组元素个数小于 2，则返回 0。

 示例 1:

 输入: [3,6,9,1]
 输出: 3
 解释: 排序后的数组是 [1,3,6,9], 其中相邻元素 (3,6) 和 (6,9) 之间都存在最大差值 3。
 示例 2:

 输入: [10]
 输出: 0
 解释: 数组元素个数小于 2，因此返回 0。
 说明:

 你可以假设数组中所有元素都是非负整数，且数值在 32 位有符号整数范围内。
 请尝试在线性时间复杂度和空间复杂度的条件下解决此问题。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/maximum-gap
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
+ (void)largestSpacing {
    NSArray *nums = @[@1,@3,@6,@9];
    [LargestSpacingTest maximumGap:nums];
}

+ (void)maximumGap:(NSArray *)nums {
    NSLog(@"000");
    int spacing = 0;

    if (nums.count < 2) {
        spacing = 0;
    }
    //升序排列
    [nums sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
       return [obj1 integerValue] - [obj2 integerValue];
    }];
    
    for (int i = 0; i < nums.count -1; i ++) {
        spacing = MAX(spacing, abs([nums[i] intValue] - [nums[i+1] intValue]));
    }
    NSLog(@"%d",spacing);
}

//基数排序
+ (void)maximumGap1:(NSArray *)nums {
    NSLog(@"000");
    int spacing = 0;
    if (nums.count < 2) {
        spacing = 0;
    }
    int exp = 1;
    int array[nums.count];
    int buf[nums.count];
    for (int i = 0; i < nums.count; i ++) {
        buf[i] = 0;
        array[i] = [nums[i] intValue];
    }
    //升序排列
    [nums sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
       return [obj1 integerValue] - [obj2 integerValue];
    }];
    int maxValue = [nums[nums.count -1] intValue];
    while (maxValue > exp) {
        int cnt[10];
        for (int i = 0; i < 10; i ++) {
            cnt[i] = 0;
        }
        for (int i = 0; i < nums.count; i ++) {
            int digit = ([nums[i] intValue] / exp) % 10;
            cnt[digit] += 1;
        }
        for (int i = 0; i < 10; i ++) {
            cnt[i] += cnt[i-1];
        }
        NSArray *arrReverse = [[nums reverseObjectEnumerator] allObjects];
        for (int i = 0; i < arrReverse.count; i ++) {
            int digit = ([arrReverse[i] intValue] / exp) % 10;
            buf[cnt[digit] - 1] = [arrReverse[i] intValue];
            cnt[digit] -= 1;
        }
        for (int i = 0; i < nums.count; i ++) {
            array[i] = buf[i];
        }
        exp *= 10;
    }
    int res = 0;
    for (int i = 0; i < nums.count; i ++) {
        res = MAX(res, array[i] -array[i-1]);
    }
    NSLog(@"%d",res);
}

/**
 复杂度分析

 时间复杂度：O(N)，其中 N 是数组的长度。

 空间复杂度：O(N)，其中 N  是数组的长度。
 */
@end
