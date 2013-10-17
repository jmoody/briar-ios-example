#import "BrSliderController.h"
#import "BrGlobals.h"
#import "BrSliderView.h"

typedef enum : NSInteger {
  kTagEmotions = 3030,
  kTagOffice,
  kTagScience,
  kTagWeather
} view_tags;


@interface BrSliderController ()

@property (nonatomic, strong, readonly) BrSliderView *sliderEmotions;

@end

@implementation BrSliderController

@synthesize frames = _frames;
@synthesize sliderEmotions = _sliderEmotions;

- (id)init {
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"Sliders", @"slider controller:  title of slider tab bar item");
    self.tabBarItem.image = [UIImage imageNamed:@"833-diamond"];
    self.navbarTitle = @"Slider Related";
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
  
  [super viewDidUnload];
}

#pragma mark - Animations


#pragma mark - Gestures


#pragma mark - Orientation iOS 5


#pragma mark - Orientation iOS 6
  
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation) aFromInterfaceOrientation {
  
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval) aDuration {
  __weak typeof(self) wself = self;
  [UIView animateWithDuration:aDuration
                   animations:^{
                     [wself layoutSubviewsForCurrentOrientation:[wself viewsToRotate]];
                   }];
}


#pragma mark - View Layout

- (BrSliderView *) sliderEmotions {
  if (_sliderEmotions != nil) { return _sliderEmotions; }
  CGRect frame = CGRectMake(10, 80, 300, 88);
  _sliderEmotions = [[BrSliderView alloc]
                     initWithFrame:frame
                     type:BrSliderEmotion
                     tag:kTagEmotions
                     didChangeBlock:^(UISlider *aSlider, BrSliderViewType aType) {
                       NSLog(@"emotion slider updated");
                     }];
  _sliderEmotions.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.1];
  return _sliderEmotions;
}


- (void) viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
}


- (void) viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  UIView *view = self.view;
  if ([view viewWithTag:kTagEmotions] == nil) {
    [view addSubview:[self sliderEmotions]];
  }
}

- (CGRect) frameForView:(UIView *) aView
            orientation:(UIInterfaceOrientation) aOrientation {
  NSString *aid = aView.accessibilityIdentifier;
  NSString *key = [NSString stringWithFormat:@"%@ - %d", aid, aOrientation];
  NSString *str = [self.frames objectForKey:key];
  CGRect frame = CGRectZero;
  if (str != nil) {
    frame = CGRectFromString(str);
  } else {
    /*
    
    UIInterfaceOrientation l = UIInterfaceOrientationLandscapeLeft;
    UIInterfaceOrientation r = UIInterfaceOrientationLandscapeRight;
    UIInterfaceOrientation t = UIInterfaceOrientationPortraitUpsideDown;
    UIInterfaceOrientation b = UIInterfaceOrientationPortrait;
    UIInterfaceOrientation o = aOrientation;
    CGFloat ipadYAdj = br_is_ipad() ? 20 : 0;
    
    
    if ([kIdTopTf isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(20, 64 + ipadYAdj, 210, 30); }
    if ([kIdBottomTf isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(20, 108 + ipadYAdj , 210, 30); }
    if ([kIdTopTf isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 84, 280, 30); }
    if ([kIdBottomTf isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 124, 280, 30); }

    if ([kIdTopTv isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(250, 64 + ipadYAdj, 210, 30); }
    if ([kIdBottomTv isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(250, 108 + ipadYAdj, 210, 30); }
    if ([kIdTopTv isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 160, 280, 30); }
    if ([kIdBottomTv isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 196, 280, 30); }
    
    if ([kIdButton isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(95, 269, 230, 44); }
    if ([kIdButton isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(330, 158 + ipadYAdj, 230, 44); }

    
    [_frames setObject:NSStringFromCGRect(frame) forKey:key];
     */
  }
     
  return frame;
}

- (NSArray *) viewsToRotate {
  return [NSArray array];
  /*
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:4];
  if (_textFieldTop != nil) { [array addObject:_textFieldTop]; }
  if (_textFieldBottom != nil) { [array addObject:_textFieldBottom]; }
  if (_textViewTop != nil) { [array addObject:_textViewTop]; }
  if (_textViewBottom != nil) { [array addObject:_textViewBottom]; }
  if (_button != nil) { [array addObject:_button]; }
  return [NSArray arrayWithArray:array];
   */
}

#pragma mark - Accessibility

- (void) configureAccessibility {
  self.view.accessibilityIdentifier = @"sliders";
}

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  //[self layoutSubviewsForCurrentOrientation:[self viewsToRotate]];
  self.view.accessibilityIdentifier = @"sliders";
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
