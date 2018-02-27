//
//  ZZWebImageTool.m
//  ZZWebImage
//
//  Created by jam on 17-12-9.
//  Copyright (c) 2017年 jam. All rights reserved.
//

#import "ZZWebImageTool.h"
#import <AVFoundation/AVFoundation.h>

//static NSMutableDictionary* sharedCachedImageDictionary;

@implementation ZZWebImageTool

+(void)getImageFromUrl:(NSString *)url success:(void (^)(UIImage *, NSError *))success
{
    [self requestUrl:url success:^(NSData *data) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage* img=[UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    success(img,nil);
                }
            });
        });
    } failure:^(NSError *error) {
        if (success) {
            success(nil,error);
        }
    }];
}

+(void)getImageFromVideoUrl:(NSString *)url success:(void (^)(UIImage *, NSError *))success
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        static NSMutableDictionary* _staticVideoThumbImageCache;
        if (_staticVideoThumbImageCache==nil) {
            _staticVideoThumbImageCache=[NSMutableDictionary dictionary];
        }
        UIImage* img=[_staticVideoThumbImageCache valueForKey:url];
        
        if (!img) {
            AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:url] options:nil];
            float fps = [[[asset tracksWithMediaType:AVMediaTypeVideo] firstObject] nominalFrameRate];
            AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
            gen.appliesPreferredTrackTransform = YES;
            CMTime time = CMTimeMakeWithSeconds(1, fps);
            NSError *error = nil;
            CMTime actualTime;
            CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
            img = [[UIImage alloc] initWithCGImage:image];
            CGImageRelease(image);
            [_staticVideoThumbImageCache setValue:img forKey:url];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(img,nil);
            }
        });
    });
}

+(void)requestUrl:(NSString *)url success:(void (^)(NSData* successData))success failure:(void (^)(NSError *failureError))failure
{
    NSURL* _ur=[NSURL URLWithString:url];
    
    NSMutableURLRequest* request=[NSMutableURLRequest requestWithURL:_ur];
    request.HTTPMethod=@"GET";
    
    NSURLCache* cache=[NSURLCache sharedURLCache];
    [cache setDiskCapacity:512*1024*1024];
    NSCachedURLResponse* cacheResp=[cache cachedResponseForRequest:request];
    NSData* cachedData=cacheResp.data;
    if (cachedData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(cachedData);
            }
        });
        return;
    }
    
    NSURLSession* session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask* dataTast=[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        
        [session finishTasksAndInvalidate];
        if (data) {
            [cache storeCachedResponse:[[NSCachedURLResponse alloc]initWithResponse:response data:data] forRequest:request];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                if (success) {
                    success(data);
                }
                return;
            }
            else if(error)
            {
                if (failure) {
                    failure(error);
                }
                return;
            }
            if (failure) {
                failure(error);
            }
            return;
        });
    }];
    [dataTast resume];

}

@end
