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
  bar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9f];
}

#pragma mark - Orientation / Rotation

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
  return [[[self viewControllers] lastObject] supportedInterfaceOrientations];
}
#else
- (NSUInteger) supportedInterfaceOrientations {
  return [[[self viewControllers] lastObject] supportedInterfaceOrientations];
}
#endif

- (BOOL) shouldAutorotate {
  return [[[self viewControllers] lastObject] shouldAutorotate];
}

@end
