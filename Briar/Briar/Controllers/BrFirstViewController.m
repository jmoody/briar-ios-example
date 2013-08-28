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

#pragma mark - Rotation



/*
 Subclasses may override this method to perform additional actions immediately
 prior to the rotation. For example, you might use this method to disable view
 interactions, stop media playback, or temporarily turn off expensive drawing or
 live updates. You might also use it to swap the current view for one that
 reflects the new interface orientation. When this method is called, the
 interfaceOrientation property still contains the view’s original orientation.
 
 This method is called regardless of whether your code performs one-step or
 two-step rotations.
 */
- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation) aToInterfaceOrientation duration:(NSTimeInterval) aDuration {
  NSLog(@"will rotate to '%@'", [self stringForOrientation:aToInterfaceOrientation]);
}


/*
 This method is called from within the animation block used to rotate the view. 
 You can override this method and use it to configure additional animations that
 should occur during the view rotation. For example, you could use it to adjust 
 the zoom level of your content, change the scroller position, or modify other 
 animatable properties of your view.
 
 Note: The animations used to slide the header and footer views in and out of 
 position are performed in separate animation blocks.
 
 By the time this method is called, the interfaceOrientation property is already
 set to the new orientation, and the bounds of the view have been changed. Thus,
 you can perform any additional layout required by your views in this method.

*/
- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation) aInterfaceOrientation
                                          duration:(NSTimeInterval) aDuration {
  NSLog(@"will animate rotation to '%@'", [self stringForOrientation:aInterfaceOrientation]);
}

/*
 Subclasses may override this method to perform additional actions immediately 
 after the rotation. For example, you might use this method to reenable view 
 interactions, start media playback again, or turn on expensive drawing or live
 updates. By the time this method is called, the interfaceOrientation property 
 is already set to the new orientation.
 
 This method is called regardless of whether your code performs one-step or 
 two-step rotations.
 */
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation) aFromInterfaceOrientation {
  NSLog(@"did rotate from interface orientation '%@'", [self stringForOrientation:aFromInterfaceOrientation]);
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
