//
//  NdUncaughtExceptionHandler.m
//  Search
//
//  Created by h on 14-12-9.
//  Copyright (c) 2014年 LYZ. All rights reserved.
//

#import "NdUncaughtExceptionHandler.h"


NSString *applicationDocumentsDirectory() {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    
//    NSString *url = [NSString stringWithFormat:@"=============异常崩溃报告=============\nname:\n%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    
    
//    1.
    NSString *crashLogInfo = [NSString stringWithFormat:@"exception type : %@ \n crash reason : %@ \n call stack info : %@", name, reason, arr];
    NSString *urlStr = [NSString stringWithFormat:@"mailto:1174568144@qq.com?subject=bug报告&body=感谢您的配合!错误详情:%@",crashLogInfo];
    NSURL *url = [NSURL URLWithString:[urlStr
                                       stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
//    2.
    NSMutableString *mailUrl = [[NSMutableString alloc]init];
    //添加收件人
//    NSArray *toRecipients = [NSArray arrayWithObject: @"first@example.com"];
    [mailUrl appendFormat:@"mailto:1174568144@qq.com"];
//    //添加抄送
//    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
//    [mailUrl appendFormat:@"?cc=%@", [ccRecipients componentsJoinedByString:@","]];
//    //添加密送
//    NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
//    [mailUrl appendFormat:@"&bcc=%@", [bccRecipients componentsJoinedByString:@","]];
    //添加主题
    [mailUrl appendString:@"&subject=my email.bug"];
    //添加邮件内容
    [mailUrl appendString:@"&body=<b>email</b> body!"];
    NSString* email = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];

    
    //除了可以选择写到应用下的某个文件，通过后续处理将信息发送到服务器等
    //还可以选择调用发送邮件的的程序，发送信息到指定的邮件地址
    //或者调用某个处理程序来处理这个信息
}

@implementation NdUncaughtExceptionHandler


+ (void)setDefaultHandler
{
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
}

+ (NSUncaughtExceptionHandler*)getHandler
{
    return NSGetUncaughtExceptionHandler();
}



@end
