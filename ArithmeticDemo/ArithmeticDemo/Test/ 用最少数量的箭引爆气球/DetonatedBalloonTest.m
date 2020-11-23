
//
//  DetonatedBalloonTest.m
//  ArithmeticDemo
//
//  Created by 陈刚 on 2020/11/23.
//  Copyright © 2020 chengang. All rights reserved.
//

#import "DetonatedBalloonTest.h"

@implementation DetonatedBalloonTest

/**
 在二维空间中有许多球形的气球。对于每个气球，提供的输入是水平方向上，气球直径的开始和结束坐标。由于它是水平的，所以纵坐标并不重要，因此只要知道开始和结束的横坐标就足够了。开始坐标总是小于结束坐标。

 一支弓箭可以沿着 x 轴从不同点完全垂直地射出。在坐标 x 处射出一支箭，若有一个气球的直径的开始和结束坐标为 xstart，xend， 且满足  xstart ≤ x ≤ xend，则该气球会被引爆。可以射出的弓箭的数量没有限制。 弓箭一旦被射出之后，可以无限地前进。我们想找到使得所有气球全部被引爆，所需的弓箭的最小数量。

 给你一个数组 points ，其中 points [i] = [xstart,xend] ，返回引爆所有气球所必须射出的最小弓箭数。

  
 示例 1：

 输入：points = [[10,16],[2,8],[1,6],[7,12]]
 输出：2
 解释：对于该样例，x = 6 可以射爆 [2,8],[1,6] 两个气球，以及 x = 11 射爆另外两个气球
 示例 2：

 输入：points = [[1,2],[3,4],[5,6],[7,8]]
 输出：4
 示例 3：

 输入：points = [[1,2],[2,3],[3,4],[4,5]]
 输出：2
 示例 4：

 输入：points = [[1,2]]
 输出：1
 示例 5：

 输入：points = [[2,3],[2,3]]
 输出：1
  

 提示：

 0 <= points.length <= 10m4
 points[i].length == 2
 -231 <= xstart < xend <= 231 - 1

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/minimum-number-of-arrows-to-burst-balloons
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


struct Balloon {//构建气球元素,x1为左侧x坐标,x2为右侧x坐标
        float x1;
        float x2;
};
+ (void)detonatedBalloon {

    //测试数据,验证结果
    NSArray *arrTest1 = @[@(10),@(2),@(1),@(7)];
    NSArray *arrTest2 = @[@(16),@(8),@(6),@(12)];
    //将数据存储在数组中
     NSMutableArray *points = [NSMutableArray array];
    for (unsigned i = 0 ; i<arrTest1.count; i++) {
            struct Balloon s;
        s.x1 = [arrTest1[i] floatValue];
            s.x2 = [arrTest2[i] floatValue];
            NSValue *value = nil;
            value = [NSValue valueWithBytes:&s objCType:@encode(struct Balloon)];
            [points addObject:value];
        }
    //开始查找所需数量
    [DetonatedBalloonTest findMinArrowShots:points];
}

+ (void)findMinArrowShots:(NSArray *)points {
    if (!points.count) {
        return;
    }
    //首先按照气球右侧x坐标升序排列
    NSArray *arrSort = [points sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        struct Balloon s1,s2;
        NSValue *value1 = obj1;
        NSValue *value2 = obj2;
        [value1 getValue:&s1];
        [value2 getValue:&s2];
        return s1.x2 - s2.x2;
    }];
    struct Balloon s0;
    NSValue *value = arrSort[0];
    [value getValue:&s0];
    //获取第一个元素的x2;
    float pos = s0.x2;
    //初始化计数
    NSInteger ans = 1;
    for (NSValue *balloon in arrSort) {
        struct Balloon s ;
        [balloon getValue:&s];
        if (s.x1 > pos) {//当数组元素的x1比上一个元素的x2大时,就需要增加1,并记录新的x2
            pos = s.x2;
            ans ++;
        }
    }
//    for (NSValue *balloon in arrSort) {
//         struct Balloon s ;
//         [balloon getValue:&s];
//        NSLog(@"point.x1 == %f point.x2 == %f",s.x1,s.x2);
//
//     }
    NSLog(@"ans == %ld",ans);
}
/**
 时间复杂度：O(n\log n)O(nlogn)，其中 nn 是数组 \textit{points}points 的长度。排序的时间复杂度为 O(n \log n)O(nlogn)，对所有气球进行遍历并计算答案的时间复杂度为 O(n)O(n)，其在渐进意义下小于前者，因此可以忽略。

 空间复杂度：O(\log n)O(logn)，即为排序需要使用的栈空间。

 作者：LeetCode-Solution
 链接：https://leetcode-cn.com/problems/minimum-number-of-arrows-to-burst-balloons/solution/yong-zui-shao-shu-liang-de-jian-yin-bao-qi-qiu-1-2/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */




@end
