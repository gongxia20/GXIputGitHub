//
//  GXHttpManager.m
//  AFNHtml转JSON
//
//  Created by 龚侠 on 14/4/1.
//  Copyright (c) 2014年 incast. All rights reserved.
//

#import "GXHttpManager.h"

@implementation GXHttpManager
+ (instancetype)manager {
    GXHttpManager *mgr = [super manager];
    
    NSMutableSet *newSet = [NSMutableSet set];
    newSet.set = mgr.responseSerializer.acceptableContentTypes;
    [newSet addObject:@"text/html"];
    
    mgr.responseSerializer.acceptableContentTypes = newSet;
    return mgr;
}
@end

