//
//  OKShareItem.h
//  OKUtils
//
//  Created by MAC on 2017/9/11.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


#if UIKIT_STRING_ENUMS
typedef NSString * OKShareType NS_EXTENSIBLE_STRING_ENUM;
#else
typedef NSString * OKShareType;
#endif

UIKIT_EXTERN OKShareType const OKShareTypePostToFacebook;
UIKIT_EXTERN OKShareType const OKShareTypePostToTwitter;
UIKIT_EXTERN OKShareType const OKShareTypePostToWeibo;
UIKIT_EXTERN OKShareType const OKShareTypeMessage;
UIKIT_EXTERN OKShareType const OKShareTypeMail;
UIKIT_EXTERN OKShareType const OKShareTypePrint;
UIKIT_EXTERN OKShareType const OKShareTypeCopyToPasteboard;
UIKIT_EXTERN OKShareType const OKShareTypeAssignToContact;
UIKIT_EXTERN OKShareType const OKShareTypeSaveToCameraRoll;
UIKIT_EXTERN OKShareType const OKShareTypeAddToReadingList;
UIKIT_EXTERN OKShareType const OKShareTypePostToFlickr;
UIKIT_EXTERN OKShareType const OKShareTypePostToVimeo;
UIKIT_EXTERN OKShareType const OKShareTypePostToTencentWeibo;
UIKIT_EXTERN OKShareType const OKShareTypeAirDrop;
UIKIT_EXTERN OKShareType const OKShareTypeOpenInIBooks;


@interface OKShareItem : NSObject

@property (nonatomic, copy) NSString *itemTitle;
@property (nonatomic, strong) UIImage *itemImage;
@property (nonatomic, copy) OKShareType shareType;

@end

NS_ASSUME_NONNULL_END
