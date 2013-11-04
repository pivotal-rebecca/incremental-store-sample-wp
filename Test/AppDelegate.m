//
//  AppDelegate.m
//  Test
//
//  Created by DX074-XL on 2013-10-29.
//  Copyright (c) 2013 Pivotal Labs. All rights reserved.
//

#import "AppDelegate.h"
#import "Post.h"
#import "ContextManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "WordPressIncrementalStore.h"

@interface Awesome : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController *r;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    UIViewController *hello = [Awesome new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:hello];
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {}

@end

@implementation Awesome
static NSString *const idCell = @"thingCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createPost)];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:idCell];
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Post"];
    fetch.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"postTitle" ascending:YES]];
    _r = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:[ContextManager sharedInstance].mainContext sectionNameKeyPath:nil cacheName:nil];
    _r.delegate = self;
    [_r performFetch:nil];
}

- (void)createPost {
    Post *new = [NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:_r.managedObjectContext];
    new.postTitle = @"New Post";
    new.postID = @"1";
    new.status = @(0);
    
    [_r.managedObjectContext insertObject:new];
    [_r.managedObjectContext save:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_r.fetchedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idCell];
    NSString *postTitle = [_r.fetchedObjects[indexPath.row] postTitle];
    cell.textLabel.text = ![postTitle isEqualToString:@""] ? postTitle : @"(no title)";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_r.managedObjectContext deleteObject:[_r objectAtIndexPath:indexPath]];
    [_r.managedObjectContext save:nil];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

@end

