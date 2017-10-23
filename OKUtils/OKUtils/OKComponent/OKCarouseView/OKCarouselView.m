//
//  OKCarouselView.m
//  OKUtils
//
//  Created by MAC on 2017/10/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKCarouselView.h"

@interface OKCarouselView ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    @private
    NSInteger _metaDataCount;
    NSInteger _finalDataCount;
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
    
    [self addSubview:self.collectionView];
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        flowLayout.scrollDirection = _scrollDirection;//-Wenum-conversion
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews {
        
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        flowLayout.itemSize = self.collectionView.bounds.size;
    }
}

- (void)applicationWillResignActive {
    [self stopRotation];
}

- (void)applicationDidBecomeActive {
    [self startRotation];
}

- (void)startRotation {
    if (_autoRotation && _metaDataCount > 1) {
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
    if (_metaDataCount > 1) {
        NSIndexPath *currentIndexPath = [self.collectionView indexPathForItemAtPoint:self.collectionView.contentOffset];
        NSInteger nextIndex = _scrollStyle == OKCarouselViewScrollStylePositive
        ? (currentIndexPath.item + 1) : (currentIndexPath.item - 1);
        
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextIndex inSection:0];
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath
                                    atScrollPosition:(UICollectionViewScrollPositionNone)
                                            animated:YES];
    }
}


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    _metaDataCount = [self.dataSource numberOfItemsInCarouselView:self];
    collectionView.scrollEnabled = _metaDataCount > 1 ? YES : NO;
    _finalDataCount = _metaDataCount > 1 ? _metaDataCount + 2 : _metaDataCount;
    return _finalDataCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index;
    if (_finalDataCount > 1) {
        if (indexPath.row == 0) {
            index = _metaDataCount - 1;
        }
        else if (indexPath.row == _finalDataCount - 1) {
            index = 0;
        }
        else {
            index = indexPath.row - 1;
        }
    } else {
        index = indexPath.row;
    }
    
    return [self.dataSource carouselView:self cellForItemAtIndex:index];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(carouselCollectionView:didSelectItemAtIndex:)]) {
        NSInteger index;
        if (_finalDataCount > 1) {
            if (indexPath.row == 0) {
                index = _metaDataCount - 1;
            }
            else if (indexPath.row == _finalDataCount - 1) {
                index = 0;
            }
            else {
                index = indexPath.row - 1;
            }
        } else {
            index = indexPath.row;
        }
        [self.delegate carouselCollectionView:self didSelectItemAtIndex:index];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionView.bounds.size;
}

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}
- (void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier {
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
}
- (UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index {
    NSInteger row;
    if (_finalDataCount > 1) {
        if (index == _metaDataCount - 1) {
            row = 0;
        }
        else if (index == 0) {
            row = _finalDataCount - 1;
        }
        else {
            row = index + 1;
        }
    } else {
        row = index;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:0];
    return [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_metaDataCount <= 1) return;
    NSIndexPath *indexPath;
    // 做跳转
    if (_scrollDirection == OKCarouselViewScrollDirectionHorizontal) {
        if (scrollView.contentOffset.x <= 0) {
            indexPath = [NSIndexPath indexPathForItem:(_finalDataCount - 2) inSection:0];
        }
        else if (scrollView.contentOffset.x >= ((_finalDataCount - 1) * self.collectionView.bounds.size.width)) {
            indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        }
    } else if (_scrollDirection == OKCarouselViewScrollDirectionVertical) {
        if (scrollView.contentOffset.y <= 0) {
            indexPath = [NSIndexPath indexPathForItem:(_finalDataCount - 2) inSection:0];
        }
        else if (scrollView.contentOffset.y >= ((_finalDataCount - 1) * self.collectionView.bounds.size.height)) {
            indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        }
    }
    if (indexPath) {
        [self.collectionView scrollToItemAtIndexPath:indexPath
                                    atScrollPosition:UICollectionViewScrollPositionNone
                                            animated:NO];
        
        if ([self.delegate respondsToSelector:@selector(carouselCollectionView:didScrollAtIndex:)]) {
            NSInteger index;
            if (_finalDataCount > 1) {
                if (indexPath.row == 0) {
                    index = _metaDataCount - 1;
                }
                else if (indexPath.row == _finalDataCount - 1) {
                    index = 0;
                }
                else {
                    index = indexPath.row - 1;
                }
            } else {
                index = indexPath.row;
            }
            [self.delegate carouselCollectionView:self didScrollAtIndex:index];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopRotation];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self startRotation];
}

- (void)reloadData {
    [self.collectionView reloadData];
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
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        
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
