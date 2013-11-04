//
//  Post.m
//  Test
//
//  Created by DX074-XL on 2013-10-31.
//  Copyright (c) 2013 Pivotal Labs. All rights reserved.
//

#import "Post.h"


@implementation Post

@dynamic postID;
@dynamic postTitle;
@dynamic status;

+ (NSMutableURLRequest *)requestForInsertedObject:(Post *)object {
    // Uses the post status to determine whether to upload or keep as local draft
    if ([object.status isEqualToNumber:@(0)]) {
        return nil; // Returning nil causes the object to be persisted
    }
    return [NSMutableURLRequest new];
}

//+ (NSMutableURLRequest *)requestForDeletedObject:(Post *)object {
//    return [NSMutableURLRequest new];
//}

+ (NSString *)methodNameForCRUDOperation:(XMLRPCCRUDOperation)op {
    switch (op) {
        case Insert :
            return @"wp.newPost";
        default:;
    }
    return nil;
}

+ (NSDictionary *)paramsForCRUDOperation:(XMLRPCCRUDOperation)op {
    switch (op) {
        case Insert:
            return @{};
        default:
            break;
    }
    return nil;
}

@end
