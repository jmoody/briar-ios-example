#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "BrDatePickerView.h"
#import "BrGlobals.h"
#import "BRCategories.h"


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
  [aController.view addSubview:pickerView];
  
  CGFloat pickerY = (aController.hidesBottomBarWhenPushed == YES) ? 50 : 0;
  if ([BrGlobals isDeviceIphone5]) {
    pickerY += 568 - 480;
  }
  
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
  BrDatePickerView *pickerView = [aController pickerView];
  [UIView animateWithDuration:0.4
                        delay:0.1
                      options:UIViewAnimationOptionCurveEaseIn
                   animations:^{
                     [pickerView setYWithY:480];
                     aAnimations();
                   }
                   completion:^(BOOL completed) {
                     [aController.navigationItem setLeftBarButtonItem:nil animated:YES];
                     [pickerView removeFromSuperview];
                     aCompletion(completed);
                   }];
}



@end



// space between the lines is called the leading
static const CGFloat kLeading = 5;


@interface BrDatePickerView ()

@property (nonatomic, copy) NSDate *date;
@property (nonatomic, weak) id<BrDatePickerViewDelegate> delegate;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIDatePicker *picker;


- (UILabel *) makeDateLabel;
- (UIToolbar *) makeToolbar;
- (UIDatePicker *) makeDatePicker;

- (NSString *) stringForDate:(NSDate *) aDate;
- (void) datePickerDateDidChange:(id) sender;
- (void) buttonTouchedPickerDone:(id) sender;

- (UIFont *) fontForDateLabel;

@end


@implementation BrDatePickerView

@synthesize date;
@synthesize delegate;
@synthesize label;
@synthesize picker;


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
           delegate:(id<BrDatePickerViewDelegate>) aDelegate {
  CGRect frame = CGRectMake(0, 0, 320 , 367);
  self = [super initWithFrame:frame];
  if (self) {
    self.date = aDate;
    self.delegate = aDelegate;
    
    self.accessibilityIdentifier = @"wake up picker";
    
    self.label = [self makeDateLabel];
    [self addSubview:self.label];
    
    UIToolbar *bar = [self makeToolbar];
    [self addSubview:bar];
    
    self.picker = [self makeDatePicker];
    [self addSubview:self.picker];
  }
  return self;
}

- (NSString *) stringForDate:(NSDate *) aDate {
  NSDateFormatter *df;
  NSString *timeFmt = [BrGlobals stringForTimeFormat];
  df = [BrGlobals ruDateFormatterWithFormat:timeFmt];
  NSString *timeStr = [df stringFromDate:aDate];
  return timeStr;
}


- (UIFont *) fontForDateLabel {
  return  [UIFont boldSystemFontOfSize:22];
}



- (UILabel *) makeDateLabel {

  UIFont *font = [self fontForDateLabel];
  CGRect frame = CGRectMake(20, 44, 280, 24);
  
  UILabel *result = [[UILabel alloc] initWithFrame:frame];
  result.textAlignment = UITextAlignmentCenter;
  result.lineBreakMode = UILineBreakModeMiddleTruncation;
  result.font = font;
  result.accessibilityIdentifier = @"wake up time";
  result.text = [self stringForDate:self.date];
  return result;
}

- (UIToolbar *) makeToolbar {
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
  
  return bar;
}

- (UIDatePicker *) makeDatePicker {
  CGFloat y = 151;
  CGRect frame = CGRectMake(0, y, 320, 216);
  UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:frame];
  datePicker.date = [self.date copy];
  //NSLocale *locale = [NSLocale autoupdatingCurrentLocale];
  //calendar.locale = locale;
  NSCalendar *calendar = [NSCalendar gregorianCalendarWithMondayAsFirstDayOfWeek];

  datePicker.calendar = calendar;
  datePicker.maximumDate = [NSDate date];
  datePicker.datePickerMode =  UIDatePickerModeTime;
  datePicker.minuteInterval = 1;
  datePicker.accessibilityIdentifier = @"date picker";
  [datePicker addTarget:self action:@selector(datePickerDateDidChange:) 
       forControlEvents:UIControlEventValueChanged];
  
  return datePicker;
}

#pragma mark Actions 

- (void) datePickerDateDidChange:(id)sender {
  NSLog(@"date picker did change");
  NSDate *newDate = self.picker.date;
  NSString *text = [self stringForDate:newDate];
  self.label.text = text;
}


- (void) buttonTouchedPickerDone:(id)sender {
  NSLog(@"picker done button touched");
  [self.delegate datePickerViewDoneButtonTouchedWithDate:self.picker.date];
   
}


@end
