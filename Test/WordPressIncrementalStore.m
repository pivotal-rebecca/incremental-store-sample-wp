//
//  WordPressIncrementalStore.m
//  Test
//
//  Created by DX074-XL on 2013-10-31.
//  Copyright (c) 2013 Pivotal Labs. All rights reserved.
//

#import "WordPressIncrementalStore.h"
#import "WPXMLRPCClient.h"

@implementation WordPressIncrementalStore

+ (void)initialize {
    [NSPersistentStoreCoordinator registerStoreClass:[WordPressIncrementalStore class] forStoreType:NSStringFromClass(self)];
}

+ (NSString *)type {
    return NSStringFromClass(self);
}

+ (NSManagedObjectModel *)model {
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"xcdatamodeld"]];
}

- (AFHTTPClient<AFIncrementalStoreHTTPClient> *)HTTPClient {
    return [WPXMLRPCClient sharedClient];
}

@end
