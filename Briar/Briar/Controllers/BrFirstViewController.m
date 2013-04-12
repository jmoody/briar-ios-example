#import "BrFirstViewController.h"
#import <MessageUI/MFMailComposeViewController.h>


@interface BrFirstViewController ()

@end

@implementation BrFirstViewController

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
  [lSheet showFromTabBar:self.tabBarController.tabBar];
  self.sheet = lSheet;
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

- (IBAction)buttonTouchedShowModal:(id)sender {
  
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
  self.sheet = nil;
}

#pragma mark - Mail Compose Delegate

-(void) mailComposeController:(MFMailComposeViewController*) aController
          didFinishWithResult:(MFMailComposeResult) aResult
                        error:(NSError *) aError {
  [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - View Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  [self setButtonShowSheet:nil];
  [self setButtonShowEmail:nil];
  [self setButtonShowModal:nil];
  [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.view.accessibilityIdentifier = @"first";
  self.buttonShowSheet.accessibilityIdentifier = @"show sheet";
  self.buttonShowEmail.accessibilityIdentifier = @"email";
  self.buttonShowModal.accessibilityIdentifier = @"show modal";
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
