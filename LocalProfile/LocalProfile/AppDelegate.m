//
//  AppDelegate.m
//  LocalProfile
//
//  Created by Jonathan King on 26/03/2014.
//  Copyright (c) 2014 Jonathan King. All rights reserved.
//

#import "AppDelegate.h"
#import "HTTPServer.h"

@interface AppDelegate ()
- (void)startServer;
@end

@implementation AppDelegate

- (void)startServer
{
    // Create server using our custom MyHTTPServer class
	_httpServer = [[HTTPServer alloc] init];
	
	// Tell the server to broadcast its presence via Bonjour.
	// This allows browsers such as Safari to automatically discover our service.
	[_httpServer setType:@"_http._tcp."];
	
	// Normally there's no need to run our server on any specific port.
	// Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
	// However, for easy testing you may want force a certain port so you can just hit the refresh button.
    [_httpServer setPort:12345];
	
    // Serve files from documents directory
	
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	[_httpServer setDocumentRoot:documentsDirectory];
    
    if (_httpServer.isRunning) [_httpServer stop];
    
	NSError *error;
	if([_httpServer start:&error])
	{
		NSLog(@"Started HTTP Server on port %hu", [_httpServer listeningPort]);
	}
	else
	{
		NSLog(@"Error starting HTTP Server: %@", error);
        // Probably should add an escape - but in practice never loops more than twice (bug filed on GitHub https://github.com/robbiehanson/CocoaHTTPServer/issues/88)
        [self startServer];
	}
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Start the server (and check for problems)
    
    [self startServer];

    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    backgroundTask = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:backgroundTask];
        backgroundTask = UIBackgroundTaskInvalid;
    }];
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
