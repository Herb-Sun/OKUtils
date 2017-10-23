//
//  OKCarouseView.m
//  OKUtils
//
//  Created by MAC on 2017/10/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKCarouseView.h"

@interface OKCarouselView ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
@private
    NSInteger _dataSourceCount;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation OKCarouselView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupInitialized];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupInitialized];
    }
    return self;
}

- (void)setupInitialized {
    
    _scrollDirection = OKCarouselViewScrollDirectionVertical;
    _scrollStyle = OKCarouselViewScrollStylePositive;
    _autoRotation = NO;
    _ratationTimeInterval = 3.0;
    _runloopMode = NSDefaultRunLoopMode;
    
    self.collectionView.frame = self.bounds;
    [self addSubview:self.collectionView];
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        flowLayout.scrollDirection = _scrollDirection;//-Wenum-conversion
        flowLayout.itemSize = self.collectionView.bounds.size;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)applicationWillResignActive {
    [self stopRotation];
}

- (void)applicationDidBecomeActive {
    [self startRotation];
}

- (void)startRotation {
    if (_autoRotation) {
        [self timer];
    }
}
- (void)stopRotation {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)timerAction:(NSTimer *)timer {
    
}


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = [self.dataSource numberOfItemsInCarouseView:self];
    count = count > 1 ? count + 2 : count;
    _dataSourceCount = count;
    return _dataSourceCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = 0;
    
    
    //    TNUserMenuV3Model *menuModel = [self.viewModel.menuModel.homeMenus tn_objectAtIndex:indexPath.item];
    //
    //    TNUserMineMenuItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TNUserMineMenuItemCell cellIdentifier] forIndexPath:indexPath];
    //    cell.menuModel = menuModel;
    //    return cell;
}

#pragma mark - Private

- (void)setScrollDirection:(OKCarouselViewScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        flowLayout.scrollDirection = scrollDirection;
    }
}

- (void)setAutoRotation:(BOOL)autoRotation {
    _autoRotation = autoRotation;
    if (autoRotation) {
        [self timer];
    }
}

#pragma mark - LazyLoad

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0.0;
        flowLayout.minimumInteritemSpacing = 0.0;
        flowLayout.itemSize = self.bounds.size;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_ratationTimeInterval target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:_runloopMode];
    }
    return _timer;
}

@end

@interface OKCarouselViewLayout : UICollectionViewFlowLayout

@end

@implementation OKCarouselViewLayout

@end

