//
//  ForeViewController.m
//  TestStoryBoard
//
//  Created by 力国 赵 on 14-7-30.
//  Copyright (c) 2014年 力国 赵. All rights reserved.
//

#import "ForeViewController.h"
//#import <SDImageCache.h>
//#import <UIImageView+WebCache.h>

#import "SDImageCache.h"
#import "UIImageView+WebCache.h"



@interface ForeViewController ()

@end

@implementation ForeViewController

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
    _image = [[UIImageView alloc] init];
    _image.frame = CGRectMake(20, 100, 200, 200);
    _image.backgroundColor = [UIColor redColor];
    NSString *url = @"http://img3.126.net/movie/product/stills/136858231023410045_160_160.jpg";
    [_image setImageWithURL:[NSURL URLWithString:url]];

    [self.view addSubview:_image];
    
}



- (IBAction)changeimageaction:(id)sender {
    
    //  测试动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0];
     [UIView setAnimationDelegate:self];
    
//    [UIView animateWithDuration:3.0 animations:^{
//        
//        [self _initimagechang];
//    }];
    
    [UIView animateWithDuration:3.0 delay:0 options:UIViewAnimationOptionTransitionNone     animations:^{
        _image.frame = CGRectMake(20, 220, 200, 200);
        _image.alpha = 0.8;
    } completion:^(BOOL finished) {
        
        
        [self _initimagechang];
        
        
    }];

    [UIView commitAnimations];
    
    NSArray *array = @[@"zhangsan",@"李四",@"asqwesadv",@"1243",@"45678"];
    NSString *string = [[array valueForKey:@"description"] componentsJoinedByString:@","];
    NSLog(@"============%@============",string);
    
    array = [string componentsSeparatedByString:@","];
    NSLog(@"============%@============",array);

    
    
}




-(void)_initimagechang
{

    
    //  测试动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView setAnimationDelegate:self];
    
    //    [UIView animateWithDuration:3.0 animations:^{
    //
    //        [self _initimagechang];
    //    }];
    
    [UIView animateWithDuration:3.0 delay:0 options:UIViewAnimationOptionTransitionNone     animations:^{
        _image.frame = CGRectMake(20, 100, 200, 200);
        _image.alpha = 0.3;
    } completion:^(BOOL finished) {
        
        
        [self changeimageaction:self];
        
    }];
    

    [UIView commitAnimations];
}





@end
