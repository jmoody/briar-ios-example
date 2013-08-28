#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "BrTabBarController.h"

@interface BrTabBarController ()

@end

@implementation BrTabBarController

#pragma mark - iOS 5

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) aInterfaceOrientation {
  return [[self selectedViewController] shouldAutorotateToInterfaceOrientation:aInterfaceOrientation];
}

#pragma mark - iOS 6


- (NSUInteger) supportedInterfaceOrientations {
  return [[self selectedViewController] supportedInterfaceOrientations];
}

- (BOOL) shouldAutorotate {
  return [[self selectedViewController] supportedInterfaceOrientations];
}


@end
