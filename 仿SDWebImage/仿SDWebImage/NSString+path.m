//
//  NSString+path.m
//  异步加载网络图片
//
//  Created by 梁磊 on 2017/6/23.
//  Copyright © 2017年 梁磊. All rights reserved.
//

#import "NSString+path.h"

@implementation NSString (path)
-(NSString *)appendCachePath{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *name = [self lastPathComponent];
    NSString *filePath = [path stringByAppendingPathComponent:name];
    return filePath;
}
@end
