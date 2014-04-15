//
//  AppDelegate.h
//  RSS 阅读器
//
//  Created by GaoYu on 14-4-13.
//  Copyright (c) 2014年 GaoYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//数据模型对象
@property(nonatomic,strong)NSManagedObjectModel *managedObjectModel;
//数据上下文
@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;
//持久存储区
@property(nonatomic,strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;

//初始化Core Data使用的数据库
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator;
//初始赋值函数
-(NSManagedObjectModel *)managedObjectModel;
-(NSManagedObjectContext *)managedObjectContext;
-(void)save;
@end
