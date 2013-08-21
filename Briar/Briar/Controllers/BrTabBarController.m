#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "BrTabBarController.h"

@interface BrTabBarController ()

@end

@implementation BrTabBarController

#pragma mark - iOS 6

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) aInterfaceOrientation {
  return YES;
}

#pragma mark - iOS 7


- (NSUInteger) supportedInterfaceOrientations {
  return [[self selectedViewController] supportedInterfaceOrientations];
}

- (BOOL) shouldAutorotate {
  return [[self selectedViewController] supportedInterfaceOrientations];
}


@end
