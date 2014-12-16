//
//  ViewController.m
//  Search
//
//  Created by LYZ on 14-1-24.
//  Copyright (c) 2014年 LYZ. All rights reserved.
//

#import "ViewController.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "PushView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    dataArray = [[NSMutableArray alloc] init];
    bigarray = [[NSMutableArray alloc] init];
    dicCity = [[NSDictionary alloc] init];
    searchAarray = [[NSMutableArray alloc] init];
    
    
    self.title = @"SearchDemo";
    
    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"搜索列表"];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    

    _tableView.dataSource = self;
    _tableView.delegate = self;
	_tableView.tableHeaderView = mySearchBar;
//    dataArray = [@[@"百度",@"六六",@"谷歌",@"苹果",@"and",@"table",@"view",@"and",@"and",@"苹果IOS",@"谷歌android",@"微软",@"微软WP",@"table",@"table",@"table",@"六六",@"六六",@"六六",@"table",@"table",@"table"]mutableCopy];
   
//    本地获取 数据  并 给要现实的 大数组。
    NSString *filepath  = [[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
    
//    字典接收 数据
    dicCity = [[NSDictionary alloc] initWithContentsOfFile:filepath];
    
    
    dataArray = [dicCity allKeys];
    dataArray = [dataArray sortedArrayUsingSelector:@selector(compare:)];
//    dataArray = (NSMutableArray *)[[dataArray reverseObjectEnumerator] allObjects];
    
//    循环便利字典  用数组  接收数据
    for ( int i = 0 ; i < dataArray.count; i++) {
        
        NSArray *marray = [dicCity objectForKey:dataArray[i]];
    
        [searchAarray addObjectsFromArray:marray];
//    把每一个 数据给  大数组
        [bigarray addObject:marray];
       
    }
}


#pragma UITableViewDataSource

#warning   根据数据类型  定义  分组的 表示图
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    }
    return dataArray.count;
}


#warning  每一组的 头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    lable.backgroundColor = [UIColor grayColor];
    lable.text = dataArray[section];

    return lable;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{

    return 45;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return dataArray;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return searchResults.count;
    }
    else {
        NSArray *marray = [dicCity objectForKey:dataArray[section]];
         return marray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = searchResults[indexPath.row];
        
    }
    else {
        
#warning   修改了  显示数据
        NSArray *arrayi = bigarray[indexPath.section];
        if (arrayi != 00) {
            cell.textLabel.text = arrayi[indexPath.row];

        }
    }
//    cell.accessoryType = UITableViewCellEditingStyleDelete;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PushView *pv = [[PushView alloc]initWithNibName:@"PushView" bundle:nil];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        pv.nStr = searchResults[indexPath.row];
    }
    else {
        NSArray *arrayi = bigarray[indexPath.section];
        pv.nStr = arrayi[indexPath.row];
    }
    [self.navigationController pushViewController:pv animated:YES];
   
    
    
    [mySearchBar resignFirstResponder];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Message" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"message" otherButtonTitles:nil , nil];

      [actionSheet showInView:self.view];

}

#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchResults = [[NSMutableArray alloc]init];

    
    
    if (mySearchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:mySearchBar.text]) {
#warning   修改了  查找的数据范围
        for (int i=0; i<dataArray.count; i++) {
            if ([ChineseInclude isIncludeChineseInString:dataArray[i]]) {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:dataArray[i]];
                NSRange titleResult=[tempPinYinStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:dataArray[i]];
                    
#warning   修改了 每输入一个字  查找一次  刷新标示图  类似电话本效果
                    [_tableView reloadData];
                }
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:dataArray[i]];
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleHeadResult.length>0) {
                    [searchResults addObject:dataArray[i]];
                    
#warning   修改了 每输入一个字  查找一次  刷新标示图  类似电话本效果
                    [_tableView reloadData];

                    
                }
            }
            else {
                NSRange titleResult=[dataArray[i] rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:dataArray[i]];
                    
#warning   修改了 每输入一个字  查找一次  刷新标示图  类似电话本效果
                    [_tableView reloadData];

                }
            }
        }
    } else if (mySearchBar.text.length>0&&[ChineseInclude isIncludeChineseInString:mySearchBar.text]) {
        
#warning   修改了  查找的数据范围
        for (NSString *tempStr in searchAarray) {
            NSRange titleResult=[tempStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [searchResults addObject:tempStr];
            }
        }
    }
    
}


//  给 cell 添加 加载动画渐显渐隐

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.frame = CGRectMake(-320, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    } completion:^(BOOL finished) {
        ;
    }];
}




-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}




-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [bigarray removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
    }
}
@end
