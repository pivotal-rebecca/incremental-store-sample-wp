//
//  Post.h
//  Test
//
//  Created by DX074-XL on 2013-10-31.
//  Copyright (c) 2013 Pivotal Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseXMLRPCManagedObject.h"

@interface Post : BaseXMLRPCManagedObject

@property (nonatomic, retain) NSString * postID;
@property (nonatomic, retain) NSString * postTitle;
@property (nonatomic, retain) NSNumber * status;

@end
