//
//  ThreeColumnTableViewCell.h
//  TableViewCellAutoHeight-objc
//
//  Created by Han Chen on 2016/2/4.
//  Copyright © 2016年 Han Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeColumnTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *noLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;

@end
