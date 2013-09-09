//
//  ThumbtackAppDelegate.m
//  iMinesweeper
//
//  Created by Emerson Carvalho on 9/9/13.
//  Copyright (c) 2013 Emerson Carvalho. All rights reserved.
//

#import "ThumbtackAppDelegate.h"
#import "ThumbtackMap.h"

@implementation ThumbtackAppDelegate

CGFloat width;
CGFloat height;

ThumbtackMap *map;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    width = CGRectGetWidth(screen);
    height = CGRectGetHeight(screen);
    
    UIImageView* bg;
    if ([[UIScreen mainScreen] bounds].size.height == 568){
        bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-568h@2x.png"]];
    }
    else{
        bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
    }
    [self.window addSubview:bg];
    [self.window sendSubviewToBack:bg];
    
    
    // start button
    UIButton *start = [[UIButton alloc] initWithFrame:CGRectMake(20, 22, 30, 30)];
    [start setBackgroundImage:[UIImage imageNamed:@"normal.png"] forState:UIControlStateNormal];
    [start addTarget:self action:@selector(startClick:) forControlEvents:UIControlEventTouchUpInside];
    [start setTag:1];

    // Result Label
    UILabel *result = [[UILabel alloc] initWithFrame: CGRectMake(60, 22, 200, 30)];
    [result setBackgroundColor: [UIColor clearColor]];
    [result setTextColor:[UIColor yellowColor]];
    [result setTag:2];
    
    [self.window addSubview:start];
    [self.window addSubview: result];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void) setMinesweeper
{
    
    map = [[ThumbtackMap alloc]initWithFrame:CGRectMake(0, 52, width, height-52)];
    [map setSquares:8];
    [map setMines: 10];
    [map setTag:3];
    [map setClicks:0];
    [map createFields];
    
    [self.window addSubview:map];
}

-(void) startClick:(UIButton *) start
{
    
    UILabel *result = (UILabel *) [self.window viewWithTag:2];
    [result setText:@""];
    
    if(map.gameRunning == NO){
        map.gameRunning = YES;
        [self setMinesweeper];
        [start setBackgroundImage:[UIImage imageNamed:@"normal.png"] forState:UIControlStateNormal];
    }else{
        map.gameRunning = NO;
       
        if ([map playerWin]) {
           [result setText:@"You Win! =)"];
           [start setBackgroundImage:[UIImage imageNamed:@"happy.png"] forState:UIControlStateNormal];

        }else{
            [result setText:@"You Lose! =("];
            [start setBackgroundImage:[UIImage imageNamed:@"sad.png"] forState:UIControlStateNormal];
        }
    }
    
}
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.type == UIEventSubtypeMotionShake)
    {
        [map showAllMines];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
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
