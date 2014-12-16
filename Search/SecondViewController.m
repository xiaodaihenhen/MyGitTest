
//
//  SecondViewController.m
//  TestStoryBoard
//
//  Created by 力国 赵 on 14-7-30.
//  Copyright (c) 2014年 力国 赵. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(log:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)log:(NSNotification *)noti
{
    NSLog(@"+++%d",[[noti object] orientation]);
}


////5.0一下
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIDeviceOrientationLandscapeLeft) ||(toInterfaceOrientation == UIDeviceOrientationLandscapeRight);
    //    return  UIDeviceOrientationIsLandscape(toInterfaceOrientation);
}


////6.0
- (BOOL)shouldAutorotate
{
    return NO;
}

////支持方向
- (NSInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}


/*
 typedef NS_ENUM(NSInteger, UIDeviceOrientation) {
 UIDeviceOrientationUnknown,
 UIDeviceOrientationPortrait,            // Device oriented vertically, home button on the bottom
 UIDeviceOrientationPortraitUpsideDown,  // Device oriented vertically, home button on the top
 UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
 UIDeviceOrientationLandscapeRight,      // Device oriented horizontally, home button on the left
 UIDeviceOrientationFaceUp,              // Device oriented flat, face up
 UIDeviceOrientationFaceDown             // Device oriented flat, face down
 };
 */

/*
 typedef NS_OPTIONS(NSUInteger, UIInterfaceOrientationMask) {
 UIInterfaceOrientationMaskPortrait = (1 << UIInterfaceOrientationPortrait),
 UIInterfaceOrientationMaskLandscapeLeft = (1 << UIInterfaceOrientationLandscapeLeft),
 UIInterfaceOrientationMaskLandscapeRight = (1 << UIInterfaceOrientationLandscapeRight),
 UIInterfaceOrientationMaskPortraitUpsideDown = (1 << UIInterfaceOrientationPortraitUpsideDown),
 UIInterfaceOrientationMaskLandscape = (UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
 UIInterfaceOrientationMaskAll = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortraitUpsideDown),
 UIInterfaceOrientationMaskAllButUpsideDown = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
 };
 */


////旋转过程中执行的方法

//旋转方向发生改变时
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
}
//视图旋转动画前一半发生之前自动调用
-(void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
}
//视图旋转动画后一半发生之前自动调用
-(void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration {
}
//视图旋转之前自动调用
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
}
//视图旋转完成之后自动调用
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
}
//视图旋转动画前一半发生之后自动调用
-(void)didAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
}

@end
