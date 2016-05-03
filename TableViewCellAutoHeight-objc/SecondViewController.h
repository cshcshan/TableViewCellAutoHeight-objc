//
//  SecondViewController.h
//  TableViewCellAutoHeight-objc
//
//  Created by Han Chen on 2016/2/4.
//  Copyright © 2016年 Han Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
