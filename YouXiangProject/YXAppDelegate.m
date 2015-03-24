//
//  YXAppDelegate.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/26.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXAppDelegate.h"
#import "YXIndexPage.h"
#import "YXGuidPage.h"
#import "AFNetworking.h"
#import "UMSocial.h"
#import "TCDateTimeFormat.h"
@implementation YXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//    // Override point for customization after application launch.
//    [UMSocialData setAppKey:@"54c74e24fd98c5ca130008ad"];
//    
//    [self loadController];
//    self.window.backgroundColor = [UIColor colorWithRed:0.19 green:0.19 blue:0.19 alpha:1];
//    [self.window makeKeyAndVisible];
//    return YES;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [UMSocialData setAppKey:@"54c74e24fd98c5ca130008ad"];
    [self loadController];
    self.window.backgroundColor = [UIColor colorWithRed:0.19 green:0.19 blue:0.19 alpha:1];
    [self.window makeKeyAndVisible];
    return YES;
}


//    }else {
//        YXGuidPage * guid = [[YXGuidPage alloc] init];
//        guid.launchBlock=^(void){
//            YXIndexPage * index = [[YXIndexPage alloc] init];
//            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:index];
//            self.window.rootViewController = nav;
//        };
//        self.window.rootViewController = guid;
//        
//        [defaults setObject:@"YES" forKey:@"isFirstLaunch"];
//        [defaults synchronize];
//    }
//}

- (void)loadController
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *isFirstLaunch = [defaults objectForKey:@"isFirstLaunch"];
    if ([isFirstLaunch isEqualToString:@"YES"]) {
        YXIndexPage *index = [[YXIndexPage alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:index];
        self.window.rootViewController = nav;
    } else {
        YXGuidPage *guid = [[YXGuidPage alloc] init];
        guid.launchBlock = ^(void){
            YXIndexPage *index = [[YXIndexPage alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:index];
            self.window.rootViewController = nav;
        };
        self.window.rootViewController = guid;
        [defaults setObject:@"YES" forKey:@"isFirstLaunch"];
        [defaults synchronize];
    }
}

//- (void)Monitoring
//{
//    NSURL *baseURL = [NSURL URLWithString:@"http://example.com/"];
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
//    
//    NSOperationQueue *operationQueue = manager.operationQueue;
//    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                [operationQueue setSuspended:NO];
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//            default:
//                [operationQueue setSuspended:YES];
//                break;
//        }
//    }];
//    
//    [manager.reachabilityManager startMonitoring];
//}

- (void)Monitoring
{
    NSURL *baseUrl = [NSURL URLWithString:@"http://example.com/"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl];
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    [manager.reachabilityManager startMonitoring];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
