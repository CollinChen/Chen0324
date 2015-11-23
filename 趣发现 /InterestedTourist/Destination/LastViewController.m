//
//  LastViewController.m
//  InterestedTourist
//
//  Created by qianfeng on 15/11/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LastViewController.h"

@interface LastViewController ()
{
    
    //数据源字典
    NSDictionary * _datadict;
    
    AFHTTPRequestOperationManager * _manager;
    
}
@end

@implementation LastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self requestdata];
    
    self.ScrollView.contentSize = CGSizeMake(0, 800);
    
    NSLog(@"%@",_StrOfUrl);
    
    [self LoadItems];
    
}


- (void)LoadItems{
    
    _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
        NSString * url = [NSString stringWithFormat:URL_DES_LAST,_StrOfUrl];
    
        [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSDictionary * dic = dict[@"data"];
            
            [_Img sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"photo"]]];
            
            _LbNavTitle.text = [dic objectForKey:@"firstname"];
            
            _LbTitle.text = [dic objectForKey:@"firstname"];
            
            _Lbdescribe.text = [dic objectForKey:@"introduction"];
            
            _LbAddress.text = [dic objectForKey:@"address"];
    
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        }];
    
    
}


//- (void)requestdata{
//    
//    _manager = [AFHTTPRequestOperationManager manager];
//    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    NSString * url = [NSString stringWithFormat:URL_DES_LAST,_StrOfUrl];
//    
//    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        
//        _datadict = dict[@"data"];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    
//    }];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)BackBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
