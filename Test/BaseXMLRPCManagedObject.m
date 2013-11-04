//
//  BaseXMLRPCManagedObject.m
//  Test
//
//  Created by DX074-XL on 2013-10-31.
//  Copyright (c) 2013 Pivotal Labs. All rights reserved.
//

#import "BaseXMLRPCManagedObject.h"

@implementation BaseXMLRPCManagedObject

+ (NSMutableURLRequest *)requestForInsertedObject:(BaseXMLRPCManagedObject *)object {
//    NSString *methodName = [self methodNameForCRUDOperation:Insert];
//    NSArray *params = [self paramsForCRUDOperation:Insert];
    
    // TODO
    // Build request with WPXMLEncoder
    
    // Returning nil for the request causes the object to be persisted by default.
    
    return nil;
}

// TODO Update

// TODO Delete

+ (NSString *)methodNameForCRUDOperation:(XMLRPCCRUDOperation)op {
    // Subclass
    return nil;
}

+ (NSArray *)paramsForCRUDOperation:(XMLRPCCRUDOperation)op {
    // Subclass
    return nil;
}

@end
