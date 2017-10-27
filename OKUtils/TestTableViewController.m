//
//  TestTableViewController.m
//  OKUtils
//
//  Created by MAC on 2017/10/26.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "TestTableViewController.h"
#import "TestTableViewCell.h"

@interface TestTableViewController ()

@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:@"TestTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([TestTableViewCell class])];
//    [self.tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TestTableViewCell class])];
    self.tableView.rowHeight = 100;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TestTableViewCell class]) forIndexPath:indexPath];
    if (indexPath.row % 2 == 0) {
        cell.carouselView.scrollStyle = OKCarouselViewScrollStyleOpposite;
    } else {
        cell.carouselView.scrollStyle = OKCarouselViewScrollStylePositive;
    }
    
    if (indexPath.row % 3 == 0) {
        cell.carouselView.scrollDirection = OKCarouselViewScrollDirectionHorizontal;
    } else {
        cell.carouselView.scrollDirection = OKCarouselViewScrollDirectionVertical;
    }
    return cell;
}


- (void)dealloc {
    NSLog(@"----");
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
