//
//  ContentViewController.h
//  RSS 阅读器
//
//  Created by GaoYu on 14-4-16.
//  Copyright (c) 2014年 GaoYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface ContentViewController : UIViewController{
    NSMutableArray *result;
}

@property(nonatomic, assign)NSInteger i;
@property(nonatomic,copy)NSString *content_str;

@end
