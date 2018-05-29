使用方法：
UIImageView

-(void)zz_setImageUrl:(NSString*)url;
-(void)zz_setImageUrl:(NSString *)url placeHolder:(UIImage*)placeHolder;
-(void)zz_setImageUrl:(NSString *)url placeHolder:(UIImage *)placeHolder completed:(void(^)(UIImageView* imageView, UIImage* image, NSError* error, NSString* imageUrl))completion;
-(void)zz_setImageFromVideoUrl:(NSString*)url;
