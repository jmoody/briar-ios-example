#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "BrDatePickerView.h"
#import "BrGlobals.h"
#import "BRCategories.h"

#pragma mark - Animations


@implementation BrDatePickerAnimationHelper

+ (void) configureNavbarForDateEditingWithAnimation:(BOOL)animated
                                         controller:(UIViewController<BrDatePickerViewDelegate> *)aController {
  [aController.navigationItem setRightBarButtonItem:nil animated:NO];
  UIBarButtonItem *cancel = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                             target:aController
                             action:@selector(datePickerViewCancelButtonTouched)];
  cancel.accessibilityLabel = NSLocalizedString(@"cancel date picking",
                                                @"date: ACCESSIBILITY navbar/toolbar button - touching cancels date picking, rolling back any changes.");
  [aController.navigationItem setLeftBarButtonItem:cancel animated:animated];
}


+ (void) animateDatePickerOnWithController:(UIViewController<BrDatePickerViewDelegate> *) aController
                                    animations:(void (^)(void)) aAnimations
                                    completion:(void (^)(BOOL finished)) aCompletion {
  BrDatePickerView *pickerView = [aController pickerView];
  pickerView.alpha = 0.0;
  [aController.view addSubview:pickerView];
  [pickerView setYWithY:br_iphone_y_max()];
  pickerView.alpha = 1.0;
  
  CGFloat pickerY = 64;
  if (aController.hidesBottomBarWhenPushed == YES) { pickerY += 49; }
  if (br_is_iphone_5()) { pickerY += 568 - 480; }
  
  __weak UIViewController *wCon = aController;
  [UIView animateWithDuration:0.4
                        delay:0.1
                      options:UIViewAnimationOptionCurveEaseIn
                   animations:^{
                     aAnimations();
                     [pickerView setYWithY:pickerY];
                   }
                   completion:^(BOOL completed) {
                     aCompletion(completed);
                     [wCon.navigationItem setRightBarButtonItem:nil animated:NO];
                     [BrDatePickerAnimationHelper configureNavbarForDateEditingWithAnimation:YES
                                                                                      controller:aController];
                   }];
}



+ (void) animateDatePickerOffWithController:(UIViewController<BrDatePickerViewDelegate> *) aController
                                         before:(void (^)(void)) aBefore
                                     animations:(void (^)(void)) aAnimations
                                     completion:(void (^)(BOOL finished)) aCompletion {
  aBefore();
  
  CGFloat targetY = br_iphone_y_max();
  BrDatePickerView *pickerView = [aController pickerView];
  [UIView animateWithDuration:0.4
                        delay:0.1
                      options:UIViewAnimationOptionCurveEaseIn
                   animations:^{
                     [pickerView setYWithY:targetY];
                     aAnimations();
                   }
                   completion:^(BOOL completed) {
                     [aController.navigationItem setLeftBarButtonItem:nil animated:YES];
                     [pickerView removeFromSuperview];
                     aCompletion(completed);
                   }];
}

@end

#pragma mark - Date Picker View

typedef enum : NSInteger {
  kTagLabel = 3030,
  kTagToolbar,
  kTagPicker
} view_tags;

@interface BrDatePickerView ()

@property (nonatomic, copy) NSDate *date;
@property (nonatomic, weak) id<BrDatePickerViewDelegate> delegate;
@property (nonatomic, strong, readonly) UILabel *label;
@property (nonatomic, strong, readonly) UIDatePicker *picker;
@property (nonatomic, assign) UIDatePickerMode pickerMode;
@property (nonatomic, strong, readonly) UIToolbar *toolbar;

- (void) datePickerDateDidChange:(id) sender;
- (void) buttonTouchedPickerDone:(id) sender;


- (NSString *) accessibilityIdentifierForMode:(UIDatePickerMode) aMode;
- (NSString *) stringForDate:(NSDate *)aDate withMode:(UIDatePickerMode) aMode;
- (NSString *) accessibilityIdentifierForPickerWithMode:(UIDatePickerMode) aMode;

@end

@implementation BrDatePickerView

@synthesize label = _label;
@synthesize picker = _picker;
@synthesize toolbar = _toolbar;

#pragma mark Memory Management

- (id) init {
 // [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (id) initWithFrame:(CGRect)frame {
 // [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (id) initWithDate:(NSDate *) aDate
           delegate:(id<BrDatePickerViewDelegate>) aDelegate
               mode:(UIDatePickerMode) aDatePickerMode {
  CGRect frame = CGRectMake(0, 0, 320 , 367);
  self = [super initWithFrame:frame];
  if (self) {
    self.date = aDate;
    self.delegate = aDelegate;
    self.pickerMode = aDatePickerMode;
    
    self.accessibilityIdentifier = [self accessibilityIdentifierForMode:aDatePickerMode];
  }
  return self;
}

- (void) layoutSubviews {
  [super layoutSubviews];
  
  if ([self viewWithTag:kTagLabel] == nil) {
    [self addSubview:[self label]];
  }
  
  if ([self viewWithTag:kTagPicker] == nil) {
    [self addSubview:[self picker]];
  }
  
  if ([self viewWithTag:kTagToolbar] == nil) {
    [self addSubview:[self toolbar]];
  }
}


#pragma mark - Views


- (UILabel *) label {
  if (_label != nil) { return _label; }
  CGRect frame = CGRectMake(20, 44, 280, 24);
  UILabel *result = [[UILabel alloc] initWithFrame:frame];
  result.textAlignment = UITextAlignmentCenter;
  result.lineBreakMode = UILineBreakModeMiddleTruncation;
  result.font = [UIFont boldSystemFontOfSize:18];
  result.text = [self stringForDate:self.date withMode:self.pickerMode];
  result.accessibilityIdentifier = @"time";
  result.tag = kTagLabel;
  _label = result;
  return result;
}

- (UIToolbar *) toolbar {
  if (_toolbar != nil) { return _toolbar; }
  CGFloat y = 107;
  CGRect frame = CGRectMake(0, y, 320, 44);
  UIToolbar *bar = [[UIToolbar alloc] initWithFrame:frame];
  bar.barStyle =  UIBarStyleDefault;
  UIBarButtonItem *left = [[UIBarButtonItem alloc]
                           initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                           target:nil action:nil];
  UIBarButtonItem *right = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                            target:self action:@selector(buttonTouchedPickerDone:)];
  
  right.accessibilityLabel = NSLocalizedString(@"done picking date",
                                               @"date: ACCESSIBILITY button on toolbar/navbar - touching ends date picking and saves any changes");
  
  bar.items = [NSArray arrayWithObjects:left,right, nil];
  bar.tag = kTagToolbar;
  _toolbar = bar;
  return bar;
}


- (UIDatePicker *) picker {
  if (_picker != nil) { return _picker; }
  
  CGFloat y = 151;
  CGRect frame = CGRectMake(0, y, 320, 216);
  UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:frame];
  datePicker.date = [self.date copy];
  NSCalendar *calendar = [NSCalendar gregorianCalendarWithMondayAsFirstDayOfWeek];

  datePicker.calendar = calendar;
  datePicker.maximumDate = nil;
  datePicker.minimumDate = nil;
  
  UIDatePickerMode mode = self.pickerMode;
  datePicker.datePickerMode =  mode;
  datePicker.minuteInterval = 1;
  datePicker.accessibilityIdentifier = [self accessibilityIdentifierForPickerWithMode:mode];
  [datePicker addTarget:self action:@selector(datePickerDateDidChange:) 
       forControlEvents:UIControlEventValueChanged];
  datePicker.tag = kTagPicker;
  _picker = datePicker;
  return datePicker;
}

#pragma mark Actions 

- (void) datePickerDateDidChange:(id)sender {
  NSLog(@"date picker did change");
  NSDate *newDate = self.picker.date;
  NSString *text = [self stringForDate:newDate withMode:self.pickerMode];
  self.label.text = text;
}


- (void) buttonTouchedPickerDone:(id)sender {
  NSLog(@"picker done button touched");
  [self.delegate datePickerViewDoneButtonTouchedWithDate:self.picker.date];
   
}

- (NSString *) accessibilityIdentifierForMode:(UIDatePickerMode) aMode {
  switch (aMode) {
    case UIDatePickerModeCountDownTimer: return @"count down picker";
    case UIDatePickerModeDate: return @"date picker";
    case UIDatePickerModeDateAndTime: return @"date and time picker";
    case UIDatePickerModeTime: return @"time picker";
  }
}

- (NSString *) stringForDate:(NSDate *)aDate withMode:(UIDatePickerMode) aMode {

  NSString *fmt = nil;
  switch (aMode) {
    case UIDatePickerModeCountDownTimer: { fmt = @"unknown"; break; }
    case UIDatePickerModeDate: { fmt = [BrGlobals stringForDateFormat];  break;}
    case UIDatePickerModeDateAndTime: { fmt = [BrGlobals stringForDateTimeFormat]; break;}
    case UIDatePickerModeTime: { fmt = [BrGlobals stringForTimeFormat]; break; }
  }

  NSDateFormatter *df = [BrGlobals dateFormatterWithFormat:fmt];
  NSString *str = [df stringFromDate:aDate];
  NSLog(@"str = '%@'", str);
  return str;
}

- (NSString *) accessibilityIdentifierForPickerWithMode:(UIDatePickerMode) aMode {
  switch (aMode) {
    case UIDatePickerModeCountDownTimer: return @"count down";
    case UIDatePickerModeDate: return @"date";
    case UIDatePickerModeDateAndTime: return @"date and time";
    case UIDatePickerModeTime: return @"time";
  }
}


@end
