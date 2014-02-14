//
//  CRAppDelegate.m
//  AlarmClock
//
//  Created by Cornelia Rehbein on 12/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//
#import "CRAppDelegate.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks" // for run timers in background method. Warning can be safely ignored

@implementation CRAppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    self.mainController = (UITabBarController*)[[UIStoryboard storyboardWithName:@"Storyboard"
                                                                          bundle:nil] instantiateInitialViewController];
    if (self.mainController) {
        self.window.rootViewController = self.mainController;
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication*)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication*)application
{
    UIApplication* app = [UIApplication sharedApplication];

    __block UIBackgroundTaskIdentifier backgroundTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:backgroundTask];
        backgroundTask = UIBackgroundTaskInvalid; }];

    //new timer with async call
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
		//run function methodRunAfterBackground
        NSTimer* t = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runTimersInBackground) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:t forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
}

- (void)runTimersInBackground
{
    SEL updateSelector = NSSelectorFromString(@"updateSecond");

    for (UIViewController* viewController in self.mainController.viewControllers) {
        if ([viewController respondsToSelector:updateSelector]) {

            [viewController performSelector:updateSelector];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication*)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication*)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication*)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
