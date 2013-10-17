#import "BrSliderController.h"
#import "BrGlobals.h"

typedef enum : short {
  kSliderEmotion_sad = -2,
  kSliderEmotion_anxious = -1,
  kSliderEmotion_bored = 0,
  kSliderEmotion_calm = 1,
  kSliderEmotion_happy = 2
} BrSliderEmotionType;

typedef enum : NSInteger {
  kTagSliderEmotion = 3030,
  kTagImageViewEmotion,
  kTagLabelEmotion,
  kTagLabelEmotionValue,
  kTagEmotions,
  kTagOffice,
  kTagScience,
  kTagWeather
} view_tags;

static NSString *const k_ai_slider_emotion = @"emotions";
static NSString *const k_ai_image_view_emoticon = @"emoticon";
static NSString *const k_ai_label_emotion = @"emotion description";
static NSString *const k_ai_label_emotion_val = @"emotion value";

@interface BrSliderController ()

- (BrSliderEmotionType) emotionTypeForFloat:(CGFloat) aValue;

- (NSString *) stringForEmotionType:(BrSliderEmotionType) aEmotionType;
- (NSString *) stringForEmotionLabelWithType:(BrSliderEmotionType) aEmotionType;


- (UIImage *) imageForEmotionType:(BrSliderEmotionType) aEmotionType;

- (void) handleEmotionSliderDidChange:(UISlider *) aSlider;

@end

@implementation BrSliderController

@synthesize frames = _frames;
@synthesize sliderEmotion = _sliderEmotion;
@synthesize imageViewEmotion = _imageViewEmotion;
@synthesize labelEmotion = _labelEmotion;

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
	// Do any additional setup after loading the view, typically from a nib.
  self.view.accessibilityIdentifier = @"sliders";
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
  
  [super viewDidUnload];
}


#pragma mark - Actions

- (IBAction) sliderValueDidChange:(UISlider *) aSlider {
  if (aSlider == _sliderEmotion) {
    [self handleEmotionSliderDidChange:aSlider];
  }
}

- (void) handleEmotionSliderDidChange:(UISlider *) aSlider {
  CGFloat value =  (CGFloat)aSlider.value;
  BrSliderEmotionType et = [self emotionTypeForFloat:value];
  [self labelEmotion].text = [self stringForEmotionLabelWithType:et];
  [self labelEmotionFloat].text = [NSString stringWithFormat:@"%.2f", value];
  UIImageView *iv = [self imageViewEmotion];
  iv.image = [self imageForEmotionType:et];
  iv.accessibilityLabel = [self stringForEmotionType:et];
}

- (BrSliderEmotionType) emotionTypeForFloat:(CGFloat) aValue {
  if (aValue < -1.5) { return kSliderEmotion_sad; }
  if (aValue >= -1.5 && aValue < -0.5) { return kSliderEmotion_anxious; }
  if (aValue >= -0.5 && aValue < 0.5) { return kSliderEmotion_bored; }
  if (aValue >= 0.5 && aValue < 1.5) { return kSliderEmotion_calm; }
  return kSliderEmotion_happy;
}

- (NSString *) stringForEmotionType:(BrSliderEmotionType) aEmotionType {
  switch (aEmotionType) {
    case kSliderEmotion_sad: { return NSLocalizedString(@"sad", nil); }
    case kSliderEmotion_anxious: { return NSLocalizedString(@"anxious", nil); }
    case kSliderEmotion_bored: { return NSLocalizedString(@"bored", nil); }
    case kSliderEmotion_calm: { return NSLocalizedString(@"calm", nil); }
    case kSliderEmotion_happy: { return NSLocalizedString(@"happy", nil); }
  }
}

- (NSString *) stringForEmotionLabelWithType:(BrSliderEmotionType) aEmotionType {
  NSString *name = [self stringForEmotionType:aEmotionType];
  return [name stringByAppendingFormat:@": '%d'",  aEmotionType];
}

- (UIImage *) imageForEmotionType:(BrSliderEmotionType) aEmotionType {
  NSString *emotionName = [self stringForEmotionType:aEmotionType];
  NSString *imageName = [NSString stringWithFormat:@"emoticon-%@-40x40", emotionName];
  return [UIImage imageNamed:imageName];
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

- (void) viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
}


- (void) viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
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
  _sliderEmotion.accessibilityIdentifier = k_ai_slider_emotion;
  _imageViewEmotion.accessibilityIdentifier = k_ai_image_view_emoticon;
  _imageViewEmotion.accessibilityLabel = @"FIXME";
  _labelEmotion.accessibilityIdentifier = k_ai_label_emotion;
  _labelEmotionFloat.accessibilityIdentifier = k_ai_label_emotion_val;
}

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  //[self layoutSubviewsForCurrentOrientation:[self viewsToRotate]];
  
  _sliderEmotion.value = 0.0;
  [self handleEmotionSliderDidChange:[self sliderEmotion]];
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
