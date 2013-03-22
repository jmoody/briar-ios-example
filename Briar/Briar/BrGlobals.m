#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "BrGlobals.h"

@interface BrGlobals ()

@end

@implementation BrGlobals

#pragma mark Memory Management
// static only
- (id) init {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

+ (BOOL) isDeviceIphone5 {
  CGRect screenBounds = [[UIScreen mainScreen] bounds];
  return (screenBounds.size.height == 568);
}

@end
