//
//  RssParser.h
//  RSS 阅读器
//
//  Created by GaoYu on 14-4-13.
//  Copyright (c) 2014年 GaoYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Party;

@interface RssParser : NSObject

+(NSString *)dataFilePath:(BOOL)forSave url:(NSString *)url;

+(Party *)loadParty:(NSString *)URL;

+(void)saveParty:(Party *)party;
@end
