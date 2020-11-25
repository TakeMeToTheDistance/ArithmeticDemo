//
//  RiseDropCharTest.m
//  ArithmeticDemo
//
//  Created by 陈刚 on 2020/11/25.
//  Copyright © 2020 chengang. All rights reserved.
//

#import "RiseDropCharTest.h"
/**
 给你一个字符串 s ，请你根据下面的算法重新构造字符串：
 
 从 s 中选出 最小 的字符，将它 接在 结果字符串的后面。
 从 s 剩余字符中选出 最小 的字符，且该字符比上一个添加的字符大，将它 接在 结果字符串后面。
 重复步骤 2 ，直到你没法从 s 中选择字符。
 从 s 中选出 最大 的字符，将它 接在 结果字符串的后面。
 从 s 剩余字符中选出 最大 的字符，且该字符比上一个添加的字符小，将它 接在 结果字符串后面。
 重复步骤 5 ，直到你没法从 s 中选择字符。
 重复步骤 1 到 6 ，直到 s 中所有字符都已经被选过。
 在任何一步中，如果最小或者最大字符不止一个 ，你可以选择其中任意一个，并将其添加到结果字符串。
 
 请你返回将 s 中字符重新排序后的 结果字符串 。
 
  
 
 示例 1：
 
 输入：s = "aaaabbbbcccc"
 输出："abccbaabccba"
 解释：第一轮的步骤 1，2，3 后，结果字符串为 result = "abc"
 第一轮的步骤 4，5，6 后，结果字符串为 result = "abccba"
 第一轮结束，现在 s = "aabbcc" ，我们再次回到步骤 1
 第二轮的步骤 1，2，3 后，结果字符串为 result = "abccbaabc"
 第二轮的步骤 4，5，6 后，结果字符串为 result = "abccbaabccba"
 示例 2：
 
 输入：s = "rat"
 输出："art"
 解释：单词 "rat" 在上述算法重排序以后变成 "art"
 示例 3：
 
 输入：s = "leetcode"
 输出："cdelotee"
 示例 4：
 
 输入：s = "ggggggg"
 输出："ggggggg"
 示例 5：
 
 输入：s = "spo"
 输出："ops"
  
 
 提示：
 
 1 <= s.length <= 500
 s 只包含小写英文字母。
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/increasing-decreasing-string
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 方法一：桶计数
 思路及解法
 
 仔细分析步骤，我们发现：
 
 每个字符被选择且仅被选择一次；
 
 每一轮会在字符串末尾加入一个先升后降的字符串，且该串的上升部分和下降部分都会尽可能长。
 
 于是我们重复若干轮下述操作，直到每一个字符都被选择过，这样就可以构造出这个字符串：
 
 先从未被选择的字符中提取出最长的上升字符串，将其加入答案。
 
 然后从未被选择的字符中提取出最长的下降字符串，将其加入答案。
 
 注意到在构造时我们只关注字符本身，而不关注字符在原字符串中的位置。因此我们可以直接创建一个大小为 2626 的桶，记录每种字符的数量。每次提取最长的上升或下降字符串时，我们直接顺序或逆序遍历这个桶。
 
 具体地，在遍历桶的过程中，如果当前桶的计数值不为零，那么将当前桶对应的字符加入到答案中，并将当前桶的计数值减一即可。我们重复这一过程，直到答案字符串的长度与传入的字符串的长度相等。
 
 代码
 
 C++JavaJavaScriptPython3GolangC
 
 
 作者：LeetCode-Solution
 链接：https://leetcode-cn.com/problems/increasing-decreasing-string/solution/shang-sheng-xia-jiang-zi-fu-chuan-by-leetcode-solu/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */
@implementation RiseDropCharTest
+ (void)riseDropChar {
    NSString *s = @"spo";
    [RiseDropCharTest sortString:s];
}

+ (void)sortString:(NSString *)s {
    //获取'a'的ascll
    NSInteger inta = [@"a" characterAtIndex:0];
    //相当于26个桶
    int bucket[26];
    for (int i = 0; i < 26; i++) {
        bucket[i] = 0;
    }
    //把s中的字符分别放到对应的桶里
    for (int i = 0; i < s.length; i ++) {
        NSInteger charItem = [s characterAtIndex:i];
        bucket[charItem - inta] ++;
    }
    //存储计算的结果
    NSMutableString *res = @"".mutableCopy;
    while (res.length < s.length) {
        //先从左往右找，遍历26个桶,如果当前桶不为空，
        //就从当前桶里拿出一个元素出来
        for (int i = 0; i < 26; i ++) {
            if (bucket[i]) {
                [res appendString:[NSString stringWithFormat:@"%c", i + inta]];
                bucket[i] --;
            }
        }
        //从右往左拿，同上
        for (int i = 25; i >= 0; i --) {
            if (bucket[i]) {
                [res appendString:[NSString stringWithFormat:@"%c", i + inta]];
                bucket[i] --;
            }
        }
    }
        NSLog(@"%@",res);
}
/**
 复杂度分析
 
 时间复杂度：O(∣Σ∣×∣s∣)，其中 Σ 为字符集，s 为传入的字符串，在这道题中，字符集为全部小写字母，∣Σ∣=26。最坏情况下字符串中所有字符都相同，那么对于每一个字符，我们需要遍历一次整个桶。
 
 空间复杂度：O(∣Σ∣)，其中 Σ 为字符集。我们需要和 ∣Σ∣ 等大的桶来记录每一类字符的数量。
 
 作者：LeetCode-Solution
 链接：https://leetcode-cn.com/problems/increasing-decreasing-string/solution/shang-sheng-xia-jiang-zi-fu-chuan-by-leetcode-solu/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */
@end
