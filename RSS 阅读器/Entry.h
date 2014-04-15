//
//  Entry.h
//  RSS 阅读器
//
//  Created by GaoYu on 14-4-15.
//  Copyright (c) 2014年 GaoYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entry : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * title;

@end
