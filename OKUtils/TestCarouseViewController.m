//
//  TestCarouseViewController.m
//  OKUtils
//
//  Created by herb on 2017/10/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "TestCarouseViewController.h"
#import "OKCarouselView.h"
#import "TestCarouselViewCell.h"
#import "OKUtils.h"

@interface TestCarouseViewController ()<OKCarouselViewDataSource, OKCarouselViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation TestCarouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = OKColor_Random();
    _dataSource = @[@"1", @"2", @"3", @"4"];
    
    OKCarouselView *carouselView = [[OKCarouselView alloc] init];
    carouselView.frame = CGRectMake(10, 300, self.view.width - 20, 200);
    carouselView.delegate = self;
    carouselView.dataSource = self;
    carouselView.autoRotation = YES;
    [self.view addSubview:carouselView];
    
    [carouselView registerClass:[TestCarouselViewCell class] forCellWithReuseIdentifier:NSStringFromClass(TestCarouselViewCell.class)];
}

- (NSInteger)numberOfItemsInCarouselView:(OKCarouselView *)carouselView {
    return _dataSource.count;
}

- (UICollectionViewCell *)carouselView:(OKCarouselView *)carouselView
                             cellForItemAtIndex:(NSInteger)index {
    
    
    
    TestCarouselViewCell *cell = [carouselView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(TestCarouselViewCell.class) forIndex:index];
    cell.backgroundColor = OKColor_Random();
    cell.titleLabel.text = [self.dataSource objectAtIndex:index];
    return cell;
}


- (void)carouselCollectionView:(OKCarouselView *)carouselCollectionView didScrollAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)carouselCollectionView:(OKCarouselView *)carouselCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end


