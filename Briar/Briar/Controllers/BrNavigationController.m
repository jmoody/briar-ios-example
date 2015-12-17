#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "BrNavigationController.h"
#import "BrController.h"

@interface BrNavigationController ()

- (void) updateViewRotation;

@end

@implementation BrNavigationController

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

- (void) updateViewRotation {
  [UIViewController attemptRotationToDeviceOrientation];
  BrController *con = (BrController *)[self topViewController];
  [con layoutSubviewsForCurrentOrientation:[con viewsToRotate]];
  double delayInSeconds = 0.2;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    UIViewController *vc = [[UIViewController alloc] init];
    [self presentViewController:vc animated:NO completion:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
  });
}

@end
