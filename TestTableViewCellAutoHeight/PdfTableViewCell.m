//
//  PdfTableViewCell.m
//  TestTableViewCellAutoHeight
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
    // 設定Label自動換行，且行數設為0即不限制行數
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

#pragma mark - note

/*
 layoutSubviews補充: 在下面的情況下會被呼叫
 1. init初始化不會呼叫layoutSubviews
    但是用initWithFrame初始化時，如果rect值不是CGRectZero就會呼叫
 2. addSubview會呼叫
 3. 設定view的frame，且frame前後有發生變化時會呼叫
 4. 滾動UIScrollView時呼叫
 5. 旋轉Screen時會觸發父UIView的layoutSubviews事件
 6. 改變一個UIView大小時會觸發父UIView的layoutSubviews事件
 */

@end
