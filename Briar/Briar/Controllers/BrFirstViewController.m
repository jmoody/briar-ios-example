#import "BrFirstViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "BrGlobals.h"

typedef enum : NSInteger {
  kTagAlert = 1010,
  kTagSheet = 2020
} view_tags;



static NSString *const kAIButtonShowSheet = @"show sheet";
static NSString *const kAIButtonShowEmail = @"email";
static NSString *const kAIButtonShowAlert = @"show alert";
static NSString *const kAILabelTitle = @"title";

@interface BrFirstViewController ()
<UIActionSheetDelegate,
MFMailComposeViewControllerDelegate,
UIAlertViewDelegate>


@end

@implementation BrFirstViewController

@synthesize frames = _frames;

- (id)init {
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"First", @"first view: title");
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
    [self presentModalViewController:mailViewController animated:YES];
  } else {
    NSLog(@"no email accounts configured?");
  }
}

- (IBAction)buttonTouchedShowAlert:(id)sender {
  NSString *lat = NSLocalizedString(@"Briar Alert!", @"first view: title of alert");
  NSString *lam = NSLocalizedString(@"We are out pipe cleaners.", @"first view: message of alert");
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
  [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Rotation


- (NSArray *) viewsToRotate {
  NSMutableArray *array = [NSMutableArray array];
  
  UILabel *tl = self.labelTitle;
  if (tl != nil) { [array addObject:tl]; }
  
  UIButton *bse = self.buttonShowEmail;
  if (bse != nil) { [array addObject:bse]; }
  
  UIButton *bss = self.buttonShowSheet;
  if (bss != nil) { [array addObject:bss]; }
  
  UIButton *bsm = self.buttonShowAlert;
  if (bsm != nil) { [array addObject:bsm]; }
  
  return [NSArray arrayWithArray:array];
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
    CGFloat ipadYAdj = br_is_ipad() ? 20 : 0;
    CGFloat iphone5_X_adj = br_is_iphone_5() ? 44 : 0;
    

    if ([kAILabelTitle isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(20 + iphone5_X_adj, 64 + ipadYAdj, 440, 44); }
    if ([kAILabelTitle isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 80 + iphone5_X_adj, 280, 44); }
    
    if ([kAIButtonShowAlert isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(20 + iphone5_X_adj, 128 + ipadYAdj, 124, 44); }
    if ([kAIButtonShowAlert isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 188 + iphone5_X_adj, 280, 44); }
    
    if ([kAIButtonShowEmail isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(178 + iphone5_X_adj, 128 + ipadYAdj , 124, 44); }
    if ([kAIButtonShowEmail isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 240 + iphone5_X_adj, 280, 44); }

    if ([kAIButtonShowSheet isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(334 + iphone5_X_adj, 128 + ipadYAdj , 124, 44); }
    if ([kAIButtonShowSheet isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 288 + iphone5_X_adj, 280, 44); }

    
   
    [_frames setObject:NSStringFromCGRect(frame) forKey:key];
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


#pragma mark - View Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.accessibilityIdentifier = @"first";
  self.labelTitle.accessibilityIdentifier = kAILabelTitle;
  self.buttonShowEmail.accessibilityIdentifier = kAIButtonShowEmail;
  self.buttonShowAlert.accessibilityIdentifier = kAIButtonShowAlert;
  self.buttonShowSheet.accessibilityIdentifier = kAIButtonShowSheet;
  
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  [self setButtonShowSheet:nil];
  [self setButtonShowEmail:nil];
  [self setButtonShowAlert:nil];
  [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
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
