#import "BrAppDelegate.h"
#import "BrFirstViewController.h"
#import "BrTextRelatedController.h"
#import "BrDatePickerController.h"
#import "BrCategories.h"
#import "BrTableController.h"

typedef enum : NSUInteger {
  kTagSecurityVeil = NSNotFound
} view_tags;



@interface UIDatePicker (CALABASH_ADDITIONS)
- (NSString *) hasCalabashAdditions:(NSString *) aSuccessIndicator;
- (BOOL) setDateWithString:(NSString *)aString
                    format:(NSString *) aFormat
                  animated:(BOOL) aAnimated;
@end


@implementation UIDatePicker (CALABASH_ADDITIONS)
- (NSString *) hasCalabashAdditions:(NSString *) aSuccessIndicator {
  return aSuccessIndicator;
}

- (BOOL) setDateWithString:(NSString *)aString
                    format:(NSString *) aFormat
                  animated:(BOOL) aAnimated {
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:aFormat];
  NSDate *date = [df dateFromString:aString];
  if (date == nil) return NO;
  [self setDate:date animated:aAnimated];
  return YES;
}


@end

typedef enum : NSUInteger {
  kTabbarIndexFirst = 0,
  kTabbarIndexText,
  kTabbarIndexDate,
} BrTabbarIndex;


@interface BrAppDelegate ()

// calabash backdoor
- (NSString *) calabash_backdoor_reset_app:(NSString *) aIgnorable;
- (NSString *) calabash_backdoor_configured_for_mail:(NSString *) aIgnoreable;
- (NSString *) calabash_backdoor_add_security_veil_to_main_window:(NSString *) aIgnorable;

- (void) handleTouchOnSecurityVeil:(UITapGestureRecognizer *) aRecognizer;

@end

@implementation BrAppDelegate

- (NSString *) calabash_backdoor_configured_for_mail:(NSString *) aIgnoreable {
  return [MFMailComposeViewController canSendMail] ? @"YES" : @"NO";
}

// implementation
- (NSString *) calabash_backdoor_add_security_veil_to_main_window:(NSString *) aIgnorable {
  if ([self.window viewWithTag:kTagSecurityVeil] != nil) {
    NSString *msg = @"ERROR: security veil already in place - something is amiss - will not add another";
    NSLog(msg);
    return msg;
  }
  
  CGRect frame = self.window.frame;
  UIView *veil = [[UIView alloc] initWithFrame:frame];
  [veil setYWithY:frame.size.height * -1.0];
  veil.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blueprint-background-320x480"]];
  veil.tag = kTagSecurityVeil;
  veil.accessibilityIdentifier = @"security veil";
  UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(handleTouchOnSecurityVeil:)];
  tgr.numberOfTapsRequired = 1;
  tgr.numberOfTouchesRequired = 1;
  veil.userInteractionEnabled = YES;
  [veil addGestureRecognizer:tgr];


  [self.window addSubview:veil];
  
  
  
  [UIView animateWithDuration:0.4
                        delay:0.0
                      options:UIViewAnimationOptionCurveLinear
                   animations:^{
                     [veil setYWithY:0];
                   } completion:^(BOOL finished) {
                     // nada
                   }];
  return @"YES";
}

- (NSString *) calabash_backdoor_reset_app:(NSString *)aIgnorable {
  
  // dismiss any alerts or sheets
  [[UIApplication sharedApplication].windows mapc:^(UIWindow *window, NSUInteger idx0, BOOL *stop0) {
    [[window subviews] mapc:^(UIView *view, NSUInteger idx1, BOOL *stop1) {
      if ([view respondsToSelector:@selector(dismissWithClickedButtonIndex:animated:)]) {
        if ([view respondsToSelector:@selector(dismissWithClickedButtonIndex:animated:)]) {
          id dismissible = (id) view;
          [dismissible dismissWithClickedButtonIndex:1 animated:YES];
        }
      }
      NSArray *subs = [view subviews];
      [subs mapc:^(UIView *sv, NSUInteger idx2, BOOL *stop2) {
        if ([sv respondsToSelector:@selector(dismissWithClickedButtonIndex:animated:)]) {
          id dismissible = (id) sv;
          [dismissible dismissWithClickedButtonIndex:1 animated:YES];
        }
      }];
    }];
  }];

  // dismiss the security veil if it exists
  UIView *veil = [self.window viewWithTag:kTagSecurityVeil];
  if (veil != nil) { [veil removeFromSuperview]; }
  

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
      BrFirstViewController *fvc = (BrFirstViewController *)top;
      if (fvc.sheet.visible == YES) { [fvc actionSheetCancel:fvc.sheet]; }      
    } else if (idx == kTabbarIndexText) {
      
    } else if (idx == kTabbarIndexDate) {
      
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

#pragma mark - Handle Events and Touches

- (void) handleTouchOnSecurityVeil:(UITapGestureRecognizer *) aRecognizer {
  UIGestureRecognizerState state = [aRecognizer state];
  if (UIGestureRecognizerStateEnded == state) {
    UIView *view = [self.window viewWithTag:kTagSecurityVeil];
    if (view != nil) { [view removeFromSuperview]; }
  }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  
  UIViewController *fvc = [BrFirstViewController new];
  UINavigationController *fnbc = [[UINavigationController alloc]
                                  initWithRootViewController:fvc];
  
  UIViewController *svc = [BrTextRelatedController new];
  UINavigationController *snbc = [[UINavigationController alloc]
                                  initWithRootViewController:svc];
  

  UIViewController *dvc = [BrDatePickerController new];
  UINavigationController *ndvc = [[UINavigationController alloc]
                                  initWithRootViewController:dvc];
  
  UIViewController *tvc = [BrTableController new];
  UINavigationController *ntvc = [[UINavigationController alloc]
                                  initWithRootViewController:tvc];

  
  
  self.tabBarController = [[UITabBarController alloc] init];
  self.tabBarController.viewControllers = @[fnbc, snbc, ndvc, ntvc];
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
