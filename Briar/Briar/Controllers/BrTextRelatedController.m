#import "BrTextRelatedController.h"

@interface BrTextRelatedController ()

- (void) keyboardWillShow:(NSNotification *) aNotification;
- (void) keyboardWillHide:(NSNotification *) aNotification;

- (void) buttonTouchedDoneTextEditing:(id) sender;

@end

@implementation BrTextRelatedController


- (id)init {
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"Text", @"text controller:  appears as title of the text related controller and as a tab bar item");
    self.tabBarItem.image = [UIImage imageNamed:@"second"];
    self.navbarTitle = @"Text Related";
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
           object:nil];
  
  [nc addObserver:self
         selector:@selector(keyboardWillHide:)
             name:UIKeyboardWillHideNotification
           object:nil];
  
  self.textField.accessibilityIdentifier = @"top tf";
  self.secondTextField.accessibilityIdentifier = @"bottom tf";
  self.textView.accessibilityIdentifier = @"tv input";

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

- (void) buttonTouchedDoneTextEditing:(id)sender {
  NSLog(@"done text editing button touched");
  if ([self.textField isFirstResponder]) { [self.textField resignFirstResponder]; }
}

#pragma mark - Animations

- (void) keyboardWillShow:(NSNotification *)aNotification {
  NSLog(@"keyboard will show");
  
  NSString *locTitle = NSLocalizedString(@"Done", @"text related:  navbar button title - touching dismisses the keyboard");
  UIBarButtonItem *done = [[UIBarButtonItem alloc]
                           initWithTitle:locTitle
                           style:UIBarButtonItemStyleDone
                           target:self
                           action:@selector(buttonTouchedDoneTextEditing:)];
  done.accessibilityLabel = @"done text editing";
  [self.navigationItem setRightBarButtonItem:done animated:YES];
}

- (void) keyboardWillHide:(NSNotification *)aNotification {
  NSLog(@"keyboard will hide");
  [self.navigationItem setRightBarButtonItem:nil animated:YES];
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

#pragma mark - View Layout

- (void) viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
}


- (void) viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
}

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [@[self.textField, self.secondTextField] enumerateObjectsUsingBlock:^(UITextField *tf, NSUInteger idx, BOOL *stop) {
    if ([tf isFirstResponder]) { [tf resignFirstResponder]; }
    tf.text = nil;
  }];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

@end
