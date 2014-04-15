//
//  RssParser.m
//  RSS 阅读器
//
//  Created by GaoYu on 14-4-13.
//  Copyright (c) 2014年 GaoYu. All rights reserved.
//

#import "RssParser.h"
#import "Party.h"
#import "GDataXMLNode.h"
#import "Rss.h"

@implementation RssParser

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+(NSString *)dataFilePath:(BOOL)forSave url:(NSString *)url{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *docu = [path objectAtIndex:0];
    NSString *docuPath = [docu stringByAppendingString:@"blog.xml"];
    if (forSave || [[NSFileManager defaultManager] fileExistsAtPath:docuPath]) {
        return docuPath;
    }else{
        return url;
    }
    
}

+(Party *)loadParty:(NSString *)URL{
//    NSString *filepath = [self dataFilePath:NO url:URL];
    NSURL *url = [NSURL URLWithString:URL];
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfURL:url];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    if (doc == nil) {
        return nil;
    }
    Party *party = [[Party alloc] init];
    NSArray *arr = [doc.rootElement elementsForName:@"entry"];
    for (GDataXMLElement *partyMember in arr) {
        NSString *title_str;
        NSString *content_str;
       
        NSArray *names = [partyMember elementsForName:@"title"];
        NSArray *contents = [partyMember elementsForName:@"content"];
        
        if (names.count > 0) {
            GDataXMLElement *title = (GDataXMLElement *)[names objectAtIndex:0];
            title_str = title.stringValue;
            GDataXMLElement *content = (GDataXMLElement *)[contents objectAtIndex:0];
            content_str = [content stringValue];
        }
        Rss *rss = [[Rss alloc] init];
        rss.title = title_str;
        rss.content = content_str;
        [party.arr addObject:rss];
    }
    return party;
    

}

+(void)saveParty:(Party *)party{
}



@end
