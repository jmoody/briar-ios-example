#import "BRTextRelatedController.h"

@interface BRTextRelatedController ()

- (void) keyboardWillShow:(NSNotification *) aNotification;
- (void) keyboardWillHide:(NSNotification *) aNotification;

@end

@implementation BRTextRelatedController

- (void) dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"Text", @"text controller:  appears as title of the text related controller and as a tab bar item");
    self.tabBarItem.image = [UIImage imageNamed:@"second"];
  }
  return self;
}
							
- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.view.accessibilityIdentifier = @"text related";
  
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
  [nc addObserver:self
         selector:@selector(keyboardWillShow:)
             name:UIKeyboardWillShowNotification
           object:self.textField];
  
  [nc addObserver:self
         selector:@selector(keyboardWillHide:)
             name:UIKeyboardWillHideNotification
           object:self.textField];
  
  self.textField.accessibilityIdentifier = @"input";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
  [self setTextField:nil];
  [super viewDidUnload];
}


#pragma mark - Animations

- (void) keyboardWillShow:(NSNotification *)aNotification {
  NSLog(@"keyboard will show for %@", aNotification.object);
}

- (void) keyboardWillHide:(NSNotification *)aNotification {
  NSLog(@"keyboard will hide for %@", aNotification.object);
}


#pragma  mark Text Field Delegate

- (void) textFieldDidBeginEditing:(UITextField *) aTextField {
  NSLog(@"text field did begin editing");
}

- (void) textFieldDidEndEditing:(UITextField *) aTextField {
  NSLog(@"text field did end editing");
}

- (BOOL) textFieldShouldClear:(UITextField *) aTextField {
  NSLog(@"text field should clear");
  return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *) aTextField {
  NSLog(@"text field should return");
  return YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *) aTextField {
  NSLog(@"text field should begin editing");
  return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *) aTextField {
  NSLog(@"text field should end editing");
  return YES;
}

- (BOOL) textField:(UITextField *) aTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  NSLog(@"text field should change characters is range");
  return YES;
}


@end
