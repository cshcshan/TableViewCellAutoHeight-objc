//
//  ThreeColumnTableViewCell.m
//  TableViewCellAutoHeight-objc
//
//  Created by Han Chen on 2016/2/4.
//  Copyright © 2016年 Han Chen. All rights reserved.
//

#import "ThreeColumnTableViewCell.h"

@implementation ThreeColumnTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self initUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initUI {
    self.noLabel.numberOfLines = 0;
    self.noLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.itemLabel.numberOfLines = 0;
    self.itemLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.noteLabel.numberOfLines = 0;
    self.noteLabel.lineBreakMode = NSLineBreakByCharWrapping;
}

@end
