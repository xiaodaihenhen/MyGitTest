//
//  ViewController.h
//  Search
//
//  Created by LYZ on 14-1-24.
//  Copyright (c) 2014年 LYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate> {
    NSArray *dataArray;
    NSDictionary *dicCity;
    NSMutableArray *bigarray;
    
    NSMutableArray *searchAarray;
    
    NSMutableArray *numbercell;
    
    NSMutableArray *searchResults;
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDisplayController;
    
    
    __weak IBOutlet UITableView *_tableView;

}


@end
