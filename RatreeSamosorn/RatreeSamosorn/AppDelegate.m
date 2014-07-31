//
//  AppDelegate.m
//  RatreeSamosorn
//
//  Created by Pariwat on 7/30/14.
//  Copyright (c) 2014 platwofusion. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.update = [[PFUpdateViewController alloc] init];
    self.menu = [[PFMenuViewController alloc] init];
    self.member = [[PFMemberViewController alloc] init];
    self.contact = [[PFContactViewController alloc] init];
    
    if (IS_WIDESCREEN) {
        self.update = [[PFUpdateViewController alloc] initWithNibName:@"PFUpdateViewController_Wide" bundle:nil];
        self.menu = [[PFMenuViewController alloc] initWithNibName:@"PFMenuViewController_Wide" bundle:nil];
        self.member = [[PFMemberViewController alloc] initWithNibName:@"PFMemberViewController_Wide" bundle:nil];
        self.contact = [[PFContactViewController alloc] initWithNibName:@"PFContactViewController_Wide" bundle:nil];
        
    } else {
        self.update = [[PFUpdateViewController alloc] initWithNibName:@"PFUpdateViewController" bundle:nil];
        self.menu = [[PFMenuViewController alloc] initWithNibName:@"PFMenuViewController" bundle:nil];
        self.member = [[PFMemberViewController alloc] initWithNibName:@"PFMemberViewController" bundle:nil];
        self.contact = [[PFContactViewController alloc] initWithNibName:@"PFContactViewController" bundle:nil];
        
    }
    
    self.tabBarViewController = [[PFTabBarViewController alloc] initWithBackgroundImage:nil viewControllers:self.update,self.menu,self.member,self.contact,nil];
    
    self.update.delegate = self;
    self.menu.delegate = self;
    self.member.delegate = self;
    self.contact.delegate = self;
    
    if(IS_WIDESCREEN){
        
        PFTabBarItemButton *item0 = [self.tabBarViewController.itemButtons objectAtIndex:0];
        [item0 setHighlightedImage:[UIImage imageNamed:@"en_update_on"]];
        [item0 setStanbyImage:[UIImage imageNamed:@"en_update_off"]];
        
        PFTabBarItemButton *item1 = [self.tabBarViewController.itemButtons objectAtIndex:1];
        [item1 setHighlightedImage:[UIImage imageNamed:@"en_menu_on"]];
        [item1 setStanbyImage:[UIImage imageNamed:@"en_menu_off"]];
        
        PFTabBarItemButton *item2 = [self.tabBarViewController.itemButtons objectAtIndex:2];
        [item2 setHighlightedImage:[UIImage imageNamed:@"en_member_on"]];
        [item2 setStanbyImage:[UIImage imageNamed:@"en_member_off"]];
        
        PFTabBarItemButton *item3 = [self.tabBarViewController.itemButtons objectAtIndex:3];
        [item3 setHighlightedImage:[UIImage imageNamed:@"en_contact_on"]];
        [item3 setStanbyImage:[UIImage imageNamed:@"en_contact_off"]];
        
    }else{
        
        PFTabBarItemButton *item0 = [self.tabBarViewController.itemButtons objectAtIndex:0];
        [item0 setHighlightedImage:[UIImage imageNamed:@"en_update_on"]];
        [item0 setStanbyImage:[UIImage imageNamed:@"en_update_off"]];
        
        PFTabBarItemButton *item1 = [self.tabBarViewController.itemButtons objectAtIndex:1];
        [item1 setHighlightedImage:[UIImage imageNamed:@"en_menu_on"]];
        [item1 setStanbyImage:[UIImage imageNamed:@"en_menu_off"]];
        
        PFTabBarItemButton *item2 = [self.tabBarViewController.itemButtons objectAtIndex:2];
        [item2 setHighlightedImage:[UIImage imageNamed:@"en_member_on"]];
        [item2 setStanbyImage:[UIImage imageNamed:@"en_member_off"]];
        
        PFTabBarItemButton *item3 = [self.tabBarViewController.itemButtons objectAtIndex:3];
        [item3 setHighlightedImage:[UIImage imageNamed:@"en_contact_on"]];
        [item3 setStanbyImage:[UIImage imageNamed:@"en_contact_off"]];
        
    }
    
    [self.tabBarViewController setSelectedIndex:3];
    [self.tabBarViewController setSelectedIndex:2];
    [self.tabBarViewController setSelectedIndex:1];
    [self.tabBarViewController setSelectedIndex:0];
    
    [self.window setRootViewController:self.tabBarViewController];
    [self.window makeKeyAndVisible];
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

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return (UIInterfaceOrientationMaskAll);
}

- (void)HideTabbar {
    [self.tabBarViewController hideTabBarWithAnimation:YES];
}

- (void)ShowTabbar {
    [self.tabBarViewController showTabBarWithAnimation:YES];
}

@end
