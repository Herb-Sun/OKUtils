//
//  TestTableViewCell.h
//  OKUtils
//
//  Created by MAC on 2017/10/26.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKCarouselView.h"

@interface TestTableViewCell : UITableViewCell<OKCarouselViewDataSource, OKCarouselViewDelegate>
@property (weak, nonatomic) IBOutlet OKCarouselView *carouselView;
@property (nonatomic, strong) NSArray *dataSource;

@end
