//
//  QMYService.h
//  OpenPlatform
//
//  Created by h on 14-12-4.
//  Copyright (c) 2014年 HenHen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QMYServiceDelegate <NSObject>

@required
//与云通讯平台连接成功
- (void)onConnectionSuccessful:(NSString *)result;
//与云通讯平台连接失败或连接断开
-(void)onConnectionFailed:(NSString *)reason;

@end


@interface QMYService : NSObject

@property(nonatomic,assign)id<QMYServiceDelegate> delegate;


- (QMYService *)initWithDelegate:(id<QMYServiceDelegate>)delegate;

//-(void)setDelegate:(id< QMYServiceDelegate>)delegate;



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
 * @param caller                        主叫电话号码
 * @param called                        被叫号码号码
 * @param fromSerNum                    显示被叫号码
 * @param toSerNum                      显示主叫号码
 *
 */
//2.电话回拨
- (id)url:(NSString *)url parme:(NSDictionary *)parme;



/**
 * 信息验证码  语音验证码
 *@param  appId                         APPId,
 *@param  clientNumber                  所选子账号clientNumber,
 *@param  bindPhone                     新号码,
 *@param  responseType                  信息验证标示
 *
 */
//3.获取验证码 （语音 + 信息 根据 responseType 字段 判断）
-(id)url:(NSString *)url parme:(NSDictionary *)parme withAppid:(NSString *)appid clientNumber:(NSString *)clientNumber bindPhone:(NSString *)bindPhone responseType:(NSString *)responseType;



/**
 * 验证码验证
 *
 *@param  url                           地址,
 *@param  parme                         参数,
 *@param  phone                         新号码,
 *@param  verifycode                    验证验证码
 *
 */
//4.校验验证码
-(id)url:(NSString *)url parme:(NSDictionary *)parme withPhone:(NSString *)phone withVerifycode:(NSString *)verifycode;




@end
