//
//  OKCarouselView.m
//  OKUtils
//
//  Created by MAC on 2017/10/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKCarouselView.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wenum-conversion"

@interface OKCarouselView ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    @private
    NSInteger _metaDataCount;
    NSInteger _finalDataCount;
    NSInteger _lastestIndex;
    CFRunLoopObserverRef _runLoopObserver;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation OKCarouselView

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupInitialized];
        [self setupNotificationAndObserver];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupInitialized];
        [self setupNotificationAndObserver];
    }
    return self;
}

- (void)setupInitialized {
    
    _scrollDirection = OKCarouselViewScrollDirectionVertical;
    _scrollStyle = OKCarouselViewScrollStylePositive;
    _autoLoop = NO;
    _loopTimeInterval = 3.0;
    _runloopMode = NSDefaultRunLoopMode;
    
    [self addSubview:self.collectionView];
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        flowLayout.scrollDirection = _scrollDirection;
    }
}

- (void)setupNotificationAndObserver {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    _runLoopObserver = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(),
                                                          kCFRunLoopAllActivities,
                                                          YES,
                                                          0,
                                                          ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity)
    {
        if (_runloopMode == NSDefaultRunLoopMode) {
            if (activity == kCFRunLoopExit) {
                [self stopLoop];
            }
            else if (activity == kCFRunLoopBeforeTimers) {
                if (!self.timer) {
                    [self startLoop];
                }
            }
        }
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), _runLoopObserver, kCFRunLoopDefaultMode);
    CFRelease(_runLoopObserver);
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        flowLayout.itemSize = self.collectionView.bounds.size;
    }

    [self initialCollectionViewIndex];
    
    if ([self.delegate respondsToSelector:@selector(carouselView:didScrollAtIndex:)]) {
        [self.delegate carouselView:self didScrollAtIndex:0];
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview || [newSuperview isEqual:[NSNull null]]) {
        CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), _runLoopObserver, kCFRunLoopDefaultMode);
        [self stopLoop];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public

- (void)setScrollDirection:(OKCarouselViewScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        flowLayout.scrollDirection = scrollDirection;
    }
    [self initialCollectionViewIndex];
}

- (void)setScrollStyle:(OKCarouselViewScrollStyle)scrollStyle {
    _scrollStyle = scrollStyle;
    [self resetTimer];
}

- (void)setAutoLoop:(BOOL)autoLoop {
    _autoLoop = autoLoop;
    [self resetTimer];
}

- (void)setLoopTimeInterval:(CGFloat)loopTimeInterval {
    _loopTimeInterval = MAX(loopTimeInterval, 0.25);
    [self resetTimer];
}

- (void)setRunloopMode:(NSRunLoopMode)runloopMode {
    _runloopMode = runloopMode;
    [self resetTimer];
}

- (void)startLoop {
    if (_autoLoop && self.collectionView.scrollEnabled) {
        [self setupTimer];
    }
}

- (void)stopLoop {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - Private

- (void)setupTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:_loopTimeInterval target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:_runloopMode];
}

- (void)resetTimer {
    [self stopLoop];
    [self startLoop];
}

- (void)timerAction:(NSTimer *)timer {
    if (self.collectionView.scrollEnabled) {
        NSIndexPath *currentIndexPath = [self.collectionView indexPathForItemAtPoint:self.collectionView.contentOffset];
        NSInteger nextIndex = _scrollStyle == OKCarouselViewScrollStylePositive
        ? (currentIndexPath.item + 1) : (currentIndexPath.item - 1);
        
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextIndex inSection:0];
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath
                                    atScrollPosition:UICollectionViewScrollPositionNone
                                            animated:YES];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.collectionView.backgroundColor = backgroundColor;
}

- (void)applicationWillResignActive {
    [self stopLoop];
}

- (void)applicationDidBecomeActive {
    [self startLoop];
}

- (void)initialCollectionViewIndex {
    if ([self.dataSource respondsToSelector:@selector(numberOfItemsInCarouselView:)]) {
        NSInteger count = [self.dataSource numberOfItemsInCarouselView:self];
        if (count > 1) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]
                                        atScrollPosition:UICollectionViewScrollPositionNone
                                                animated:NO];
        }
    }
}

- (NSIndexPath *)convertIndexToIndexPath:(NSInteger)index {
    NSInteger item = index;
    if (_finalDataCount > 1) {
        if (index == _metaDataCount - 1) {
            item = 0;
        }
        else if (index == 0) {
            item = _finalDataCount - 1;
        }
        else {
            item = index + 1;
        }
    }
    return [NSIndexPath indexPathForItem:item inSection:0];
}

- (NSInteger)convertIndexPathToIndex:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.item;
    
    if (_finalDataCount > 1) {
        if (indexPath.item == 0) {
            index = _metaDataCount - 1;
        }
        else if (indexPath.item == _finalDataCount - 1) {
            index = 0;
        }
        else {
            index = indexPath.item - 1;
        }
    }
    return index;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    _metaDataCount = [self.dataSource numberOfItemsInCarouselView:self];
    _finalDataCount = _metaDataCount > 1 ? _metaDataCount + 2 : _metaDataCount;
    collectionView.scrollEnabled = _metaDataCount > 1 ? YES : NO;
    return _finalDataCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self convertIndexPathToIndex:indexPath];
    return [self.dataSource carouselView:self cellForItemAtIndex:index];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(carouselView:didSelectItemAtIndex:)]) {
        NSInteger index = [self convertIndexPathToIndex:indexPath];
        [self.delegate carouselView:self didSelectItemAtIndex:index];
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
    NSIndexPath *indexPath = [self convertIndexToIndexPath:index];
    return [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

- (void)reloadData {
    [self stopLoop];
    [self.collectionView reloadData];
    [self initialCollectionViewIndex];
    [self startLoop];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.collectionView.scrollEnabled) return;
    
    NSIndexPath *scrollIndexPath = [self.collectionView indexPathForItemAtPoint:scrollView.contentOffset];
    NSInteger scrollIndex = [self convertIndexPathToIndex:scrollIndexPath];
    if (scrollIndex != _lastestIndex) {
        _lastestIndex = scrollIndex;
        if ([self.delegate respondsToSelector:@selector(carouselView:didScrollAtIndex:)]) {
            [self.delegate carouselView:self didScrollAtIndex:_lastestIndex];
        }
    }
    /// 控制循环
    NSIndexPath *indexPath;
    if (_scrollDirection == OKCarouselViewScrollDirectionHorizontal) {
        if (scrollView.contentOffset.x <= 0) {
            indexPath = [NSIndexPath indexPathForItem:(_finalDataCount - 2) inSection:0];
        }
        else if (scrollView.contentOffset.x >= ((_finalDataCount - 1) * self.collectionView.bounds.size.width)) {
            indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        }
    }
    else if (_scrollDirection == OKCarouselViewScrollDirectionVertical) {
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
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopLoop];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self startLoop];
}

#pragma mark - LazyLoad

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0.0;
        flowLayout.minimumInteritemSpacing = 0.0;
        flowLayout.estimatedItemSize = CGSizeZero;
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

@end

#pragma clang diagnostic pop
