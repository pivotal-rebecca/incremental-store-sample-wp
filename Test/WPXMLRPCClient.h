//
//  WPXMLRPCClient.h
//  Test
//
//  Created by DX074-XL on 2013-10-31.
//  Copyright (c) 2013 Pivotal Labs. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFIncrementalStore.h"

@interface WPXMLRPCClient : AFHTTPClient <AFIncrementalStoreHTTPClient>

+ (instancetype)sharedClient;

@end
