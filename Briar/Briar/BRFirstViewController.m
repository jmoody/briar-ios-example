#import "BRFirstViewController.h"

@interface BRFirstViewController ()

@end

@implementation BRFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"First", @"first view: title");
    self.tabBarItem.image = [UIImage imageNamed:@"first"];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  [self setButtonShowSheet:nil];
  [super viewDidUnload];
}

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


#pragma mark - View Lifecycle


- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.view.accessibilityIdentifier = @"first view";
  self.buttonShowSheet.accessibilityIdentifier = @"show sheet";
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
