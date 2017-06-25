//
//  WebImageManager.h
//  仿SDWebImage
//
//  Created by 梁磊 on 2017/6/25.
//  Copyright © 2017年 梁磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadOperation.h"
@interface WebImageManager : NSObject
+(instancetype)sharenManager;


-(void)downloadImageWithURLString:(NSString *)URLString completion:(void(^)(UIImage *image))completionBlock;


-(void)cancelLastOperation:(NSString *)lastURLString;

@end
