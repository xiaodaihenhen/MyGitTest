//
//  FirstViewController.h
//  TestStoryBoard
//
//  Created by 力国 赵 on 14-7-30.
//  Copyright (c) 2014年 力国 赵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface FirstViewController : BaseViewController<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataArray;
    NSDictionary *dicCity;
    NSMutableArray *bigarray;
    
    NSMutableArray *numbercell;
    
    NSMutableArray *searchAarray;
    
    NSInteger *indexpatha;
    
    NSMutableArray *searchResults;
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDisplayController;
    UITableView *_tableView;

    
//    __weak IBOutlet UITableView *_tableView;

}

@end
