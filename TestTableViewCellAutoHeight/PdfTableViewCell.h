//
//  PdfTableViewCell.h
//  TestTableViewCellAutoHeight
//
//  Created by Han Chen on 2015/10/25.
//  Copyright © 2015年 Han Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PdfTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *itemLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noteLabelWidthConstraint;

@end
