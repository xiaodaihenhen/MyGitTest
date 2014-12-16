//
//  API.h
//  API
//
//  Created by h on 14-12-2.
//  Copyright (c) 2014年 HenHen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QMYService.h"

@interface MyStatic : NSObject<QMYServiceDelegate>


@property(nonatomic,copy)NSString *clientNumber;
@property(nonatomic,copy)NSString *clientPwd;
@property(nonatomic,copy)NSString *result;



/**
 * 连接服务器登陆
 *
 * @param Url               网址
 * @param clientNumber      用户账号
 * @param clientPwd         密码
 * @param parme             请求参数
 *
 */

//1.连接服务器登陆
-(id)url:(NSString *)url withClientNumber:(NSString *)clientNumber withClientPwd:(NSString *)clientPwd parme:(NSDictionary *)parme;

/**
 * 回拨电话
 *
 * @param caller        主叫电话号码
 * @param called        被叫号码号码
 * @param fromSerNum    显示被叫号码
 * @param toSerNum      显示主叫号码
 *
 *
 */
//2.电话回拨
- (id)url:(NSString *)url parme:(NSDictionary *)parme;




/**
 * 信息验证码  语音验证码
 *@param  appId                  APPId,
 *@param  clientNumber           所选子账号clientNumber,
 *@param  bindPhone              新号码,
 *@param  responseType           信息验证标示
 */

-(id)url:(NSString *)url parme:(NSDictionary *)parme withAppid:(NSString *)appid clientNumber:(NSString *)clientNumber bindPhone:(NSString *)bindPhone responseType:(NSString *)responseType;


/**
 * 验证码验证
 */
-(id)url:(NSString *)url parme:(NSDictionary *)parme withPhone:(NSString *)phone withVerifycode:(NSString *)verifycode;






// 云获取验证码成功  0：已经验证成功，1:已下发验证码到用户
- (void) onGetValiateCodeSuccessful:(NSInteger)nResult;
// 云获取验证码失败
- (void) onGetValiateCodeFailed:(NSInteger)reason;

// 云验证成功
- (void) onDoValiateCodeSuccessful:(NSInteger)nResult;
// 云验证失败
- (void) onDoValiateCodeFailed:(NSInteger)reason;


@end
