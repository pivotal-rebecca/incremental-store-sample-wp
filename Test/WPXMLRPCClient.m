//
//  WPXMLRPCClient.m
//  Test
//
//  Created by DX074-XL on 2013-10-31.
//  Copyright (c) 2013 Pivotal Labs. All rights reserved.
//

#import "WPXMLRPCClient.h"
#import "WPXMLRPCDecoder.h"
#import "WPXMLRPCEncoder.h"

@implementation WPXMLRPCClient

static WPXMLRPCClient *sharedClient;

+ (instancetype)sharedClient {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://wordpress-dev.xtremelabs.com/xmlrpc.php"]];
    });
    return sharedClient;
}

- (NSDictionary *)attributesForRepresentation:(NSDictionary *)representation ofEntity:(NSEntityDescription *)entity fromResponse:(NSHTTPURLResponse *)response {
    return @{@"postTitle": [representation objectForKey:@"title"],
             @"postID": [representation objectForKey:@"postid"]};
}

- (NSDictionary *)representationsForRelationshipsFromRepresentation:(NSDictionary *)representation ofEntity:(NSEntityDescription *)entity fromResponse:(NSHTTPURLResponse *)response {
    return @{};
}

- (NSMutableURLRequest *)requestForFetchRequest:(NSFetchRequest *)fetchRequest withContext:(NSManagedObjectContext *)context {
#warning Fill in the credentials for the blog. Self-hosted blogs usually have blogID of 1
    NSURL *blogURL = [NSURL URLWithString:@""];
    NSString *blogID = @"";
    NSString *username = @"";
    NSString *password = @"";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:blogURL];
    [request addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    
    WPXMLRPCEncoder *encoder = [[WPXMLRPCEncoder alloc] initWithMethod:@"metaWeblog.getRecentPosts" andParameters:@[blogID, username, password]];
    request.HTTPBody = encoder.body;
    return request;
}

- (NSString *)resourceIdentifierForRepresentation:(NSDictionary *)representation ofEntity:(NSEntityDescription *)entity fromResponse:(NSHTTPURLResponse *)response {
    return representation[@"postid"];
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method pathForRelationship:(NSRelationshipDescription *)relationship forObjectWithID:(NSManagedObjectID *)objectID withContext:(NSManagedObjectContext *)context {
    return [NSMutableURLRequest new];
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method pathForObjectWithID:(NSManagedObjectID *)objectID withContext:(NSManagedObjectContext *)context {
    return [NSMutableURLRequest new];
}

- (id)representationOrArrayOfRepresentationsOfEntity:(NSEntityDescription *)entity fromResponseObject:(id)responseObject requestOperation:(AFHTTPRequestOperation *)requestOperation {
    WPXMLRPCDecoder *decoder = [[WPXMLRPCDecoder alloc] initWithData:responseObject];
    NSArray *posts = decoder.object;
    return posts;
}

- (NSMutableURLRequest *)requestForInsertedObject:(NSManagedObject *)insertedObject {
    Class klass = NSClassFromString(insertedObject.entity.name);
    if ([klass respondsToSelector:@selector(requestForInsertedObject:)]) {
        return [klass requestForInsertedObject:insertedObject];
    }
    return nil;
}

- (NSMutableURLRequest *)requestForUpdatedObject:(NSManagedObject *)updatedObject {
    return [NSMutableURLRequest new];
}

- (NSMutableURLRequest *)requestForDeletedObject:(NSManagedObject *)deletedObject {
    
    Class klass = NSClassFromString(deletedObject.entity.name);
    if ([klass respondsToSelector:@selector(requestForDeletedObject:)]) {
        return [klass requestForDeletedObject:deletedObject];
    }
    return nil;
}

- (BOOL)shouldFetchRemoteAttributeValuesForObjectWithID:(NSManagedObjectID *)objectID inManagedObjectContext:(NSManagedObjectContext *)context {
    return NO;
}

- (BOOL)shouldFetchRemoteValuesForRelationship:(NSRelationshipDescription *)relationship forObjectWithID:(NSManagedObjectID *)objectID inManagedObjectContext:(NSManagedObjectContext *)context {
    return NO;
}

@end
