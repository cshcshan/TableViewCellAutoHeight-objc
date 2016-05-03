//
//  PdfTableViewCell.m
//  TableViewCellAutoHeight-objc
//
//  Created by Han Chen on 2015/10/25.
//  Copyright © 2015年 Han Chen. All rights reserved.
//

#import "PdfTableViewCell.h"

@implementation PdfTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self initUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initUI {
    [self.itemLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.itemLabel setNumberOfLines:0];
    [self.noteLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.noteLabel setNumberOfLines:0];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    [self.itemLabelWidthConstraint setConstant:CGRectGetWidth(self.contentView.frame) * 0.75 - 10];
    [self.itemLabel setPreferredMaxLayoutWidth:CGRectGetWidth(self.itemLabel.frame)];
    
    [self.noteLabel setPreferredMaxLayoutWidth:CGRectGetWidth(self.noteLabel.frame)];
    [self.noteLabelWidthConstraint setConstant:CGRectGetWidth(self.contentView.frame) * 0.25 - 10];
}

@end
