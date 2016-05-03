//
//  AutoSizeTableViewCell.m
//  TableViewCellAutoHeight-objc
//
//  Created by Han Chen on 2015/10/23.
//  Copyright © 2015年 Han Chen. All rights reserved.
//

#import "AutoSizeTableViewCell.h"

@implementation AutoSizeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLabel.numberOfLines = 0;
        
        // Layout constraints
        self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-6-[bodyLabel]-6-|" options:0 metrics:nil views:@{ @"bodyLabel": self.textLabel }]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[bodyLabel]-6-|" options:0 metrics:nil views:@{ @"bodyLabel": self.textLabel }]];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // Make sure the contentViw does a layout pass hero so that its subviews have their frames set,
    // which we need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // Set the preferredMaxLayoutWidth of the multi-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    [self.textLabel setPreferredMaxLayoutWidth:CGRectGetWidth(self.textLabel.frame)];
}
@end
