//
//  OKCarouselView.h
//  OKUtils
//
//  Created by MAC on 2017/10/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class OKCarouselView;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, OKCarouselViewScrollDirection) {
    OKCarouselViewScrollDirectionVertical = UICollectionViewScrollDirectionVertical,
    OKCarouselViewScrollDirectionHorizontal = UICollectionViewScrollDirectionHorizontal
};

typedef NS_ENUM(NSInteger, OKCarouselViewScrollStyle) {
    /**
     if scrollDirection is Vetical so scrollStyle is bottom to top,
     if scrollDirection is Horizontal so scrollStyle is right to left
     */
    OKCarouselViewScrollStylePositive,
    /**
     if scrollDirection is Vetical so scrollStyle is top to bottom,
     if scrollDirection is Horizontal so scrollStyle is left to right
     */
    OKCarouselViewScrollStyleOpposite
};

@protocol OKCarouselViewDataSource <NSObject>
@required
- (NSInteger)numberOfItemsInCarouselView:(OKCarouselView *)carouselView;

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndex:
- (__kindof UICollectionViewCell *)carouselView:(OKCarouselView *)carouselView
                             cellForItemAtIndex:(NSInteger)index;

@end

@protocol OKCarouselViewDelegate <NSObject>
@optional

- (void)carouselView:(OKCarouselView *)carouselView didScrollAtIndex:(NSInteger)index;

- (void)carouselView:(OKCarouselView *)carouselView didSelectItemAtIndex:(NSInteger)index;

@end


IB_DESIGNABLE @interface OKCarouselView : UIView

@property (nonatomic, assign) IBInspectable OKCarouselViewScrollDirection scrollDirection; ///< default is OKCarouselViewScrollDirectionVertical

@property (nonatomic, assign) IBInspectable OKCarouselViewScrollStyle scrollStyle; ///< default is OKCarouselViewScrollStylePositive

@property (nonatomic, weak, nullable) IBOutlet id <OKCarouselViewDelegate> delegate;
@property (nonatomic, weak, nullable) IBOutlet id <OKCarouselViewDataSource> dataSource;

@property (nonatomic, assign, getter=isAutoLoop) IBInspectable BOOL autoLoop; ///< default is NO
@property (nonatomic, assign) IBInspectable CGFloat loopTimeInterval; ///< default is 3.0, Minimal is 0.25
@property (nonatomic, copy) NSRunLoopMode runloopMode; ///< default is NSDefaultRunLoopMode

- (void)startLoop;
- (void)stopLoop;

- (void)registerClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(nullable UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
