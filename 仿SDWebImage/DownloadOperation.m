//
//  DownloadOperation.m
//  仿SDWebImage
//
//  Created by 梁磊 on 2017/6/23.
//  Copyright © 2017年 梁磊. All rights reserved.
//

#import "DownloadOperation.h"
#import "NSString+path.h"
@interface DownloadOperation ()
@property(nonatomic,copy)NSString *URLString;
@property(nonatomic,copy)void(^finishedBlock)(UIImage *image);

@end
@implementation DownloadOperation

+ (instancetype)downloadOperationWithURLString:(NSString *)URLString finished:(void (^)(UIImage *))finishedBlock {
    DownloadOperation *op = [DownloadOperation new];
    op.URLString = URLString;
    op.finishedBlock = finishedBlock;
    
    return op;
}

-(void)main{
    NSURL *URL = [NSURL URLWithString:_URLString];
    NSData *date = [NSData dataWithContentsOfURL:URL];
    UIImage *image = [UIImage imageWithData:date];
    
    if (image !=nil) {
        [date writeToFile:[self.URLString appendCachePath] atomically:YES];
    }
    
    [NSThread sleepForTimeInterval:1.0];
    
    
    
    if (self.isCancelled ==YES) {
        return;
    }
    
    //传递到外界刷新UI
    if (self.finishedBlock) {
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            
            self.finishedBlock(image);
        }];
    }
}

@end
