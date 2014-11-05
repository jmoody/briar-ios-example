#import "BrAppDelegate.h"
#import "BrButtonViewController.h"
#import "BrTextRelatedController.h"
#import "BrDatePickerController.h"
#import "BrWebViewController.h"
#import "BrCategories.h"
#import "BrNavigationController.h"
#import "BrSliderController.h"
#import "BrGlobals.h"
#import <dlfcn.h>
#import "BrScrollingHomeController.h"

@implementation BrWindow

- (void) sendEvent:(UIEvent *)event {
  if (self.eventHandler != nil) {
    self.eventHandler(self, event);
  }
  [super sendEvent:event];
}

@end

typedef enum : NSUInteger {
  kTagSecurityVeil = NSNotFound
} view_tags;


@interface BrAppDelegate ()

// calabash backdoor
- (NSString *) calabash_backdoor_reset_app:(NSString *) aIgnorable;
- (NSString *) calabash_backdoor_configured_for_mail:(NSString *) aIgnoreable;
- (NSString *) calabash_backdoor_add_security_veil_to_main_window:(NSString *) aIgnorable;

- (void) handleTouchOnSecurityVeil:(UITapGestureRecognizer *) aRecognizer;

@end

@implementation BrAppDelegate


- (void) loadReveal {
  if (br_is_iOS_7() == NO) {
    NSLog(@"skipping Reveal on iOS 5 and 6 because it causes problems on XTC");
    return;
  }
  
  NSString *revealLibName = @"libReveal";
  NSString *revealLibExtension = @"dylib";
  NSString *dyLibPath = [[NSBundle mainBundle] pathForResource:revealLibName ofType:revealLibExtension];
  NSLog(@"Loading dynamic library: %@", dyLibPath);
  
  void *revealLib = NULL;
  revealLib = dlopen([dyLibPath cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
  
  if (revealLib == NULL) {
    char *error = dlerror();
    NSString *message = [NSString stringWithFormat:@"%@.%@ failed to load with error: %s", revealLibName, revealLibExtension, error];
    NSLog(message);
  }
}


- (NSString *) calabash_backdoor_configured_for_mail:(NSString *) aIgnoreable {
  return [MFMailComposeViewController canSendMail] ? @"YES" : @"NO";
}

- (NSString *) calabash_backdoor_add_security_veil_to_main_window:(NSString *) aIgnorable {
  if ([self.window viewWithTag:kTagSecurityVeil] != nil) {
    NSString *msg = @"ERROR: security veil already in place - something is amiss - will not add another";
    NSLog(msg);
    return msg;
  }
  
  CGRect frame = self.window.frame;
  UIView *veil = [[UIView alloc] initWithFrame:frame];
  [veil setYWithY:frame.size.height * -1.0f];
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
  
  
  // starting in iOS 7 we started to see crashes when popping views that had
  // keyboards showing - so we send a resignFirstResponder to the app first
  // responder (to => nil ==> will be sent to any first responder)
  [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                             to:nil
                                           from:nil
                                       forEvent:nil];

  // the meal detail pickers are presented _over_ the tabbar on the key window
  // so we need to remove them if a scenario ends with the detail picker on the
  // view
  // also there are several action sheets that present on the key window that
  // need to be dismissed
  // and the keyboards...
  [[UIApplication sharedApplication].windows mapc:^(UIWindow *window, NSUInteger idx0, BOOL *stop0) {
    [[window subviews] mapc:^(UIView *view, NSUInteger idx1, BOOL *stop1) {
      
      if ([view respondsToSelector:@selector(dismissWithClickedButtonIndex:animated:)]) {
        if ([view respondsToSelector:@selector(dismissWithClickedButtonIndex:animated:)]) {
          id dismissible = (id) view;
          /*** BRITTLE: because might not have a cancel button **/
          NSInteger cancelIdx = [dismissible cancelButtonIndex];
          [dismissible dismissWithClickedButtonIndex:cancelIdx animated:NO];
        }
      }
      
      NSArray *subs = [view subviews];
      [subs mapc:^(UIView *sv, NSUInteger idx2, BOOL *stop2) {
        if ([sv respondsToSelector:@selector(dismissWithClickedButtonIndex:animated:)]) {
          id dismissible = (id) sv;
          /*** BRITTLE: because might not have a cancel button **/
          NSInteger cancelIdx = [dismissible cancelButtonIndex];
          [dismissible dismissWithClickedButtonIndex:cancelIdx animated:NO];
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
    
    if (idx == kTabbarIndexButtons) {

    } else if (idx == kTabbarIndexText) {
      
    } else if (idx == kTabbarIndexDate) {
      
    } else if (idx == kTabbarIndexTable){
      
    } else if (idx == kTabbarIndexSliders) {
      BrSliderController *scon = (BrSliderController *)[navcon topViewController];
      [scon resetSliders];
    } else if (idx == kTabbarIndexSliders) {
      
    }
  }];
  
  [self.tabBarController setSelectedIndex:kTabbarIndexButtons];
  return @"YES";
}


- (NSString *) stringForPreferencesPath:(NSString *) aIgnore {
  NSString *plistRootPath = nil, *relativePlistPath = nil;
  NSString *plistName = [NSString stringWithFormat:@"%@.plist", [[NSBundle mainBundle] bundleIdentifier]];

  // 1. get into the simulator's app support directory by fetching the sandboxed Library's path
  NSArray *userLibDirURLs = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];

  NSURL *userDirURL = [userLibDirURLs lastObject];
  NSString *userDirectoryPath = [userDirURL path];

  // 2. get out of our application directory, back to the root support directory for this system version
  if ([userDirectoryPath rangeOfString:@"CoreSimulator"].location == NSNotFound) {
    plistRootPath = [userDirectoryPath substringToIndex:([userDirectoryPath rangeOfString:@"Applications"].location)];
  } else {
    NSRange range = [userDirectoryPath rangeOfString:@"data"];
    plistRootPath = [userDirectoryPath substringToIndex:range.location + range.length];
  }

  // 3. locate, relative to here, /Library/Preferences/[bundle ID].plist
  relativePlistPath = [NSString stringWithFormat:@"Library/Preferences/%@", plistName];

  // 4. and unescape spaces, if necessary (i.e. in the simulator)
  NSString *unsanitizedPlistPath = [plistRootPath stringByAppendingPathComponent:relativePlistPath];
  return [[unsanitizedPlistPath stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] copy];
}

- (NSString *) stringForDefaultsDictionary:(NSString *) aIgnore {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults synchronize];
  NSDictionary *dictionary = [defaults dictionaryRepresentation];
  NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                 options:0
                                                   error:nil];
  NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  return string;
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
  self.window = [[BrWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  
  self.window.eventHandler = ^(UIWindow *aWindow, UIEvent *aEvent) {
    NSSet *touches = [aEvent touchesForWindow:aWindow];
    
    UIScreen *screen = [aWindow screen];
    CGRect __unused screenBounds = screen.bounds;
    //NSLog(@"screen bounds: '%@'", NSStringFromCGRect(screenBounds));
    //NSLog(@"window bounds: '%@'", NSStringFromCGRect(aWindow.bounds));
    [touches enumerateObjectsUsingBlock:^(UITouch *touch, BOOL *stop) {
      CGPoint point = [touch locationInView:aWindow];
      NSLog(@"location of touch in window: %@", NSStringFromCGPoint(point));
      NSLog(@"touched view: %@", [touch view]);
    }];
  };


  UIViewController *first_vc = [BrButtonViewController new];
  BrNavigationController *first_nc = [[BrNavigationController alloc]
                                  initWithRootViewController:first_vc];
  
  UIViewController *text_vc = [BrTextRelatedController new];
  BrNavigationController *text_nc = [[BrNavigationController alloc]
                                  initWithRootViewController:text_vc];
  

  UIViewController *date_vc = [BrDatePickerController new];
  BrNavigationController *date_nc = [[BrNavigationController alloc]
                                  initWithRootViewController:date_vc];
  
  //UIViewController *table_vc = [BrTableController new];
  UIViewController *scroll_vc = [BrScrollingHomeController new];
  BrNavigationController *scroll_nc = [[BrNavigationController alloc]
                                      initWithRootViewController:scroll_vc];

  UIViewController *slider_vc = [BrSliderController new];
  BrNavigationController *slider_nc = [[BrNavigationController alloc]
                                   initWithRootViewController:slider_vc];

  self.tabBarController = [[BrTabBarController alloc] init];
  self.tabBarController.viewControllers = @[first_nc, text_nc, date_nc, scroll_nc, slider_nc];
  self.tabBarController.delegate = self;
  
  
  self.window.rootViewController = self.tabBarController;
  [self.window makeKeyAndVisible];
  
  [self.tabBarController setSelectedIndex:kTabbarIndexButtons];
  
  [self loadReveal];

//#if TARGET_IPHONE_SIMULATOR
//  [[NSUserDefaults standardUserDefaults] setObject:@"BAR" forKey:@"FOO"];
//  NSLog(@"%@", [self stringForPreferencesPath:nil]);
//  NSLog(@"%@", [self stringForDefaultsDictionary:nil]);
//#endif


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


// Optional UITabBarControllerDelegate method.
- (void) tabBarController:(UITabBarController *) aTabBarController didSelectViewController:(UIViewController *) aViewController {
  BrNavigationController *navcon = (BrNavigationController *) aViewController;
  [navcon updateViewRotation];
}


/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
