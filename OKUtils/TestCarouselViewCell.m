//
//  TestCarouselViewCell.m
//  OKUtils
//
//  Created by herb on 2017/10/24.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "TestCarouselViewCell.h"

@implementation TestCarouselViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.bounds;
}

@end
