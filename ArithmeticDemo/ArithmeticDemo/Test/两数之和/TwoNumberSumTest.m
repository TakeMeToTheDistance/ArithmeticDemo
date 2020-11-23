//
//  TwoNumberSumTest.m
//  ArithmeticDemo
//
//  Created by 陈刚 on 2020/11/23.
//  Copyright © 2020 chengang. All rights reserved.
//

#import "TwoNumberSumTest.h"

@implementation TwoNumberSumTest

/**
 给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

 你可以假设每种输入只会对应一个答案。但是，数组中同一个元素不能使用两遍。

  

 示例:

 给定 nums = [2, 7, 11, 15], target = 9

 因为 nums[0] + nums[1] = 2 + 7 = 9
 所以返回 [0, 1]

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/two-sum
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
struct Result {
    int idx1;
    int idx2;
};

+ (void)twoSum {
    NSArray *nums = @[@2, @7, @11, @15];
    NSInteger target = 9;
    [TwoNumberSumTest sumTwoWithNums:nums target:target];
}

+ (void)sumTwoWithNums:(NSArray *)nums target:(NSInteger)target {
    struct Result res;
    BOOL success = NO;
    NSMutableArray *temp = @[].mutableCopy;
    for (int i = 0; i < nums.count; i ++) {
        NSInteger dif = target - [nums[i] integerValue];
        if([temp containsObject:@(dif)]){
            res.idx1 = (int)[temp indexOfObject:@(dif)];
            res.idx2 = i;
            success = YES;
            break;
        }
        [temp addObject:nums[i]];
    }
    if (success) {
        NSLog(@"idx1 == %d, idx2 == %d",res.idx1,res.idx2);
    }
}
/**
 时间复杂度：O(N)，其中 N 是数组中的元素数量。对于每一个元素 x，我们可以 O(1) 地寻找 target - x。

 空间复杂度：O(N)，其中 N 是数组中的元素数量。主要为哈希表的开销。

 作者：已注销
 链接：https://leetcode-cn.com/problems/two-sum/solution/liang-shu-zhi-he-java-jsshi-xian-shi-jian-fu-za-du/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */
@end
