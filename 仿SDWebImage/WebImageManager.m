//
//  WebImageManager.m
//  仿SDWebImage
//
//  Created by 梁磊 on 2017/6/25.
//  Copyright © 2017年 梁磊. All rights reserved.
//

#import "WebImageManager.h"
#import "NSString+path.h"

@interface WebImageManager ()

/// 队列
@property (nonatomic, strong) NSOperationQueue *queue;
/// 操作缓存池
@property (nonatomic, strong) NSMutableDictionary *opCache;

@property(nonatomic,strong)NSMutableDictionary *imageCache;

@end

@implementation WebImageManager

+(instancetype)sharenManager{
    
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    
    return instance;
}

-(instancetype)init{
    if (self = [super init]) {
        self.queue = [NSOperationQueue new];
        self.opCache = [NSMutableDictionary new];
    }
    return self;
}

-(void)downloadImageWithURLString:(NSString *)URLString completion:(void (^)(UIImage *))completionBlock{
    
    if ([self checkCacheWithURLString:URLString]) {
        if (completionBlock != nil) {
            completionBlock([self.imageCache objectForKey:URLString]);
            return;
        }
    }
    
    
    
    
    if ([self.opCache objectForKey:URLString] != nil) {
        return;

    }
    
    DownloadOperation *op = [DownloadOperation downloadOperationWithURLString:URLString finished:^(UIImage *image) {
        
        if (completionBlock !=nil) {
            completionBlock(image);
        }
        
        //内存缓存
        if (image !=nil) {
            [self.imageCache setObject:image forKey:URLString];
        }
        
        [self.opCache removeObjectForKey:URLString];
        
    }];
  
    
    //添加到操作缓存池
    [self.opCache setObject:op forKey:URLString];
    
    [self.queue addOperation:op];

}

//判断是否有缓存
- (BOOL)checkCacheWithURLString :(NSString *)URLString{
    if ([self.imageCache objectForKey:URLString] != nil) {
        NSLog(@"从内存中加载");
        return YES;
    }
    UIImage *cacheImage = [UIImage imageWithContentsOfFile:[URLString appendCachePath]];
    if (cacheImage != nil) {
        [self.imageCache setObject:cacheImage forKey:URLString];
        NSLog(@"从沙盒中加载");
        return YES;
    }
    return NO;
    
}
-(void)cancelLastOperation:(NSString *)lastURLString{
    
    DownloadOperation *lastOP = [self.opCache objectForKey:lastURLString];
    [lastOP cancel];
    
    [self.opCache removeObjectForKey:lastURLString];
}


@end
