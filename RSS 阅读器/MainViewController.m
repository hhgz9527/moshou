//
//  MainViewController.m
//  RSS 阅读器
//
//  Created by GaoYu on 14-4-13.
//  Copyright (c) 2014年 GaoYu. All rights reserved.
//

#import "MainViewController.h"
#import "Entry.h"
#import "ContentViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"首页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRssAddress)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(readed)];

    UIButton *nslog = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [nslog setTitle:@"解析" forState:UIControlStateNormal];
    nslog.frame = CGRectMake(20, 300, 40, 40);
    [nslog addTarget:self action:@selector(jiexi:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nslog];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height - 66)];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    title_arr = [[NSMutableArray alloc] init];
    content_arr = [[NSMutableArray alloc] init];
    
    appDelegate = [UIApplication sharedApplication].delegate;

    [self readed];
}

-(void)readed{

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
        NSLog(@"我就看看有几个：%@",[enti valueForKey:@"title"]);
        [result addObject:[enti valueForKey:@"title"]];
    }
}

-(void)jiexi:(NSString *)url{
    [self deleteCoreData];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _party = [RssParser loadParty:url];
        if (_party != nil) {
            [RssParser saveParty:_party];
            for (rss in _party.arr) {
                NSLog(@"标题：%@",rss.title);
                [title_arr addObject:rss.title];
                [content_arr addObject:rss.content];
                NSLog(@"%@",rss.content);
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
                [table reloadData];
            
            for (int i = 0; i<title_arr.count; i++) {
                //依次存入到coredata中
                //之前写在多线程里面，一直存不进去，写到主线程中就好了
                Entry *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:[appDelegate managedObjectContext]];
                entity.title = [NSString stringWithFormat:@"%@",[title_arr objectAtIndex:i]];
                entity.content = [NSString stringWithFormat:@"%@",[content_arr objectAtIndex:i]];
                NSError *error;
                [[appDelegate managedObjectContext] save:&error];
            }
            [self readed];
        });
    });
    


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addRssAddress{
    //删除，用的时候去掉注释。。
//    [self deleteCoreData];
    UIAlertView *alert = [[UIAlertView alloc]  initWithTitle:@"输入地址" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    textField = [alert textFieldAtIndex:0];
    textField.keyboardType = UIKeyboardTypeURL;
    textField.text = @"http://";
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            //解析
            [self jiexi:textField.text];
            break;
        default:
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return result.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[result objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ContentViewController *content = [[ContentViewController alloc] init];
    [self.navigationController pushViewController:content animated:YES];
    
//    content.content_str = [NSString stringWithFormat:@"%@",[content_arr objectAtIndex:indexPath.row] ];
    content.i = indexPath.row;
}


-(void)deleteCoreData{
    //删除coredata中的title数据
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Entry" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:description];
    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [context deleteObject:obj];
        }
        if (![context save:&error])
        {
            NSLog(@"error:%@",error);
        }  
    }
}

@end
