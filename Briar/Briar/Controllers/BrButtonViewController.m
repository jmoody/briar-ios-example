#import "BrButtonViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "BrGlobals.h"

typedef enum : NSInteger {
  kTagAlert = 1010,
  kTagSheet = 2020,
  kTagSegCon = 3030,
  kTagImageView,
  kTagButtonShowSheet,
  kTagButtonShowEmail,
  kTagButtonShowAlert
} view_tags;


typedef enum : NSUInteger {
  kIndexImageChooser_Sand = 0,
  kIndexImageChooser_Grass,
  kIndexImageChooser_Water,
  kNumberOfImageChooserSegments
} BrImageChooserSegConIndex;



static NSString *const kAIButtonShowSheet = @"show sheet";
static NSString *const kAIButtonShowEmail = @"email";
static NSString *const kAIButtonShowAlert = @"show alert";
static NSString *const kAISegmentedControl = @"image chooser";
static NSString *const kAIImageView = @"nature scenes";

@interface BrButtonViewController ()
<UIActionSheetDelegate,
MFMailComposeViewControllerDelegate,
UIAlertViewDelegate>

- (NSString *) titleForSegConSegment:(BrImageChooserSegConIndex) aIndex;

- (UIImage *) imageForWellWithSegConSegment:(BrImageChooserSegConIndex) aIndex;
- (NSString *) accessLabelForImageViewSecConSegment:(BrImageChooserSegConIndex) aIndex;

@end

@implementation BrButtonViewController

@synthesize frames = _frames;

- (id)init {
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"Buttons", @"buttons controller");
    self.tabBarItem.image = [UIImage imageNamed:@"first"];
  }
  return self;
}

#pragma mark - Actions

- (IBAction)buttonTouchedShowSheet:(id)sender {
  NSString *locTitle = NSLocalizedString(@"sheet!", @"first view: title of action sheet");
  NSString *locCancel = NSLocalizedString(@"Cancel", @"first view:  action sheet button title");
  NSString *locDelete = NSLocalizedString(@"Delete", @"first view: action sheet button title");
  UIActionSheet *lSheet = [[UIActionSheet alloc]
                          initWithTitle:locTitle
                          delegate:self
                          cancelButtonTitle:locCancel
                          destructiveButtonTitle:locDelete
                          otherButtonTitles:nil];
  lSheet.accessibilityIdentifier = @"sheet";
  lSheet.accessibilityLabel = @"Schot";
  lSheet.tag = kTagSheet;
  [lSheet showFromTabBar:self.tabBarController.tabBar];
  
}

- (IBAction)buttonTouchedShowEmail:(id)sender {
  NSString *locSubject = NSLocalizedString(@"i love this briar pipe!", @"first view:  subject of email");
  NSString *locBody = NSLocalizedString(@"next to a calabash, it is my favorite", @"first view: body of email");
  MFMailComposeViewController *mailViewController =
  [[MFMailComposeViewController alloc] init];
  mailViewController.mailComposeDelegate = self;
  [mailViewController setSubject:locSubject];
  [mailViewController setMessageBody:locBody isHTML:NO];
  [mailViewController setToRecipients:@[@"example@example.com", @"foo@bar.com"]];
  mailViewController.view.accessibilityIdentifier = @"compose email";

  // lesspainful devices will not have email accounts configured so we get
  // an alert instead...
  if (mailViewController != nil) {
    [self presentViewController:mailViewController animated:YES completion:nil];
  } else {
    NSLog(@"no email accounts configured?");
  }
}

- (IBAction)buttonTouchedShowAlert:(id)sender {
  NSString *lat = NSLocalizedString(@"Briar Alert!", @"first view: title of alert");
  NSString *lam = NSLocalizedString(@"We are out of pipe cleaners.", @"first view: message of alert");
  NSString *lok = NSLocalizedString(@"OK", @"first view: title of OK button on alert");
  NSString *lcancel = NSLocalizedString(@"Cancel", @"first view: title of cancel button on alert");
  
  UIAlertView *alert = [[UIAlertView alloc]
                        initWithTitle:lat
                        message:lam
                        delegate:self
                        cancelButtonTitle:lcancel
                        otherButtonTitles:lok, nil];
  alert.tag = kTagAlert;
  alert.accessibilityIdentifier = @"alert";
  alert.accessibilityLabel = @"Alarmruf";
  [alert show];
}


- (IBAction)segmentedControlChanged:(UISegmentedControl *)sender {
  NSLog(@"segmented control changed: '%@'", @(sender.selectedSegmentIndex));
  BrImageChooserSegConIndex idx = (BrImageChooserSegConIndex)[sender selectedSegmentIndex];
  UIImageView *iv = [self imageView];
  iv.accessibilityLabel = [self accessLabelForImageViewSecConSegment:idx];
  iv.image = [self imageForWellWithSegConSegment:idx];
}

#pragma mark - UIAlertView Delegate

- (void) alertView:(UIAlertView *) aAlertView clickedButtonAtIndex:(NSInteger) aIndex {
  
}

//- (BOOL) alertViewShouldEnableFirstOtherButton:(UIAlertView *) aAlertView {
//  return YES;
//}

- (void) willPresentAlertView:(UIAlertView *) aAlertView {
  //DDLogDebug(@"will present alert view: %@", aAlertView);
}

- (void) didPresentAlertView:(UIAlertView *) alertView {
  //DDLogDebug(@"did present alert view %@", alertView);
}

- (void) alertView:(UIAlertView *) aAlertView willDismissWithButtonIndex:(NSInteger) aIndex {
  //DDLogDebug(@"will dismiss with button index: %d", aIndex);
}

- (void) alertView:(UIAlertView *) aAlertView didDismissWithButtonIndex:(NSInteger) aIndex {
  //DDLogDebug(@"did dismiss with button index: %d", aIndex);
}

- (void) alertViewCancel:(UIAlertView *) aAlertView {
  //DDLogDebug(@"alert view cancel: %@", aAlertView);
}


#pragma mark - UIActionSheet Delegate

// before animation and showing view
- (void)willPresentActionSheet:(UIActionSheet *) aActionSheet {
}

// after animation
- (void) didPresentActionSheet:(UIActionSheet *) aActionSheet {
}

- (void) actionSheet:(UIActionSheet *) aActionSheet willDismissWithButtonIndex:(NSInteger) aButtonIndex {
}

- (void) actionSheet:(UIActionSheet *) aActionSheet didDismissWithButtonIndex:(NSInteger) aButtonIndex {
  
}

- (void) actionSheet:(UIActionSheet *) aActionSheet clickedButtonAtIndex:(NSInteger) aButtonIndex {
}

- (void) actionSheetCancel:(UIActionSheet *) aActionSheet {
  
}

#pragma mark - Mail Compose Delegate

-(void) mailComposeController:(MFMailComposeViewController*) aController
          didFinishWithResult:(MFMailComposeResult) aResult
                        error:(NSError *) aError {
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Rotation

- (NSArray *) viewsToRotate {
  NSMutableArray *array = [NSMutableArray array];
    
  UIButton *bse = self.buttonShowEmail;
  if (bse != nil) { [array addObject:bse]; }
  
  UIButton *bss = self.buttonShowSheet;
  if (bss != nil) { [array addObject:bss]; }
  
  UIButton *bsm = self.buttonShowAlert;
  if (bsm != nil) { [array addObject:bsm]; }
  
  UISegmentedControl *sc = self.segmentedControl;
  if (sc != nil) { [array addObject:sc]; }
    
  UIImageView *iv = self.imageView;
  if (iv != nil) { [array addObject:iv]; }
  
  return [NSArray arrayWithArray:array];
}

- (CGRect) frameForView:(UIView *) aView
            orientation:(UIInterfaceOrientation) aOrientation {

  NSString *aid = aView.accessibilityIdentifier;
  NSString *key = [NSString stringWithFormat:@"%@ - %@", aid, @(aOrientation)];
  NSString *str = (self.frames)[key];
  CGRect frame = CGRectZero;
  if (str != nil) {
    frame = CGRectFromString(str);
  } else {
    UIInterfaceOrientation l = UIInterfaceOrientationLandscapeLeft;
    UIInterfaceOrientation r = UIInterfaceOrientationLandscapeRight;
    UIInterfaceOrientation t = UIInterfaceOrientationPortraitUpsideDown;
    UIInterfaceOrientation b = UIInterfaceOrientationPortrait;
    UIInterfaceOrientation o = aOrientation;
    CGFloat ipadYAdj = br_is_ipad() ? 20 : 0;
    CGFloat iphone5_X_adj = br_is_4in_iphone() ? 44 : 0;

     CGFloat maxWidth = br_iphone_x_max();
        
    if ([kAIButtonShowAlert isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(20 + iphone5_X_adj, 54 + ipadYAdj, 124, 44); }
    if ([kAIButtonShowAlert isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 78 + iphone5_X_adj, 280, 44); }
    
    if ([kAIButtonShowEmail isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(178 + iphone5_X_adj, 54 + ipadYAdj , 124, 44); }
    if ([kAIButtonShowEmail isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 130 + iphone5_X_adj, 280, 44); }

    if ([kAIButtonShowSheet isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(334 + iphone5_X_adj, 54 + ipadYAdj , 124, 44); }
    if ([kAIButtonShowSheet isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 184 + iphone5_X_adj, 280, 44); }

    if ([kAISegmentedControl isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(20 + iphone5_X_adj, 102 + ipadYAdj , 280, 44); }
    if ([kAISegmentedControl isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 246 + iphone5_X_adj, 280, 44); }

    if ([kAIImageView isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(22 + iphone5_X_adj, 150 + ipadYAdj , maxWidth, 120); }
    if ([kAIImageView isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(0, 298 + iphone5_X_adj, maxWidth, 120); }

    _frames[key] = NSStringFromCGRect(frame);
  }
  
  return frame;
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval) aDuration {
  __weak typeof(self) wself = self;
  [UIView animateWithDuration:aDuration
                   animations:^{
                     [wself layoutSubviewsForCurrentOrientation:[wself viewsToRotate]];
                   }];
}

#pragma mark - Accessibility

- (NSString *) titleForSegConSegment:(BrImageChooserSegConIndex)aIndex {
  switch (aIndex) {
    case kIndexImageChooser_Sand: return @"sand";
    case kIndexImageChooser_Grass: return @"grass";
    case kIndexImageChooser_Water: return @"water";
    default: return @"FIXME";
  }
}


- (UIImage *) imageForWellWithSegConSegment:(BrImageChooserSegConIndex) aIndex {
  switch (aIndex) {
    case kIndexImageChooser_Sand: return [UIImage imageNamed:@"sand"];
    case kIndexImageChooser_Grass: return [UIImage imageNamed:@"grass"];
    case kIndexImageChooser_Water: return [UIImage imageNamed:@"water"];
    default: return nil;
  }
}

- (NSString *) accessLabelForImageViewSecConSegment:(BrImageChooserSegConIndex) aIndex {
  switch (aIndex) {
    case kIndexImageChooser_Sand: return @"zen sand sculpture";
    case kIndexImageChooser_Grass: return @"cool grass";
    case kIndexImageChooser_Water: return @"mossy brook";
    default: return @"FIXME";
  }
}


#pragma mark - View Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.accessibilityIdentifier = @"buttons";
  self.buttonShowEmail.accessibilityIdentifier = kAIButtonShowEmail;
  self.buttonShowEmail.tag = kTagButtonShowEmail;
  
  self.buttonShowAlert.accessibilityIdentifier = kAIButtonShowAlert;
  self.buttonShowAlert.tag = kTagButtonShowAlert;
  
  self.buttonShowSheet.accessibilityIdentifier = kAIButtonShowSheet;
  self.buttonShowSheet.tag = kTagButtonShowSheet;
  
  UISegmentedControl *segcon = [self segmentedControl];
  segcon.accessibilityIdentifier = kAISegmentedControl;
  segcon.tag = kTagSegCon;
  
  for (NSUInteger idx = 0; idx < kNumberOfImageChooserSegments; idx++) {
    [segcon setTitle:[self titleForSegConSegment:idx] forSegmentAtIndex:idx];
  }
  
  self.imageView.accessibilityIdentifier = kAIImageView;
  self.imageView.tag = kTagImageView;
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  UISegmentedControl *segcon = [self segmentedControl];
  [segcon setSelectedSegmentIndex:kIndexImageChooser_Sand];
  [self segmentedControlChanged:segcon];
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
