#import "BrDatePickerController.h"
#import "BrCategories.h"

static NSString *const kIdButtonShowPicker = @"show picker";


@interface BrDatePickerController ()

@property (nonatomic, strong) BrDatePickerView *pickerView;

- (void) buttonTouchedDoneDatePicking:(id) sender;

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

- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.view.accessibilityIdentifier = @"date related";
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
  [self setButtonShowPicker:nil];
  [super viewDidUnload];
}

- (BrDatePickerView *) pickerView {
  if (_pickerView != nil) { return _pickerView; }
  _pickerView = [[BrDatePickerView alloc]
                 initWithDate:[NSDate date]
                 delegate:self];
  
  return _pickerView;
}


#pragma mark - Actions

- (void) buttonTouchedDoneDatePicking:(id)sender {
  NSLog(@"done date editing button touched");
}


- (IBAction)buttonTouchedShowPicker:(id)sender {
  NSLog(@"show picker button touched");
  
  self.buttonShowPicker.hidden = YES;
  typeof(self) wself = self;
  [BrDatePickerAnimationHelper
   animateDatePickerOnWithController:wself
   animations:^{
     
   } completion:^(BOOL finished) {
     wself.buttonShowPicker.alpha = 0;
   }];
}

#pragma mark - Animations


#pragma mark - RuAddMealPickerView Delegate

- (void) datePickerViewCancelButtonTouched {
  NSLog(@"cancel date picking button touched");
  typeof(self) wself = self;
  [BrDatePickerAnimationHelper
   animateDatePickerOffWithController:wself
   before:^{
     wself.buttonShowPicker.hidden = NO;
   } animations:^{
     
     wself.buttonShowPicker.alpha = 1;
   } completion:^(BOOL finished) {
     
   }];
}

- (void) datePickerViewDoneButtonTouchedWithDate:(NSDate *)aDate {
  NSLog(@"picker view done button touched with date: %@",  [aDate debugDescription]);
  
  typeof(self) wself = self;
  [BrDatePickerAnimationHelper
   animateDatePickerOffWithController:wself
   before:^{
     wself.buttonShowPicker.hidden = NO;
   } animations:^{
     wself.buttonShowPicker.alpha = 1;
   } completion:^(BOOL finished) {
     
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
    UIInterfaceOrientation l = UIInterfaceOrientationLandscapeLeft;
    UIInterfaceOrientation r = UIInterfaceOrientationLandscapeRight;
    UIInterfaceOrientation t = UIInterfaceOrientationPortraitUpsideDown;
    UIInterfaceOrientation b = UIInterfaceOrientationPortrait;
    UIInterfaceOrientation o = aOrientation;
    if ([kIdButtonShowPicker isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(185, 40, 111, 44); }
    if ([kIdButtonShowPicker isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(105, 56, 111, 44); }
    [_frames setObject:NSStringFromCGRect(frame) forKey:key];
  }
  return frame;
}

- (NSArray *) viewsToRotate {
  if (self.buttonShowPicker == nil) { return @[]; }
  
  return @[self.buttonShowPicker];
}

#pragma mark - Orientation



#pragma mark - iOS 6 Rotations

- (NSUInteger) supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (BOOL) shouldAutorotate {
  // from the docs - this is the default
  return YES;
}


#pragma mark - View Lifecycle


- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.buttonShowPicker.accessibilityIdentifier = kIdButtonShowPicker;
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
