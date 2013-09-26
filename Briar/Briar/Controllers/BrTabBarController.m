#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "BrTabBarController.h"

@interface BrTabBarController ()

@end

@implementation BrTabBarController

- (id) init {
  self = [super init];
  if (self) {
  }
  return self;
}

- (void) viewDidLoad {
  [super viewDidLoad];
  UITabBar *bar = [self tabBar];
  SEL selector = @selector(setTranslucent:);
  if ([bar respondsToSelector:selector]) {
    bar.translucent = YES;
  }
  bar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
}

#pragma mark - iOS 5

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) aInterfaceOrientation {
  return [[self selectedViewController] shouldAutorotateToInterfaceOrientation:aInterfaceOrientation];
}

#pragma mark - iOS 6


- (NSUInteger) supportedInterfaceOrientations {
  return [[self selectedViewController] supportedInterfaceOrientations];
}

- (BOOL) shouldAutorotate {
  return [[self selectedViewController] shouldAutorotate];
}


@end
