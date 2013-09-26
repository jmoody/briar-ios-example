#import "BrDatePickerController.h"
#import "BrCategories.h"


typedef enum : NSInteger {
  kTagPickerView = 3030,
  kTagButtonTime,
  kTagButtonDate,
  kTagButtonDateAndTime
} view_tags;



@interface BrDatePickerController ()

@property (nonatomic, strong) BrDatePickerView *pickerView;

- (void) buttonTouchedDoneDatePicking:(id) sender;
- (void) setButtonsHidden:(BOOL) aHidden;
- (UIDatePickerMode) modeForButton:(UIButton *) aButton;
- (void) buttonTouched:(UIButton *) aButton;
- (BrDatePickerView *) pickerViewForMode:(UIDatePickerMode) aMode;

@end

@implementation BrDatePickerController

@synthesize pickerView = _pickerView;
@synthesize frames = _frames;

- (id) init {
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"Date", @"date picking controller: tab bar button");
    self.tabBarItem.image = [UIImage imageNamed:@"11-clock"];
  }
  return self;
}

- (void) configureAccessibility {
  [super configureAccessibility];
  self.view.accessibilityIdentifier = @"date related";
  self.buttonTime.accessibilityIdentifier = @"show time picker";
  self.buttonTime.tag = kTagButtonTime;
  self.buttonDate.accessibilityIdentifier = @"show date picker";
  self.buttonDate.tag = kTagButtonDate;
  self.buttonDateAndTime.accessibilityIdentifier = @"show date and time picker";
  self.buttonDateAndTime.tag = kTagButtonDateAndTime;
}


- (void)viewDidLoad {
  [super viewDidLoad];
  [self configureAccessibility];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
  [self setButtonTime:nil];
  [self setButtonDateAndTime:nil];
  [self setButtonDate:nil];
  [super viewDidUnload];
}

- (BrDatePickerView *) pickerView {
  return _pickerView;
}

- (BrDatePickerView *) pickerViewForMode:(UIDatePickerMode) aMode {
  return [[BrDatePickerView alloc]
                 initWithDate:[NSDate date]
                 delegate:self
                 mode:aMode];
}

#pragma mark - Actions

- (void) buttonTouchedDoneDatePicking:(id)sender {
  NSLog(@"done date editing button touched");
}


- (void) setButtonsHidden:(BOOL) aHidden {
  [@[self.buttonTime, self.buttonDate, self.buttonDateAndTime] mapc:^(UIButton *button,
                                                                      NSUInteger idx,
                                                                      BOOL *stop) {
    button.hidden = aHidden;
  }];

}

- (UIDatePickerMode) modeForButton:(UIButton *) aButton {
  if (self.buttonTime == aButton) { return UIDatePickerModeTime; }
  if (self.buttonDate == aButton) { return UIDatePickerModeDate; }
  if (self.buttonDateAndTime == aButton) { return UIDatePickerModeDateAndTime; }
  return NSNotFound;
}

- (void) buttonTouched:(UIButton *) aButton {
  UIDatePickerMode mode = [self modeForButton:aButton];
  _pickerView = [self pickerViewForMode:mode];
  
  [self setButtonsHidden:YES];
  
  typeof(self) wself = self;
  [BrDatePickerAnimationHelper
   animateDatePickerOnWithController:wself
   animations:^{
     
   } completion:^(BOOL finished) {
    
   }];
}

- (IBAction)buttonTouchedTime:(id)sender {
  NSLog(@"show picker button touched");
  [self buttonTouched:sender];
}

- (IBAction)buttonTouchedDateAndTime:(id)sender {
  NSLog(@"show picker button touched");
  [self buttonTouched:sender];
}

- (IBAction)buttonTouchedDate:(id)sender {
  NSLog(@"show picker button touched");
  [self buttonTouched:sender];
}



#pragma mark - RuAddMealPickerView Delegate

- (void) datePickerViewCancelButtonTouched {
  NSLog(@"cancel date picking button touched");
  typeof(self) wself = self;
  [BrDatePickerAnimationHelper
   animateDatePickerOffWithController:wself
   before:^{
     
   } animations:^{
     
   } completion:^(BOOL finished) {
     [wself setButtonsHidden:NO];
   }];
}

- (void) datePickerViewDoneButtonTouchedWithDate:(NSDate *)aDate {
  NSLog(@"picker view done button touched with date: %@",  [aDate debugDescription]);
  
  typeof(self) wself = self;
  [BrDatePickerAnimationHelper
   animateDatePickerOffWithController:wself
   before:^{

   } animations:^{

   } completion:^(BOOL finished) {
     [wself setButtonsHidden:NO];
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
  NSInteger tag = aView.tag;
  NSString *key = [NSString stringWithFormat:@"%d - %d", tag, aOrientation];
  NSString *str = [self.frames objectForKey:key];
  CGRect frame = CGRectZero;
  if (str != nil) {
    frame = CGRectFromString(str);
  } else {
    UIInterfaceOrientation l = UIInterfaceOrientationLandscapeLeft;
    UIInterfaceOrientation r = UIInterfaceOrientationLandscapeRight;
    UIInterfaceOrientation t = UIInterfaceOrientationPortraitUpsideDown;
    UIInterfaceOrientation b = UIInterfaceOrientationPortrait;
    UIInterfaceOrientation o = aOrientation;
    if (tag == kTagButtonTime && (l == o || r == o)) { frame = CGRectMake(20, 64, 55, 44); }
    if (tag == kTagButtonTime && (t == o || b == o)) { frame = CGRectMake(20, 70, 55, 44); }

    if (tag == kTagButtonDateAndTime && (l == o || r == o)) { frame = CGRectMake(189, 64, 103, 44); }
    if (tag == kTagButtonDateAndTime && (t == o || b == o)) { frame = CGRectMake(109, 70, 103, 44); }
    
    if (tag == kTagButtonDate && (l == o || r == o)) { frame = CGRectMake(403, 64, 55, 44); }
    if (tag == kTagButtonDate && (t == o || b == o)) { frame = CGRectMake(245, 70, 55, 44); }

    [_frames setObject:NSStringFromCGRect(frame) forKey:key];
  }
  return frame;
}

- (NSArray *) viewsToRotate {
  NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
  if (self.buttonTime != nil) { [array addObject:self.buttonTime]; }
  if (self.buttonDate != nil) { [array addObject:self.buttonDate]; }
  if (self.buttonDateAndTime != nil) { [array addObject:self.buttonDateAndTime]; }
  return array;
}

#pragma mark - Orientation

#pragma mark - iOS 5 Rotations

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) aInterfaceOrientation {
  return aInterfaceOrientation == UIInterfaceOrientationPortrait ||
  aInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown;
}

#pragma mark - iOS 6 Rotations

- (NSUInteger) supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (BOOL) shouldAutorotate {
  return YES;
}


#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self layoutSubviewsForCurrentOrientation:[self viewsToRotate]];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self datePickerViewCancelButtonTouched];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}


@end
