//
//  TestTableViewCell.m
//  OKUtils
//
//  Created by MAC on 2017/10/26.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "TestTableViewCell.h"
#import "TestCarouselViewCell.h"
#import "OKUtils/OKUtils.h"
@implementation TestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = OKColor_Random();
    _dataSource = @[@"1", @"2", @"3", @"4"];
    _carouselView.delegate =self;
    _carouselView.dataSource = self;
    _carouselView.runloopMode = NSRunLoopCommonModes;
    [_carouselView registerClass:[TestCarouselViewCell class] forCellWithReuseIdentifier:NSStringFromClass(TestCarouselViewCell.class)];
}

- (NSInteger)numberOfItemsInCarouselView:(OKCarouselView *)carouselView {
    return _dataSource.count;
}

- (UICollectionViewCell *)carouselView:(OKCarouselView *)carouselView
                    cellForItemAtIndex:(NSInteger)index {
    
    TestCarouselViewCell *cell = [carouselView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(TestCarouselViewCell.class) forIndex:index];
    if (index == 0) {
        cell.backgroundColor = [UIColor blueColor];
    }
    else if (index == 1) {
        cell.backgroundColor = [UIColor redColor];
    }
    else if (index == 2) {
        cell.backgroundColor = [UIColor grayColor];
    }
    else if (index == 3) {
        cell.backgroundColor = [UIColor yellowColor];
    }
    else if (index == 4) {
        cell.backgroundColor = [UIColor orangeColor];
    }
    cell.titleLabel.text = [self.dataSource objectAtIndex:index];
    return cell;
}


- (void)carouselView:(OKCarouselView *)carouselView didScrollAtIndex:(NSInteger)index {
    NSLog(@"滚动到了--%ld", index);
}

- (void)carouselView:(OKCarouselView *)carouselView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了--%ld", index);
    
}
@end
