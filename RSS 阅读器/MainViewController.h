//
//  MainViewController.h
//  RSS 阅读器
//
//  Created by GaoYu on 14-4-13.
//  Copyright (c) 2014年 GaoYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Party.h"
#import "RssParser.h"
#import "Party.h"
#import "Rss.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSString *url_str;
    UITextField *textField;
    Rss *rss;
    UITableView *table;
    NSMutableArray *title_arr;
    AppDelegate *appDelegate;
    NSMutableArray *entries;
}

@property(nonatomic,retain)Party *party;


@end
