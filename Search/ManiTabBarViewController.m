//
//  ManiTabBarViewController.m
//  TestStoryBoard
//
//  Created by 力国 赵 on 14-7-30.
//  Copyright (c) 2014年 力国 赵. All rights reserved.
//

#import "ManiTabBarViewController.h"

@interface ManiTabBarViewController ()

@end

@implementation ManiTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate
{
    UINavigationController *vc = (UINavigationController *)self.selectedViewController;
    
    if ([vc isEqual: [self.viewControllers objectAtIndex:2]]) {
        
        return YES;
    }
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    UINavigationController *vc = (UINavigationController *)self.selectedViewController;
    
    if ([vc isEqual: [self.viewControllers objectAtIndex:2]]) {
        
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    
    return UIInterfaceOrientationMaskPortrait;
}





@end
