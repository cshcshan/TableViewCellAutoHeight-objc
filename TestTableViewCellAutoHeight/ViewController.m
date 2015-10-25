//
//  ViewController.m
//  TestTableViewCellAutoHeight
//
//  Created by Han Chen on 2015/10/23.
//  Copyright © 2015年 Han Chen. All rights reserved.
//

#import "ViewController.h"
#import "AutoSizeTableViewCell.h"
#import "PdfTableViewCell.h"

@interface ViewController ()
{
    CGSize PDFA4;
    
    // Switch
    UIView *topView;
    UIView *switchLabelView;
    UIButton *oneColumnSwitchButton;
    UIButton *twoColumnSwitchButton;
    
    // One Column
    UIView *oneColumnScrollView;
    UITableView *oneColumnTableView;
    NSMutableArray *oneColumnArray;
    
    // Two Column
    UIScrollView *twoColumnScrollView;
    UITableView *twoColumnTableView;
    NSMutableArray *twoColumnArray;
}
@end

@implementation ViewController

const int ONE_COLUMN_SCROLL_VIEW_TAG = 1000;
const int TWO_COLUMN_SCROLL_VIEW_TAG = 2000;

const int TOP_VIEW_HEIGHT = 40;
const int TABLE_VIEW_HEADER_HEIGHT = 80;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PDFA4 = CGSizeMake(612, 792);
    
    [self getArray];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initial UI

-(void)initUI {
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    
    // Top View - Switch Button
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(statusBarFrame), CGRectGetWidth(self.view.frame), TOP_VIEW_HEIGHT)];
    [self.view addSubview:topView];
    
    switchLabelView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.view.frame) * 0.5 - 10 * 2, TOP_VIEW_HEIGHT)];
    [switchLabelView setBackgroundColor:[UIColor orangeColor]];
    [topView addSubview:switchLabelView];
    
    // Top View - Switch Button - One Column
    oneColumnSwitchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame) * 0.5, TOP_VIEW_HEIGHT)];
    [oneColumnSwitchButton setTitle:@"One Column" forState:UIControlStateNormal];
    [oneColumnSwitchButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [oneColumnSwitchButton addTarget:self action:@selector(switchButton:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:oneColumnSwitchButton];
    
    // Top View - Switch Button - Two Column
    twoColumnSwitchButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) * 0.5, 0,
                                                                       CGRectGetWidth(self.view.frame) * 0.5, TOP_VIEW_HEIGHT)];
    [twoColumnSwitchButton setTitle:@"Two Columns" forState:UIControlStateNormal];
    [twoColumnSwitchButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [twoColumnSwitchButton addTarget:self action:@selector(switchButton:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:twoColumnSwitchButton];
    
    // Scroll View - TableView - One Column
    oneColumnScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame),
                                                                         CGRectGetWidth(self.view.frame),
                                                                         CGRectGetHeight(self.view.frame) - CGRectGetMaxY(topView.frame))];
    [oneColumnScrollView setTag:ONE_COLUMN_SCROLL_VIEW_TAG];
    oneColumnTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,
                                                                       CGRectGetWidth(oneColumnScrollView.frame),
                                                                       CGRectGetHeight(oneColumnScrollView.frame))];
    [oneColumnTableView setDataSource:self];
    [oneColumnTableView setDelegate:self];
    [oneColumnScrollView addSubview:oneColumnTableView];
    
    // Scroll View - TableView - Two Column
    twoColumnScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame),
                                                                         CGRectGetWidth(self.view.frame),
                                                                         CGRectGetHeight(self.view.frame) - CGRectGetMaxY(topView.frame))];
    [twoColumnScrollView setTag:TWO_COLUMN_SCROLL_VIEW_TAG];
    twoColumnTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,
                                                                       CGRectGetWidth(twoColumnScrollView.frame),
                                                                       CGRectGetHeight(twoColumnScrollView.frame))];
    [twoColumnTableView setDataSource:self];
    [twoColumnTableView setDelegate:self];
    [twoColumnScrollView addSubview:twoColumnTableView];
    
    [self.view addSubview:oneColumnScrollView];
    [self.view addSubview:twoColumnScrollView];
}

-(IBAction)switchButton:(UIButton *)sender {
    CGRect switchLabelViewFrame = [switchLabelView frame];
    
    __block CGRect twoColumnScrollViewFrame = twoColumnScrollView.frame;
    void (^showOneColumnBlock)(void) = ^{
        twoColumnScrollViewFrame.origin.y = CGRectGetHeight(self.view.frame);
        twoColumnScrollView.frame = twoColumnScrollViewFrame;
    };
    void (^showTwoColumnBlock)(void) = ^{
        twoColumnScrollViewFrame.origin.y = CGRectGetMaxY(topView.frame);
        twoColumnScrollView.frame = twoColumnScrollViewFrame;
    };
    
    if ([sender isEqual:oneColumnSwitchButton]) {
        switchLabelViewFrame.origin.x = 10;
        /*
        [[self.view viewWithTag:TWO_COLUMN_SCROLL_VIEW_TAG] removeFromSuperview];
        [self.view addSubview:oneColumnScrollView];
         */
        [UIView animateWithDuration:0.7 delay:0.0 options:UIViewAnimationOptionCurveEaseIn
                         animations:showOneColumnBlock completion:nil];
    } else if ([sender isEqual:twoColumnSwitchButton]) {
        switchLabelViewFrame.origin.x = CGRectGetWidth(self.view.frame) * 0.5 + 10;
        /*
        [[self.view viewWithTag:ONE_COLUMN_SCROLL_VIEW_TAG] removeFromSuperview];
        [self.view addSubview:twoColumnScrollView];
         */
        [UIView animateWithDuration:0.7 delay:0.0 options:UIViewAnimationOptionCurveEaseIn
                         animations:showTwoColumnBlock completion:nil];
    }
    
    [UIView animateWithDuration:0.8 animations:^{
        [switchLabelView setFrame:switchLabelViewFrame];
    }];
}

-(void)getArray {
    oneColumnArray = [[NSMutableArray alloc] init];
    [oneColumnArray addObject:@"ABCDEGFHIJKLMNOPQRSTUVWXYZ0123456789"];
    [oneColumnArray addObject:@"ABCDEGFHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz9876543210"];
    [oneColumnArray addObject:@"ABCDEGFHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz9876543210ABCDEGFHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz9876543210"];
    
    twoColumnArray = [[NSMutableArray alloc] init];
    NSString *itemString = @"";
    NSString *noteString = @"";
    [twoColumnArray addObject:@[@"ABCDEGFHIJKLMNOPQRSTUVWXYZ", @"0123456789"]];
    [twoColumnArray addObject:@[@"abcdefghijklmnopqrstuvwxyz", @"9876543210"]];
    [twoColumnArray addObject:@[@"ABCDEGFHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", @"9876543210"]];
    [twoColumnArray addObject:@[@"ABCDEGFHIJKLMNOPQRSTUVWXYZ", @"0123456789876543210"]];
    [twoColumnArray addObject:@[@"ABCDEGFHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", @"0123456789876543210"]];
    [twoColumnArray addObject:@[@"ABCDEGFHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEGFHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", @"0123456789876543210"]];
    [twoColumnArray addObject:@[@"", @""]];
    for (int i = 0; i < 10; i++) {
        itemString = [itemString stringByAppendingString:[NSString stringWithFormat:@"%d\n", i]];
        noteString = [noteString stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
        [twoColumnArray addObject:@[itemString, noteString]];
    }
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number = 1;
    if ([tableView isEqual:oneColumnTableView]) {
        number = [oneColumnArray count];
    } else if ([tableView isEqual:twoColumnTableView]) {
        number = [twoColumnArray count];
    }
    return number;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:oneColumnTableView]) {
        // Create a reusable cell
        AutoSizeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AutoSizeCell"];
        if (cell == nil) {
            cell = [[AutoSizeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AutoSizeCell"];
        }
        
        // Configure the cell for this indexPath
        cell.textLabel.text = [oneColumnArray objectAtIndex:indexPath.row];
        
        return cell;
    } else if ([tableView isEqual:twoColumnTableView]) {
        PdfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PdfCell"];
        if (cell == nil) {
            //cell = [[PdfTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PdfCell"];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PdfTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        [cell.itemLabel setText:[[twoColumnArray objectAtIndex:indexPath.row] objectAtIndex:0]];
        [cell.noteLabel setText:[[twoColumnArray objectAtIndex:indexPath.row] objectAtIndex:1]];
        [cell setFrame:CGRectMake(0, 0, CGRectGetWidth(twoColumnTableView.frame), CGRectGetHeight(cell.frame))];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] init];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:oneColumnTableView]) {
        //AutoSizeTableViewCell *cell = [[AutoSizeTableViewCell alloc] init];
        //AutoSizeTableViewCell *cell = (AutoSizeTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        AutoSizeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AutoSizeCell"];
        if (cell == nil) {
            cell = (AutoSizeTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        }
        cell.textLabel.text = [oneColumnArray objectAtIndex:indexPath.row];
        
        // Do the layout pass on the cell, which will calculate the frames for all the views
        // based on the constraints
        // (Note that the preferredMaxLayoutWidth is set on multi-line UILabels inside the -[layoutSubviews] method
        // in the UITableViewCell subclass)
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        // Get the actual height required for the cell
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        // Add an extra point to the height to account for the cell separator,
        // which is added between the bottom of the cell's contentView and the bottom of the table view cell.
        height += 1;
        return height;
    } else if ([tableView isEqual:twoColumnTableView]) {
        PdfTableViewCell *cell = (PdfTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        [cell setNeedsLayout];
        [cell layoutIfNeeded]; // Layout the cell
        
        CGFloat height = CGRectGetHeight(cell.frame);
        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        if (size.height + 1 > height) {
            height = size.height + 1;
        }
        return height;
    } else {
        return 45;
    }
}

// header
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return TABLE_VIEW_HEADER_HEIGHT;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 80)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleView.frame];
    if ([tableView isEqual:oneColumnTableView]) {
        [titleLabel setText:@"One Column"];
    } else if ([tableView isEqual:twoColumnTableView]) {
        [titleLabel setText:@"Two Columns"];
    }
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor orangeColor]];
    [titleView addSubview:titleLabel];
    return titleView;
}

@end
