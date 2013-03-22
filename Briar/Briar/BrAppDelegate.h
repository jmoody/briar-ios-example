//
//  BRAppDelegate.h
//  Briar
//
//  Created by Joshua Moody on 3.3.13.
//  Copyright (c) 2013 Little Joy Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@end
