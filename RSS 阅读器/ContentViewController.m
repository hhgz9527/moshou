//
//  ContentViewController.m
//  RSS 阅读器
//
//  Created by GaoYu on 14-4-16.
//  Copyright (c) 2014年 GaoYu. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *content_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 500)];
    content_label.numberOfLines = 0;
    content_label.lineBreakMode = NSLineBreakByCharWrapping;
    content_label.text = _content_str;
    [self.view addSubview:content_label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
