//
//  BaseXMLRPCManagedObject.h
//  Test
//
//  Created by DX074-XL on 2013-10-31.
//  Copyright (c) 2013 Pivotal Labs. All rights reserved.
//

#import <CoreData/CoreData.h>

typedef NS_ENUM(NSUInteger, XMLRPCCRUDOperation) {
    Insert,
    Delete,
    Update
};

@interface BaseXMLRPCManagedObject : NSManagedObject

+ (NSMutableURLRequest *)requestForInsertedObject:(BaseXMLRPCManagedObject *)object;
// update
// delete

+ (NSString *)methodNameForCRUDOperation:(XMLRPCCRUDOperation)op;
+ (NSArray *)paramsForCRUDOperation:(XMLRPCCRUDOperation)op;

@end
