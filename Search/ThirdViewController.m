//
//  ThirdViewController.m
//  TestStoryBoard
//
//  Created by 力国 赵 on 14-7-30.
//  Copyright (c) 2014年 力国 赵. All rights reserved.
//

#import "ThirdViewController.h"
#import "QMYService.h"
#import "MyStatic.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

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
    // Do any additional setup after loading the view from its nib.
    
//    1 使用  NSTimer创建一个多线程
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(animationss) userInfo:nil repeats:YES];
    //进程: 程序在计算机的一次执行活动, 一个程序就是一个进程, 在iOS中, 一个app就是一个进程
    //线程: 程序执行的最小单元, 一个进程中至少有一个线程(主线程)
    //第一个参数scheduledTimerWithTimeInterval       延迟时间
    //第二个参数target                               方法的执行者
    //第三个参数selector                             线程中执行的方法
    //第四个userInfo                                可以穿的参数                                
}

- (void)animationss
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationBeginsFromCurrentState:YES];
    //参数1: 现在视图的角度, 参数2: 将要改变的角度, 参数3, 4, 5, 是否改变X, Y, Z轴
    UIImageView *windmillImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    windmillImageView.layer.transform = CATransform3DRotate(windmillImageView.layer.transform, M_PI_4, 0, 0, 1);
}

- (void)banZhuan
{
    for (int i = 0; i < 100; i++) {
        NSLog(@"搬了%d块转", i + 1);
    }
}

- (void)banZhuanPro
{
    //通过NSObject的方法初始化线程
    //performSelectorInBackground:] withObject:<#(id)#> 会自动开辟一个后台线程, SEL:在这个后台线程中执行的方法, id: 用于传递参数
    [self performSelectorInBackground:@selector(banZhuanPlus) withObject:nil];
}

- (void)banZhuanWithThread
{
    //通过NSThread创建线程, 参数1: 方法的执行者, 参数2: 在线程中执行的方法, 参数3: 用于传递参数
    //1 创建线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(banZhuanPlus) object:nil];
    //2 在主线程执行
    [thread start];
  
}

- (void)banZhuanWithNSOperationQueue
{
    //NSOperation操作单元, 用来执行方法, 是一个抽象的类, 必须子类化或者使用系统创建好的子类:NSInvocationOperation, NSBlockOperation. NSOperation是最小的操作单元, 只能够执行一次
    //NSInvocationOperation创建
    
    //1 创建
    NSInvocationOperation *invocation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(banZhuanPlus) object:nil];
    //2 执行
    //    [invocation start];
    
    
    //NSBlockOperation创建
    //1 创建
    NSBlockOperation *block = [NSBlockOperation blockOperationWithBlock:^{
        [self banZhuanPlus];
    }];
    //2 执行
    //    [block start];
    
    //这个队列会自动创建一个辅助线程, 里面只能添加NSOperation的对象以及子类的对象
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //设置最大并行数
    [queue setMaxConcurrentOperationCount:2];
    //只要把操作单元添加到队列中就会执行, 上面无需start
    [queue addOperation:block];
    [queue addOperation:invocation];
    //队列:先进先出
    //栈:先进后出
    //队列里涉及到串行, 并行.
    //串行: 一次只能执行一个任务
    //并行: 一次可以执行多个任务
}

- (void)banZhuanWithGCD
{
    //GCD:Grand Central Dispatch 大中央调度 是Apple推崇的多线程管理策略 是通过队列对多线程进行管理的
    //第1中队列 主调队列, 在主线程中执行, 并且是串行(一次操作一个)
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //第二种队列 全局队列, 在子线程中执行, 并且是并行(一次可以执行多个)
    //参数1: 设置队列的优先级(high, default, low, background)
    //参数2: 是预留参数, 未来使用
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //第三种队列 自定义队列 在子线程中执行, 可以设置并行或者串行
    //参数1: 区分队列的唯一标示, 是一个可选项, 若不写, 写:NULL, 若写, 规范的例子是: "com.example.myqueue"
    //参数2: 设置并行或串行得
    //串行: DISPATCH_QUEUE_SERIAL
    //并行: DISPATCH_QUEUE_CONCURRENT
    dispatch_queue_t customQueue = dispatch_queue_create("com.example.myqueue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"%@ %@ %@", mainQueue, globalQueue, customQueue);
    
    //同步执行(需要等待执行完毕)
    //参数1: 指定队列 参数2: Block, 执行的操作
    dispatch_sync(globalQueue, ^{
        [self banZhuanPlus];
    });
    
    //异步执行(无需等待)
    //参数1: 指定队列 参数2: Block, 执行的操作
    dispatch_async(globalQueue, ^{
        [self banZhuanPlus];
    });
    //延迟执行
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(<#delayInSeconds#> * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        <#code to be executed after a specified delay#>
    //    });
}

- (void)banZhuanPlus
{
    //线程中要注意的几点:1 线程中的autorelease对象不能释放, 必须手动释放或者添加自动释放池 2 子线程中刷新UI可能失败(在子线程中不要刷新UI)
    @autoreleasepool {
        for (int i = 0; i < 100; i++) {
            NSLog(@"搬了%d块转", i + 1);
        }
    }
    //不要这样写
    //        self.view.backgroundColor = [UIColor redColor];
    //应该这样写, 在主线程中刷新UI
    [self performSelectorOnMainThread:@selector(refreshUI) withObject:nil waitUntilDone:YES];
}

- (void)refreshUI
{
    self.view.backgroundColor = [UIColor redColor];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
