//
//  UIImageView+ZZWebImage.m
//  ZZWebImage
//
//  Created by jam on 17-12-9.
//  Copyright (c) 2017年 jam. All rights reserved.
//

#import "UIImageView+ZZWebImage.h"
#import <objc/runtime.h>

static char *ZZWebImageUrlKey="ZZWebImageUrlKey";

@implementation UIImageView (ZZWebImage)

-(void)setImageUrl:(NSString *)url
{
    [self setImageUrl:url placeHolder:nil];
}

-(void)setImageUrl:(NSString *)url placeHolder:(UIImage *)placeHolder
{
    if (placeHolder) {
        self.image=placeHolder;
    }
    if (url.length>0) {
        self.webImageUrl=url;
        [ZZWebImageTool getImageFromUrl:url success:^(UIImage *image, NSError *error) {
            if (image&&[url isEqualToString:self.webImageUrl]) {
                self.image=image;
            }
        }];
    }
}

-(void)setWebImageUrl:(NSString *)webImageUrl
{
    objc_setAssociatedObject(self, ZZWebImageUrlKey, webImageUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString*)webImageUrl
{
    return objc_getAssociatedObject(self, ZZWebImageUrlKey);
}

@end
