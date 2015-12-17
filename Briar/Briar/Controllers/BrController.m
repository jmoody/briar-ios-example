// Copyright 2013 Little Joy Software. All rights reserved.
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in
//       the documentation and/or other materials provided with the
//       distribution.
//     * Neither the name of the Little Joy Software nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY LITTLE JOY SOFTWARE ''AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL LITTLE JOY SOFTWARE BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
// OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
// IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "BrController.h"
#import "BrGlobals.h"

@interface BrController ()

- (void) postInitConfiguration;

@end

@implementation BrController

@synthesize frames = _frames;

#pragma mark Memory Management

- (void) dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id) initNibless {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    [self postInitConfiguration];
  }
  return self;
}

/*** UNEXPECTED ***
 yeah yeah yeah, i hear you.  this is completely non standard, but i do not like
 chasing nib names across refactorings.
 
 the convention is that the .xib _must_ match the controller name
 *****************/
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (id) init {
  NSString *nibName = [NSString stringWithFormat:@"%@", [self class]];
  self = [super initWithNibName:nibName bundle:nil];
  if (self) {
    [self postInitConfiguration];
  }
  return self;
}

- (void) postInitConfiguration {
  self.navbarTitle = nil;
  self.wantsFullScreenLayout = YES;
  
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
  SEL selector = @selector(setAutomaticallyAdjustsScrollViewInsets:);
  if ([self respondsToSelector:selector]) {
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
  }
#endif
}


- (void) didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  NSLog(@"did receive memory warning");
}


#pragma mark Orientation


- (NSString *) stringForOrientation:(UIInterfaceOrientation) aOrientation {
  switch (aOrientation) {
    case UIInterfaceOrientationPortrait: { return @"portrait"; }
    case UIInterfaceOrientationLandscapeLeft: { return @"right"; }
    case UIInterfaceOrientationLandscapeRight: { return @"left"; }
    case UIInterfaceOrientationPortraitUpsideDown: { return @"up-side down"; }
    default: { return @"unknown"; }
  }
}

- (NSArray *) viewsToRotate {
  return @[];
}

- (void) layoutSubviewsForCurrentOrientation:(NSArray *) aViews {
  UIInterfaceOrientation o = self.interfaceOrientation;
  for (UIView *view in aViews) {
    CGRect frame = [self frameForView:view orientation:o];
    view.frame = frame;
  }
}

- (CGRect) frameForView:(UIView *) aView
            orientation:(UIInterfaceOrientation) aOrientation {
  // nop subclasses should implement
  return aView.frame;
}


- (NSMutableDictionary *) frames {
  if (_frames != nil) { return _frames; }
  _frames = [[NSMutableDictionary alloc] initWithCapacity:8];
  return _frames;
}


#pragma mark - Orientation / Rotation

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskAll;
}
#else
- (NSUInteger) supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskAll;
}
#endif

- (BOOL) shouldAutorotate {
  return YES;
}

#pragma mark - View Layout

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
- (UIStatusBarStyle) preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}
#endif


- (void)viewDidLoad {
  [super viewDidLoad];
  
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
  SEL selector = @selector(setNeedsStatusBarAppearanceUpdate);
  if ([self respondsToSelector:selector]) {
    [self setNeedsStatusBarAppearanceUpdate];
  }
#endif
  
  if (br_is_iOS_7() == NO) {
    NSString *backButtonTitle = NSLocalizedString(@"Back", nil);
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:backButtonTitle
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
  }
  
}

- (void) viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
}

- (void) viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
}

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  NSString *nbt = self.navbarTitle;
  if (nbt != nil && [nbt length] != 0) {
    self.navigationItem.title = self.navbarTitle;
  }
  UINavigationBar *navbar = self.navigationController.navigationBar;
  navbar.translucent = YES;
  navbar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9f];

 
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

@end
