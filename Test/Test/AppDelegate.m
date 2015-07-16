//
//  AppDelegate.m
//  Test
//
//  Created by qiandong on 6/30/15.
//  Copyright (c) 2015 qiandong. All rights reserved.
//


#import "AppDelegate.h"
#import "DMLog.h"

#import "FundListVC.h"
#import "CategoryVC.h"
#import "LaunchVC.h"
#import "MyVC.h"

#import "BaseNavController.h"
#import "BaseTabBarController.h"

#import "ApiManager.h"


#include <sys/sysctl.h>
#include <sys/utsname.h>


#import "ViewController.h"
#import "PopVC.h"

@interface AppDelegate ()

@property (strong, nonatomic) BaseTabBarController *mainTabBar;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [DMLog initDMLog];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self querySystemInfo];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = [[PopVC alloc] init];
    [self.window makeKeyAndVisible];
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.backgroundColor = [UIColor blackColor];
//    self.window.rootViewController = [[ViewController alloc] init];
//    [self.window makeKeyAndVisible];
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.backgroundColor = [UIColor blackColor];
//    [self buildMainTabBar];
//    self.window.rootViewController = _mainTabBar;
//    [self.window makeKeyAndVisible];
    
    return YES;
}



//- (NSString *)platformRawString {
//    size_t size;
//    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//    char *machine = malloc(size);
//    sysctlbyname("hw.machine", machine, &size, NULL, 0);
//    NSString *platform = [NSString stringWithUTF8String:machine];
//    free(machine);
//    return platform;
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

-(void)querySystemInfo
{
    [[ApiManager shared] querySystemInfoWithblock:^(CommonResult *commonResult, SystemInfo *systemInfo, NSError *error) {
        if (!error) {
            if(commonResult.success){
                [ESSession shared].systemInfo = systemInfo;
            }
        }else{
            ;
        }
    }];
}

-(void)buildMainTabBar
{
    FundListVC *vc1=[[FundListVC alloc] init];
    BaseNavController *nav1=[[BaseNavController alloc] initWithRootViewController:vc1];
    
    CategoryVC *vc2=[[CategoryVC alloc] init];
    BaseNavController *nav2=[[BaseNavController alloc] initWithRootViewController:vc2];
    
    LaunchVC *vc3=[[LaunchVC alloc] init];
    BaseNavController *nav3=[[BaseNavController alloc] initWithRootViewController:vc3];
    
    MyVC *vc4 = [[MyVC alloc] init];
    BaseNavController *nav4=[[BaseNavController alloc] initWithRootViewController:vc4];
    
    NSArray *arr=[[NSArray alloc] initWithObjects:nav1,nav2,nav3,nav4, nil];
    
    _mainTabBar=[[BaseTabBarController alloc] init];
    _mainTabBar.viewControllers=arr;
    
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
    [self VC:nav1 setTabarTitle:@"首页" Image:@"tab_1.png" SelectedImage:@"tab_1_s.png"];
    [self VC:nav2 setTabarTitle:@"分类" Image:@"tab_2.png" SelectedImage:@"tab_2_s.png"];
    [self VC:nav3 setTabarTitle:@"发起" Image:@"tab_3.png" SelectedImage:@"tab_3_s.png"];
    [self VC:nav4 setTabarTitle:@"我的" Image:@"tab_4.png" SelectedImage:@"tab_4_s.png"];
}

-(void)VC:(UIViewController *)vc setTabarTitle:(NSString *)title Image:(NSString *)imgName SelectedImage:(NSString *)selectedImgName
{

    [vc.tabBarItem setTitleTextAttributes:
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIColor grayColor],UITextAttributeTextColor,
                                            [UIFont boldSystemFontOfSize:12],NSFontAttributeName,nil]
                                forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIColor blackColor],UITextAttributeTextColor,
                                            [UIFont boldSystemFontOfSize:12],NSFontAttributeName,nil]
                                 forState:UIControlStateSelected];
    [vc.tabBarItem setTitle:title];
    [vc.tabBarItem setImage:[[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}







#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.qiandong.Test" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Test" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Test.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
