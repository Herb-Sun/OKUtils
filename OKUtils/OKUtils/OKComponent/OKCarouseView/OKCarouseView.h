//
//  OKCarouseView.h
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

/**
 Scroll Style
 
 - OKCarouselViewScrollStylePositive:
 if scrollDirection == Vetical style is bottom to top
 if scrollDirection == Horizontal style is right to left
 
 - OKCarouselViewScrollStyleOpposite:
 if scrollDirection == Vetical style is top to bottom
 if scrollDirection == Horizontal style is left to right
 */
typedef NS_ENUM(NSInteger, OKCarouselViewScrollStyle) {
    OKCarouselViewScrollStylePositive,
    OKCarouselViewScrollStyleOpposite
};

@protocol OKCarouselViewDataSource <UICollectionViewDataSource>
@required
- (NSInteger)numberOfItemsInCarouseView:(OKCarouselView *)carouseView;

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)carouselView:(OKCarouselView *)carouselView
                             cellForItemAtIndex:(NSInteger)index;

@end

@protocol OKCarouselViewDelegate <UICollectionViewDelegate>
@optional

- (void)carouselCollectionView:(OKCarouselView *)carouselCollectionView didScrollAtIndexPath:(NSIndexPath *)indexPath;

- (void)carouselCollectionView:(OKCarouselView *)carouselCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface OKCarouselView : UIView

@property (nonatomic, weak, nullable) id <OKCarouselViewDelegate> delegate;
@property (nonatomic, weak, nullable) id <OKCarouselViewDataSource> dataSource;

@property (nonatomic, assign) OKCarouselViewScrollDirection scrollDirection; // default is OKCarouselViewScrollDirectionVertical

@property (nonatomic, assign) OKCarouselViewScrollStyle scrollStyle;

@property (nonatomic, assign, getter=isAutoRotation) BOOL autoRotation;

@property (nonatomic, assign) CGFloat ratationTimeInterval;

@property (nonatomic, copy) NSRunLoopMode runloopMode;

- (void)startRotation;
- (void)stopRotation;

@end

NS_ASSUME_NONNULL_END

