#import "BRAppDelegate.h"
#import "BRFirstViewController.h"
#import "BRTextRelatedController.h"
#import "BRCategories.h"

typedef enum : NSUInteger {
  kTabbarIndexFirst = 0,
  kTabbarIndexSecond
} BrTabbarIndex;


@interface BRAppDelegate ()

- (NSString *) calabashBackdoor:(NSString *) aIgnorable;

@end

@implementation BRAppDelegate

- (NSString *) calabashBackdoor:(NSString *)aIgnorable {
  
  [[self.tabBarController viewControllers] mapc:^(UINavigationController *navcon,
                                                  NSUInteger idx, BOOL *stop) {
    
    UIViewController *top = [navcon topViewController];
    // dismiss any modal windows
    if ([top presentedViewController] != nil) {
      [top dismissViewControllerAnimated:NO
                              completion:nil];
      
    }
    
    // animated appears to be necessary???
    // otherwise checkin view controllers crash with bad access
    [navcon popToRootViewControllerAnimated:YES];
    
    if (idx == kTabbarIndexFirst) {
      BRFirstViewController *fvc = (BRFirstViewController *)top;
      if (fvc.sheet.visible == YES) { [fvc actionSheetCancel:fvc.sheet]; }      
    } else if (idx == kTabbarIndexSecond) {
      
    } else {
      
    }
  }];
  

  // also there are several action sheets that present on the key window that
  // need to be dismissed and the keyboards...
  [[[[UIApplication sharedApplication] keyWindow] subviews] mapc:^(UIView *view,
                                                                   NSUInteger outerIdx,
                                                                   BOOL *outerStop) {
    
    NSArray *subs = [view subviews];
    [subs mapc:^(UIView *sv, NSUInteger innerIdx, BOOL *innerStop) {
      if ([sv isKindOfClass:[UIActionSheet class]]) {
        UIActionSheet *as = (UIActionSheet *)sv;
        [as dismissWithClickedButtonIndex:1 animated:YES];
      }
    }];
  }];
  
  [self.tabBarController setSelectedIndex:kTabbarIndexFirst];
  return @"YES";
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  
  UIViewController *fvc = [[BRFirstViewController alloc]
                                       initWithNibName:@"BRFirstViewController"
                                       bundle:nil];
  UINavigationController *fnbc = [[UINavigationController alloc]
                                  initWithRootViewController:fvc];
  
  UIViewController *svc = [[BRTextRelatedController alloc]
                                       initWithNibName:@"BRSecondViewController"
                                       bundle:nil];
  UINavigationController *snbc = [[UINavigationController alloc]
                                  initWithRootViewController:svc];
  
  self.tabBarController = [[UITabBarController alloc] init];
  self.tabBarController.viewControllers = @[fnbc, snbc];
  self.window.rootViewController = self.tabBarController;
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state.
  // This can occur for certain types of temporary interruptions (such as an
  // incoming phone call or SMS message) or when the user quits the application
  // and it begins the transition to the background state.  Use this method to
  // pause ongoing tasks, disable timers, and throttle down OpenGL ES frame
  // rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate
  // timers, and store enough application state information to restore your
  // application to its current state in case it is terminated later.  If your
  // application supports background execution, this method is called instead
  // of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state;
  // here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the
  // application was inactive. If the application was previously in the
  // background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if
  // appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
