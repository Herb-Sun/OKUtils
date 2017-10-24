//
//  TestCarouselViewController.m
//  OKUtils
//
//  Created by MAC on 2017/10/24.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "TestCarouselViewController.h"
#import "OKCarouselView.h"
#import "TestCarouselViewCell.h"
#import "OKUtils.h"

@interface TestCarouselViewController ()<OKCarouselViewDataSource, OKCarouselViewDelegate>

@property (weak, nonatomic) IBOutlet OKCarouselView *carouselView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation TestCarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = OKColor_Random();
    _dataSource = @[@"1", @"2", @"3", @"4"];
    
//    _carouselView = [[OKCarouselView alloc] init];
//    _carouselView.frame = CGRectMake(10, 200, self.view.width - 20, 200);
//    _carouselView.delegate = self;
//    _carouselView.dataSource = self;
//    _carouselView.autoLoop = YES;
    _carouselView.scrollDirection = OKCarouselViewScrollDirectionHorizontal;
    _carouselView.scrollStyle = OKCarouselViewScrollStylePositive;
    
    [_carouselView registerClass:[TestCarouselViewCell class] forCellWithReuseIdentifier:NSStringFromClass(TestCarouselViewCell.class)];
    
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


- (void)carouselView:(OKCarouselView *)carouselView didScrollAtIndex:(NSInteger)index {
    NSLog(@"滚动到了--%ld", index);
}

- (void)carouselView:(OKCarouselView *)carouselView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了--%ld", index);
    
}

- (IBAction)direction:(id)sender {
    if (self.carouselView.scrollDirection == OKCarouselViewScrollDirectionVertical) {
        self.carouselView.scrollDirection = OKCarouselViewScrollDirectionHorizontal;
    } else {
        self.carouselView.scrollDirection = OKCarouselViewScrollDirectionVertical;
    }
}

- (IBAction)style:(id)sender {
    if (self.carouselView.scrollStyle == OKCarouselViewScrollStylePositive) {
        self.carouselView.scrollStyle = OKCarouselViewScrollStyleOpposite;
    } else {
        self.carouselView.scrollStyle = OKCarouselViewScrollStylePositive;

    }
}
- (IBAction)autoloop:(id)sender {
    self.carouselView.autoLoop = !self.carouselView.isAutoLoop;
}
- (IBAction)looptime:(id)sender {
    self.carouselView.loopTimeInterval -= 0.5;
}
- (IBAction)mode:(id)sender {
    self.carouselView.runloopMode = NSRunLoopCommonModes;
}
- (IBAction)reload:(id)sender {
    if (_dataSource.count == 3) {
        _dataSource = @[@"一"];
    } else {
        _dataSource = @[@"一", @"二", @"三"];
    }
    [self.carouselView reloadData];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    NSLog(@"----");
}

@end
