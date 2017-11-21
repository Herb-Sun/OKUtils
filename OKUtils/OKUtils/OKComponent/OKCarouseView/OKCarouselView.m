//
//  OKCarouselView
//
//  Created by herb
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKCarouselView.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wenum-conversion"

@interface OKCarouselView ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    @private
    BOOL      _initialIndexNeeded;
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
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInitialized];
        [self setupNotificationAndObserver];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupInitialized];
        [self setupNotificationAndObserver];
    }
    return self;
}

- (void)setupInitialized {
    
    _scrollDirection = OKCarouselViewScrollDirectionHorizontal;
    _scrollStyle = OKCarouselViewScrollStylePositive;
    _scrollEnabled = YES;
    _autoLoop = NO;
    _loopTimeInterval = 3.0;
    _runloopMode = NSDefaultRunLoopMode;
    _initialIndexNeeded = YES;
    
    [self addSubview:self.collectionView];
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
                                                          kCFRunLoopBeforeTimers | kCFRunLoopExit,
                                                          true,
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
    
    if (!CGRectEqualToRect(self.collectionView.frame, self.bounds)) {
        self.collectionView.frame = self.bounds;
    }
    
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        if ((NSInteger)flowLayout.scrollDirection != (NSInteger)_scrollDirection) {
            flowLayout.scrollDirection = _scrollDirection;
        }
        if (!CGSizeEqualToSize(flowLayout.itemSize, self.collectionView.bounds.size)) {
            flowLayout.itemSize = self.collectionView.bounds.size;
        }
    }
    if (_initialIndexNeeded) {
        [self initialCollectionViewIndex];
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
    if (_scrollDirection == scrollDirection) return;
    _scrollDirection = scrollDirection;

    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        flowLayout.scrollDirection = scrollDirection;
    }
    [self initialCollectionViewIndex];
}

- (void)setScrollStyle:(OKCarouselViewScrollStyle)scrollStyle {
    if (_scrollStyle == scrollStyle) return;
    _scrollStyle = scrollStyle;
    [self resetTimer];
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    if (_scrollEnabled == scrollEnabled) return;
    _scrollEnabled = scrollEnabled;
    self.collectionView.scrollEnabled = scrollEnabled;
}

- (void)setAutoLoop:(BOOL)autoLoop {
    if (_autoLoop == autoLoop) return;
    _autoLoop = autoLoop;
    [self resetTimer];
}

- (void)setLoopTimeInterval:(CGFloat)loopTimeInterval {
    if (_loopTimeInterval == loopTimeInterval) return;
    _loopTimeInterval = MAX(loopTimeInterval, 0.25);
    [self resetTimer];
}

- (void)setRunloopMode:(NSRunLoopMode)runloopMode {
    if (_runloopMode == runloopMode) return;
    _runloopMode = runloopMode;
    [self resetTimer];
}

- (void)startLoop {
    if (![self.dataSource respondsToSelector:@selector(numberOfItemsInCarouselView:)]) return;

    NSInteger itemNumber = [self.dataSource numberOfItemsInCarouselView:self];
    if (_autoLoop && itemNumber > 1) {
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
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_loopTimeInterval target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:_runloopMode];
    }
}

- (void)resetTimer {
    [self stopLoop];
    [self startLoop];
}

- (void)timerAction:(NSTimer *)timer {
    if (![self.dataSource respondsToSelector:@selector(numberOfItemsInCarouselView:)]) return;

    NSInteger itemNumber = [self.dataSource numberOfItemsInCarouselView:self];
    if (itemNumber > 1 && self.collectionView.visibleCells.count > 0) {
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
    if (_metaDataCount > 1) {
        if (_scrollDirection == OKCarouselViewScrollDirectionHorizontal) {
            self.collectionView.contentOffset = CGPointMake(self.collectionView.bounds.size.width, 0);
        }
        else if (_scrollDirection == OKCarouselViewScrollDirectionVertical) {
            self.collectionView.contentOffset = CGPointMake(0, self.collectionView.bounds.size.height);
        }
        _initialIndexNeeded = NO;
    }
    if ([self.delegate respondsToSelector:@selector(carouselView:didScrollAtIndex:)]) {
        [self.delegate carouselView:self didScrollAtIndex:0];
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
    NSAssert([self.dataSource respondsToSelector:@selector(numberOfItemsInCarouselView:)], @"must be responds the numberOfItemsInCarouselView: selector!");

    _metaDataCount = [self.dataSource numberOfItemsInCarouselView:self];
    _finalDataCount = _metaDataCount > 1 ? _metaDataCount + 2 : _metaDataCount;
    if (_metaDataCount <= 1) {
        collectionView.scrollEnabled = NO;
    }
    return _finalDataCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert([self.dataSource respondsToSelector:@selector(carouselView:cellForItemAtIndex:)], @"must be responds the carouselView:cellForItemAtIndex: selector!");

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
    
    NSIndexPath *scrollIndexPath = [self.collectionView indexPathForItemAtPoint:scrollView.contentOffset];
    NSInteger scrollIndex = [self convertIndexPathToIndex:scrollIndexPath];
    if (scrollIndex != _lastestIndex) {
        _lastestIndex = scrollIndex;
        if ([self.delegate respondsToSelector:@selector(carouselView:didScrollAtIndex:)]) {
            [self.delegate carouselView:self didScrollAtIndex:_lastestIndex];
        }
    }
    
    // Control Loop
    CGPoint point = CGPointZero;
    if (_scrollDirection == OKCarouselViewScrollDirectionHorizontal) {
        if (scrollView.contentOffset.x <= 0) {
            point = CGPointMake(((_finalDataCount - 2) * self.collectionView.bounds.size.width), 0);
        }
        else if (scrollView.contentOffset.x >= ((_finalDataCount - 1) * self.collectionView.bounds.size.width)) {
            point = CGPointMake(self.collectionView.bounds.size.width, 0);
        }
    }
    else if (_scrollDirection == OKCarouselViewScrollDirectionVertical) {
        if (scrollView.contentOffset.y <= 0) {
            point = CGPointMake(0, (_finalDataCount - 2) * self.collectionView.bounds.size.height);
        }
        else if (scrollView.contentOffset.y >= ((_finalDataCount - 1) * self.collectionView.bounds.size.height)) {
            point = CGPointMake(0, self.collectionView.bounds.size.height);
        }
    }
    
    if (!CGPointEqualToPoint(point, CGPointZero)) {
        self.collectionView.contentOffset = point;
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
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

@end

#pragma clang diagnostic pop
