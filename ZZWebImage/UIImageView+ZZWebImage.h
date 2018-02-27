//
//  UIImageView+ZZWebImage.h
//  ZZWebImage
//
//  Created by jam on 17-12-9.
//  Copyright (c) 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZWebImageTool.h"

@interface UIImageView (ZZWebImage)

@property (nonatomic,strong) NSString* webImageUrl;

-(void)zz_setImageUrl:(NSString*)url;

-(void)zz_setImageUrl:(NSString *)url placeHolder:(UIImage*)placeHolder;

-(void)zz_setImageUrl:(NSString *)url placeHolder:(UIImage *)placeHolder completed:(void(^)(UIImageView* imageView, UIImage* image, NSError* error, NSString* imageUrl))completion;

-(void)zz_setImageFromVideoUrl:(NSString*)url;

@end
