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
    [self getContent];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *str = [NSString stringWithFormat:@"%@",[result objectAtIndex:_i]];


    UILabel *content_label = [[UILabel alloc] init];
    CGSize size = [str sizeWithFont:content_label.font constrainedToSize:CGSizeMake(content_label.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    content_label.frame = CGRectMake(0, 0, size.width, size.height);
    content_label.numberOfLines = 0;
//    content_label.lineBreakMode = NSLineBreakByCharWrapping;
    content_label.text = [NSString stringWithFormat:@"%@",[result objectAtIndex:_i]];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    scroll.contentSize = CGSizeMake(size.width, size.height);
    [scroll addSubview:content_label];
    [self.view addSubview:scroll];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getContent{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    //设置要检索那种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entry" inManagedObjectContext:appDelegate.managedObjectContext];
    //    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO];
    //    NSArray *arr = [[NSArray alloc] initWithObjects:sort, nil];
    
    //创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //指定结果的排序
    //    [request setSortDescriptors:arr];
    //设置请求实体
    [request setEntity:entity];
    
    NSError *error = nil;
    NSMutableArray *result1 = [[appDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (request == nil) {
        NSLog(@"%@",error);
    }
    result = [[NSMutableArray alloc] init];
    for (NSManagedObject *enti in result1) {
        [result addObject:[enti valueForKey:@"content"]];
    }
}
@end
