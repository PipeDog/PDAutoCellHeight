//
//  ViewController.m
//  PDAutoCellHeight
//
//  Created by liang on 2018/2/22.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "ViewController.h"
#import "PDDynamicHeightCell.h"
#import "UITableView+PDAutoCellHeight.h"

static NSString *const kDynamicCellID = @"kDynamicCellID";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
#define NEED_CACHE_CELL_HEIGHT 1
    NSString *text = self.dataArray[indexPath.row % self.dataArray.count];
#ifdef NEED_CACHE_CELL_HEIGHT
    return [tableView pd_heightForRowAtIndexPath:indexPath config:^(PDDynamicHeightCell *sourceCell) {
        [sourceCell loadData:text];
    } cacheInfo:^NSDictionary *{
        return @{PDCacheInfoUniqueIDKey: text,
                 PDCacheInfoIsDynamicKey: @(NO)};
    }];
#else
    return [tableView pd_heightForRowAtIndexPath:indexPath config:^(PDDynamicHeightCell *sourceCell) {
        [sourceCell loadData:text];
    }];
#endif
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count * 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDDynamicHeightCell *cell = [[PDDynamicHeightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDynamicCellID];
    NSString *text = self.dataArray[indexPath.row % self.dataArray.count];
    [cell loadData:text];
    return cell;
}

#pragma mark - Getter Methods
- (NSArray<NSString *> *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"一个人一生可以爱上很多的人，等你获得真正属于你的幸福之后，你就会明白一起的伤痛其实是一种财富，它让你学会更好地去把握和珍惜你爱的人。\
                       One may fall in love with many people during the lifetime. When youfinally get your own happiness, you will understand the previoussadness is kind of treasure, which makes you better to hold and cherish the people you love。",
                       @"幸福，不是长生不老，不是大鱼大肉，不是权倾朝野。幸福是每一个微小的生活愿望达成。当你想吃的时候有得吃，想被爱的时候有人来爱你。\
                       Happiness is not about being immortal nor having food or rights in one's hand. It’s about having each tiny wish come true, or having something to eat when you are hungry or having someone's love when you need love.",
                       @"我爱你不是因为你是谁，而是我在你面前可以是谁。\
                       I love you not for who you are, but for who I am with you.",
                       @"当明天变成了今天成为了昨天，最后成为记忆里不再重要的某一天，我们突然发现自己在不知不觉中已被时间推着向前走，这不是静止火车里，与相邻列车交错时，仿佛自己在前进的错觉，而是我们真实的在成长，在这件事里成了另一个自己。\
                       When tomorrow turns in today, yesterday, and someday that no more important in your memory, we suddenly realize that we r pushed forward by time. This is not a train in still in which you may feel forward when another train goes by. It is the truth that we've all grown up.And we become different."];
    }
    return _dataArray;
}


@end
