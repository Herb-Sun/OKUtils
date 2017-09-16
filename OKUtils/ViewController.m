//
//  ViewController.m
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "ViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <YYKit.h>
#import "OKShareViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:nil applicationActivities:nil];
#warning hahahh
    vc.completionHandler = ^(UIActivityType  _Nullable activityType, BOOL completed) {
        
    };
    
//    UIAlertController
    
}
-(NSString *)currentRadioAccessTechnology
{
    CTTelephonyNetworkInfo *current = [[CTTelephonyNetworkInfo alloc] init];
    return current.currentRadioAccessTechnology;
}

-(NSMutableDictionary *)subscriberCellularProvider
{
    NSMutableDictionary *arr = [[NSMutableDictionary alloc]init];
    CTTelephonyNetworkInfo *current = [[CTTelephonyNetworkInfo alloc] init];
    [arr setObject:current.subscriberCellularProvider.carrierName forKey:@"carrierName"];
    [arr setObject:current.subscriberCellularProvider.mobileCountryCode forKey:@"mobileCountryCode"];
    [arr setObject:current.subscriberCellularProvider.mobileNetworkCode forKey:@"mobileNetworkCode"];
    [arr setObject:current.subscriberCellularProvider.isoCountryCode forKey:@"isoCountryCode"];
    [arr setObject:[NSNumber numberWithBool:current.subscriberCellularProvider.allowsVOIP] forKey:@"allowsVOIP"];
    return arr;
    

}

- (IBAction)Present:(id)sender {
    
    OKShareViewController *shareVc = [[OKShareViewController alloc] init];
    [self presentViewController:shareVc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
