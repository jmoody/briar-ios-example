#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "BRDatePickerView.h"
#import "BrGlobals.h"


@implementation BRDatePickerAnimationHelper

+ (void) configureNavbarForDateEditingWithAnimation:(BOOL)animated
                                         controller:(UIViewController<BRDatePickerViewDelegate> *)aController {
  [aController.navigationItem setRightBarButtonItem:nil animated:NO];
  UIBarButtonItem *cancel = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                             target:aController
                             action:@selector(datePickerViewCancelButtonTouched)];
  cancel.accessibilityLabel = NSLocalizedString(@"cancel date picking",
                                                @"date: ACCESSIBILITY navbar/toolbar button - touching cancels date picking, rolling back any changes.");
  [aController.navigationItem setLeftBarButtonItem:cancel animated:animated];
}


+ (void) animateDatePickerOnWithController:(UIViewController<BRDatePickerViewDelegate> *) aController
                                    animations:(void (^)(void)) aAnimations
                                    completion:(void (^)(BOOL finished)) aCompletion {
  BRDatePickerView *pickerView = [aController pickerView];
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
                     [pickerView setYWithY:pickerY];
                     aAnimations();
                   }
                   completion:^(BOOL completed) {
                     aCompletion(completed);
                     [wCon.navigationItem setRightBarButtonItem:nil animated:NO];
                     [BRDatePickerAnimationHelper configureNavbarForDateEditingWithAnimation:YES
                                                                                      controller:aController];
                   }];
}



+ (void) animateDatePickerOffWithController:(UIViewController<BRDatePickerViewDelegate> *) aController
                                         before:(void (^)(void)) aBefore
                                     animations:(void (^)(void)) aAnimations
                                     completion:(void (^)(BOOL finished)) aCompletion {
  aBefore();
  BRDatePickerView *pickerView = [aController pickerView];
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
                     pickerView.meal = nil;
                     aCompletion(completed);
                   }];
}



@end



// space between the lines is called the leading
static const CGFloat kLeading = 5;


@interface BRDatePickerView ()

@property (nonatomic, copy) NSDate *date;
@property (nonatomic, weak) id<BRDatePickerViewDelegate> delegate;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIDatePicker *picker;


- (OHAttributedLabel *) makeDateLabel;
- (UIToolbar *) makeToolbar;
- (UIDatePicker *) makeDatePicker;

- (NSString *) stringForDate:(NSDate *) aDate;
- (void) datePickerDateDidChange:(id) sender;
- (void) buttonTouchedPickerDone:(id) sender;
- (NSAttributedString *) attributedStringForDateLabelText:(NSString *) aText;


- (UIFont *) fontForDateLabel;

@end


@implementation BRDatePickerView

@synthesize date;
@synthesize delegate;
@synthesize label;
@synthesize picker;
@synthesize meal;


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
           delegate:(id<BRDatePickerViewDelegate>) aDelegate {
  CGRect frame = CGRectMake(0, 0, 320 , 367);
  self = [super initWithFrame:frame];
  if (self) {
    LjsReasons *reasons = [LjsReasons new];
    [reasons addReasonWithVarName:@"date" ifNil:aDate];
    [reasons addReasonWithVarName:@"delegate" ifNil:aDelegate];
    if ([reasons hasReasons]) {
      DDLogError([reasons explanation:@"could not create view"
                          consequence:@"nil"]);
      return nil;
    }
    self.date = aDate;
    self.delegate = aDelegate;
    self.meal = nil;
    
    self.accessibilityIdentifier = @"meal date picker";
    
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
  
  NSString *dateFmt = [RuGlobals stringForDateFormat];
  df = [RuGlobals ruDateFormatterWithFormat:dateFmt];
  NSString *dateStr = [df stringFromDate:aDate];
  
  NSString *timeFmt = [RuGlobals stringForTimeFormat];
  df = [RuGlobals ruDateFormatterWithFormat:timeFmt];
  NSString *timeStr = [df stringFromDate:aDate];
  
  return [dateStr stringByAppendingFormat:@"\n%@", timeStr];
}


- (UIFont *) fontForDateLabel {
  return  [RuFonts ruBoldFontWithSize:22];
}


- (NSAttributedString *) attributedStringForDateLabelText:(NSString *) aText {
  UIFont *font = [self fontForDateLabel];
  NSMutableAttributedString* attrStr = [NSMutableAttributedString attributedStringWithString:aText];
  [attrStr setFont:font];
  [attrStr setTextColor:[RuColors ruGray]];
  
  OHParagraphStyle* paragraphStyle = [OHParagraphStyle defaultParagraphStyle];
  paragraphStyle.textAlignment = kCTCenterTextAlignment;
  paragraphStyle.lineBreakMode = kCTLineBreakByWordWrapping;
  paragraphStyle.lineSpacing = kLeading;
  
  [attrStr setParagraphStyle:paragraphStyle];

  return attrStr;
}

- (OHAttributedLabel *) makeDateLabel {
  NSString *text = [self stringForDate:self.date];
  CGFloat w = 280;
  UIFont *font = [self fontForDateLabel];
  
  LjsLabelAttributes *attrs = [[LjsLabelAttributes alloc]
                               initWithString:text
                               font:font
                               labelWidth:w];


  CGFloat h = attrs.labelHeight + kLeading;
  CGFloat y = (60/2) - (h/2);
  CGRect frame = CGRectMake(20, y, w, h);
  

 
  OHAttributedLabel *result = [[OHAttributedLabel alloc]
                              initWithFrame:frame];

  result.font = attrs.font;

  result.textAlignment = UITextAlignmentCenter;
  result.backgroundColor = [RuColors colorForLabelBackground];
  result.lineBreakMode = UILineBreakModeWordWrap;
  result.numberOfLines = 2;
  result.shadowColor = [RuColors colorForGlassButtonShadow];
  result.shadowOffset = CGSizeMake(0.0, -0.7);
  result.accessibilityIdentifier = @"meal date";
  result.centerVertically = YES;
  result.attributedText = [self attributedStringForDateLabelText:text];

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
                                               @"meal: ACCESSIBILITY button on toolbar/navbar - touching ends date picking and saves any changes");
  right.tintColor = [RuColors colorForNavbarSaveDoneButtonTint];
  bar.items = [NSArray arrayWithObjects:left,right, nil];
  
  bar.tintColor = [RuColors colorForToolbar];
  
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
  DDLogDebug(@"date picker did change");
  NSDate *newDate = self.picker.date;
  NSString *text = [self stringForDate:newDate];
  self.label.attributedText = [self attributedStringForDateLabelText:text];
}


- (void) buttonTouchedPickerDone:(id)sender {
  DDLogDebug(@"picker done button touched");
  [self.delegate datePickerViewDoneButtonTouchedWithDate:self.picker.date];
   
}


@end
