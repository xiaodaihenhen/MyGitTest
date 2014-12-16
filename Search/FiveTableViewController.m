//
//  FiveTableViewController.m
//  TestStoryBoard
//
//  Created by 力国 赵 on 14-7-30.
//  Copyright (c) 2014年 力国 赵. All rights reserved.
//

#import "FiveTableViewController.h"

#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "MyStatic.h"
#import "MYimage.h"

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define KEY_PREV @"prev.valid.time"   //储存点击信息按钮时 的时间

@interface FiveTableViewController ()

@end

@implementation FiveTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

//    [self.tableView setEditing:YES animated:YES];
//    _array = [[NSMutableArray alloc] init];
//    
//    _array = @[@"111",@"222",@"3333",@"444",@"555",@"666",@"777",@"888",@"999",@"000"];
    
    NSArray *array = [USER_DEFAULT objectForKey:KEY_PREV];
    
    if (array.count != 0)
    {
        _city = array;
        }else{
        [self cityWeather];
    }
    
    self.tableView.rowHeight =  60 ;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSMutableArray *)cityWeather
{
    NSLog(@"%@",self.city);
    if (self.city == nil){
    self.city = [[NSMutableArray alloc] initWithObjects:@"北京",@"上海",@"广州",@"深圳",@"重庆",@"厦门",@"香港",@"福州",@"郑州",@"西安",@"成都",nil];
    }
    
    return _city;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _city.count;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete ) {
        [self.city removeObjectAtIndex:indexPath.row];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
        [USER_DEFAULT setObject:self.city forKey:KEY_PREV];
        [self.tableView reloadData];
    }
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (sourceIndexPath != destinationIndexPath) {
        id object = [self.city objectAtIndex:sourceIndexPath.row];
        [self.city removeObjectAtIndex:sourceIndexPath.row];
        
        if (destinationIndexPath.row > [self.city count]) {
            [self.city addObject:object];
        }
        else {
            [self.city insertObject:object atIndex:destinationIndexPath.row];
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellid";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *aString = self.city[indexPath.row + 1];
    cell.textLabel.text = aString;
//    cell.detailTextLabel.text = [self.temperature objectForKey:aString];
//    
//    UIImage *image = [MYimage thumbnailWithImage:[UIImage imageNamed:@"2.jpg"] size:CGSizeMake(100, 100)];
//    
//    NSLog(@"image.size.height: %f  image.size.width%f",image.size.height,image.size.width);
    NSBundle *mainNundel = [NSBundle mainBundle];
    NSString *filePath = [mainNundel pathForResource:@"3.213" ofType:@"jpeg"];
    
    cell.imageView.image = [UIImage imageWithContentsOfFile:filePath];
    return cell;
}

@end
