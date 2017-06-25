//
//  ViewController.m
//  仿SDWebImage
//
//  Created by 梁磊 on 2017/6/23.
//  Copyright © 2017年 梁磊. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "AppModel.h"
#import "YYModel.h"
#import "DownloadOperation.h"
#import "NSString+path.h"
#import "WebImageManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property(nonatomic,strong)NSOperationQueue *queue;
@property(nonatomic,strong)NSArray *appList;
@property(nonatomic,strong)NSMutableDictionary *opCache;
@property(nonatomic,copy)NSString *lastURLString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.queue = [NSOperationQueue new];
    self.opCache = [NSMutableDictionary new];

    [self loadData];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    int random = arc4random_uniform((uint32_t)self.appList.count);
    
    AppModel *model = self.appList[random];
    
    //在下载操作开始前，判断传入的图片地址是否一致
    if (![model.icon isEqualToString:_lastURLString] && _lastURLString != nil) {

        [[WebImageManager sharenManager]cancelLastOperation:_lastURLString];
    }
    
    _lastURLString = model.icon;
    
    [[WebImageManager sharenManager] downloadImageWithURLString:model.icon completion:^(UIImage *image) {
        self.ImageView.image = image;
    }];
}



-(void)loadData{
    
    NSString *URLString = @"https://raw.githubusercontent.com/zhangxiaochuZXC/SHHM06/master/apps.json";
    [[AFHTTPSessionManager manager]GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *dictArr = responseObject;
        self.appList = [NSArray yy_modelArrayWithClass:[AppModel class] json:dictArr];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
