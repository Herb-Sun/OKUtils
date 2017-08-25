//
//  OKUtils_UIImage.h
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/// 图片滤镜类型
typedef NS_ENUM (NSInteger, OKImageEffectStyle) {
    OKImageEffectStyleNone = 0,  //!< 无处理
    OKImageEffectStyleInstant,   //!< 怀旧
    OKImageEffectStyleNoir,      //!< 黑白
    OKImageEffectStyleTonal,     //!< 色调
    OKImageEffectStyleTransfer,  //!< 岁月
    OKImageEffectStyleMono,      //!< 单色
    OKImageEffectStyleFade,      //!< 褪色
    OKImageEffectStyleProcess,   //!< 冲印
    OKImageEffectStyleChrome     //!< 铬黄
};

/// 图片模糊处理类型
typedef NS_ENUM (NSInteger, OKImageBlurStyle) {
    OKImageBlurStyleNone = 0, //!< 无处理
    OKImageBlurStyleGaussian, //!< 高斯模糊
    OKImageBlurStyleBox NS_ENUM_AVAILABLE_IOS(9_0),      //!< 均值模糊
    OKImageBlurStyleDisc NS_ENUM_AVAILABLE_IOS(9_0),     //!< 环形卷积模糊
    OKImageBlurStyleMedian NS_ENUM_AVAILABLE_IOS(9_0),   //!< 中值模糊, 用于消除图像噪点, 无需设置radius
    OKImageBlurStyleMotion NS_ENUM_AVAILABLE_IOS(9_0)    //!< 运动模糊, 用于模拟相机移动拍摄时的扫尾效果
};

/// 颜色转图片
UIKIT_EXTERN UIImage *OKImageByColor(UIColor *color);

/// 截屏
UIKIT_EXTERN UIImage *OKImageByScreenShot(void);
UIKIT_EXTERN UIImage *OKImageByScreenShotWithoutStatusBar(void);

/// view to image
UIKIT_EXTERN UIImage *OKImageByView(UIView *theView);
UIKIT_EXTERN UIImage *OKImageByViewAtFrame(UIView *theView, CGRect atFrame);

/// 拉伸图片
UIKIT_EXTERN UIImage *OKImagByStretchable(UIImage *theImage);
UIKIT_EXTERN UIImage *OKImageByStretchableScale(UIImage *theImage, CGFloat leftCap, CGFloat topCap);

/// 裁切成圆形图片(避免使用cornerRadius防止卡顿)
UIKIT_EXTERN UIImage *OKImageByCircled(UIImage *theImage);
/// 裁切图片
UIKIT_EXTERN UIImage *OKImageBySlice(UIImage *theImage, CGRect rect);
/// 缩小图片到指定尺寸
UIKIT_EXTERN UIImage *OKImageByScaled(UIImage *theImage, CGSize size);

/// 修正图片方向
UIKIT_EXTERN UIImage *OKImageFixOrientation(UIImage *theImage);
/// 垂直反转图片
UIKIT_EXTERN UIImage *OKImageFlipVertical(UIImage *theImage);
/// 水平反转图片
UIKIT_EXTERN UIImage *OKImageFlipHorizontal(UIImage *theImage);

/**
 旋转图片

 @param theImage theImage
 @param degrees 角度
 @return new image
 */
UIKIT_EXTERN UIImage *OKImageRotatedByDegrees(UIImage *theImage, CGFloat degrees);

/**
 旋转图片

 @param theImage theImage
 @param radians 弧度
 @return new image
 */
UIKIT_EXTERN UIImage *OKImageRotatedByRadians(UIImage *theImage, CGFloat radians);

/**
 图片模糊处理

 @param theImage theImage
 @param radio 比率 0.0 ~ 1.0
 @return new image
 */
UIKIT_EXTERN UIImage *OKImageByBlurred(UIImage *theImage, CGFloat radio);

/**
 图片模糊处理可选style

 @param theImage theImage
 @param blurStyle blurStyle
 @param radio 比率 0.0 ~ 1.0
 @return new image
 */
UIKIT_EXTERN UIImage *OKImageByBlurredStyle(UIImage *theImage, OKImageBlurStyle blurStyle, CGFloat radio);

/**
 对图片进行滤镜处理

 @param theImage theImage
 @param effectStyle 滤镜类型
 @return new image
 */
UIKIT_EXTERN UIImage *OKImageByEffectted(UIImage *theImage, OKImageEffectStyle effectStyle);

/**
 调整图片饱和度, 亮度, 对比度

 @param theImage theImage
 @param saturation 饱和度
 @param brightness 亮度 0.0 ~ 1.0
 @param contrast 对比度
 @return new image
 */
UIKIT_EXTERN UIImage *OKImageBySaturated(UIImage *theImage, CGFloat saturation, CGFloat brightness, CGFloat contrast);

/// 转化图片为灰度图
UIKIT_EXTERN UIImage *OKImageByConvertGray(UIImage *theImage);

/// 合并图片
UIKIT_EXTERN UIImage *OKImageByMerged(UIImage *firstImage, UIImage *secondImage);
