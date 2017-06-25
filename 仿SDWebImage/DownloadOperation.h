//
//  DownloadOperation.h
//  仿SDWebImage
//
//  Created by 梁磊 on 2017/6/23.
//  Copyright © 2017年 梁磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DownloadOperation : NSOperation


+ (instancetype)downloadOperationWithURLString:(NSString *)URLString finished:(void (^)(UIImage *))finishedBlock;
@end
