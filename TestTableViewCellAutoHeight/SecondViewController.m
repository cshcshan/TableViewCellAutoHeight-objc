//
//  SecondViewController.m
//  TestTableViewCellAutoHeight
//
//  Created by Han Chen on 2016/2/4.
//  Copyright © 2016年 Han Chen. All rights reserved.
//

#import "SecondViewController.h"
#import "ThreeColumnTableViewCell.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
{
    NSArray *dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)initData {
    NSString *itemString = @"";
    NSString *noteString = @"";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:@[@"編號", @"項目", @"備註"]];
    [array addObject:@[@"1", @"ABCDEGFHIJKLMNOPQRSTUVWXYZ", @"0123456789"]];
    [array addObject:@[@"2", @"abcdefghijklmnopqrstuvwxyz", @"9876543210"]];
    [array addObject:@[@"3", @"ABCDEGFHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", @"9876543210"]];
    [array addObject:@[@"4", @"ABCDEGFHIJKLMNOPQRSTUVWXYZ", @"0123456789876543210"]];
    [array addObject:@[@"5", @"ABCDEGFHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", @"0123456789876543210"]];
    [array addObject:@[@"6", @"ABCDEGFHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEGFHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", @"0123456789876543210"]];
    [array addObject:@[@"", @"", @""]];
    for (int i = 0; i < 10; i++) {
        itemString = [itemString stringByAppendingString:[NSString stringWithFormat:@"%d\n", i]];
        noteString = [noteString stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
        [array addObject:@[[NSString stringWithFormat:@"%d", (int)array.count], itemString, noteString]];
    }
    [array addObject:@[@"", @"", @""]];
    [array addObject:@[[NSString stringWithFormat:@"%d", (int)array.count], @"0123456789", @"ABCDEGFHIJKLMNOPQRSTUVWXYZ"]];
    dataArray = array;
}

-(void)initUI {
    NSString *nibName = NSStringFromClass([ThreeColumnTableViewCell class]);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ThreeColumnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThreeColumnTableViewCell"];
    cell = [self getThreeColumnTableViewCellWithCell:cell indexPath:indexPath];
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ThreeColumnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThreeColumnTableViewCell" forIndexPath:indexPath];
    cell = [self getThreeColumnTableViewCellWithCell:cell indexPath:indexPath];
    return cell;
}

-(ThreeColumnTableViewCell *)getThreeColumnTableViewCellWithCell:(ThreeColumnTableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    cell.noLabel.text = dataArray[indexPath.row][0];
    cell.itemLabel.text = dataArray[indexPath.row][1];
    cell.noteLabel.text = dataArray[indexPath.row][2];
    
    cell.noLabel.backgroundColor = [UIColor clearColor];
    cell.itemLabel.backgroundColor = [UIColor clearColor];
    cell.noteLabel.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark UITableViewDelegate

@end
