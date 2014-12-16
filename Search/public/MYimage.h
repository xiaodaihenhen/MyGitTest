//
//  MYimage.h
//  OpenPlatform
//
//  Created by h on 14-12-9.
//  Copyright (c) 2014年 HenHen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYimage : UIImage


//1.自动缩放到指定大小

+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;


//2.保持原来的长宽比，生成一个缩略图

+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;


@end
