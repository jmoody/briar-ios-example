#import "BrTextRelatedController.h"
#import "BrGlobals.h"
#import "SSKeychain.h"

static NSString *const kIdTopTf = @"top tf";
static NSString *const kIdBottomTf = @"bottom tf";
static NSString *const kIdTopTv = @"top tv";
static NSString *const kIdBottomTv = @"bottom tv";
static NSString *const kIdButton = @"the button";

static NSString *const kIdUserTf = @"user tf";
static NSString *const kIdPassTf = @"pass tf";
static NSString *const kIdKeychainButton = @"keychain button";
static NSString *const kKeychainService = @"briar-ios-example.service";

@interface BrTextRelatedController ()

- (void) keyboardWillShow:(NSNotification *) aNotification;
- (void) keyboardWillHide:(NSNotification *) aNotification;

- (void) buttonTouchedDoneTextEditing:(id) sender;

- (void) handleSwipeOnTextField:(UISwipeGestureRecognizer *) aRecognizer;
- (void) addSwipeRecognizerToTextField:(UITextField *) aTextField
                             direction:(UISwipeGestureRecognizerDirection) aDirection;



@end

@implementation BrTextRelatedController

@synthesize frames = _frames;
@synthesize textFieldTop = _textFieldTop;
@synthesize textFieldBottom = _textFieldBottom;
@synthesize textViewTop = _textViewTop;
@synthesize textViewBottom = _textViewBottom;
@synthesize button = _button;


- (id)init {
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"Text", @"text controller:  title of text related  tab bar item");
    self.tabBarItem.image = [UIImage imageNamed:@"second"];
    self.navbarTitle = @"Text Related";
  }
  return self;
}



- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
 
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
  [nc addObserver:self
         selector:@selector(keyboardWillShow:)
             name:UIKeyboardWillShowNotification
           object:nil];
  
  [nc addObserver:self
         selector:@selector(keyboardWillHide:)
             name:UIKeyboardWillHideNotification
           object:nil];
  
  _textFieldTop.accessibilityIdentifier = kIdTopTf;
  _textFieldBottom.accessibilityIdentifier = kIdBottomTf;
  
  for (UITextField *tf in @[_textFieldTop, _textFieldBottom]) {
    for (NSNumber *dir in
         @[@(UISwipeGestureRecognizerDirectionLeft),
         @(UISwipeGestureRecognizerDirectionRight)]) {
      [self addSwipeRecognizerToTextField:tf
                                direction:dir.unsignedIntegerValue];
      tf.keyboardType = UIKeyboardTypeEmailAddress;
    }
  }
  
  _textViewTop.accessibilityIdentifier = kIdTopTv;
  _textViewBottom.accessibilityIdentifier = kIdBottomTv;
  
  _button.accessibilityIdentifier = kIdButton;

  _textFieldUsername.accessibilityIdentifier = kIdUserTf;
  _textFieldPassword.accessibilityIdentifier = kIdPassTf;
  _saveToKeychainButton.accessibilityIdentifier = kIdKeychainButton;

  NSDictionary *accountDict = [[SSKeychain accountsForService:kKeychainService] firstObject];
  if (accountDict) {
    NSString *account = accountDict[kSSKeychainAccountKey];
    _textFieldUsername.text = account;
    _textFieldPassword.text = [SSKeychain passwordForService:kKeychainService account:account];
  }

  self.view.accessibilityIdentifier = @"text related";
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
  
  [super viewDidUnload];
}


#pragma mark - Actions

- (void) buttonTouchedDoneTextEditing:(id)sender {
  NSLog(@"done text editing button touched");
  if ([self.textFieldTop isFirstResponder]) { [self.textFieldTop resignFirstResponder]; }
  if ([self.textFieldBottom isFirstResponder]) { [self.textFieldBottom resignFirstResponder]; }
  if ([self.textViewTop isFirstResponder]) { [self.textViewTop resignFirstResponder]; }
  if ([self.textViewBottom isFirstResponder]) { [self.textViewBottom resignFirstResponder]; }
  if ([self.textFieldUsername isFirstResponder]) { [self.textFieldUsername resignFirstResponder]; }
  if ([self.textFieldPassword isFirstResponder]) { [self.textFieldPassword resignFirstResponder]; }
}

- (IBAction)buttonTouched:(id)sender {
  NSLog(@"button touched");
}

- (IBAction)saveToKeychainButtonTouched:(id)sender {
  NSError *error;
  if (![SSKeychain setPassword:self.textFieldPassword.text
                    forService:kKeychainService
                       account:self.textFieldUsername.text
                         error:&error]) {
    NSLog(@"Error writing to keychain: %@", error);
  }
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

#pragma mark - Gestures

- (void) addSwipeRecognizerToTextField:(UITextField *) aTextField
                             direction:(UISwipeGestureRecognizerDirection) aDirection {
  UISwipeGestureRecognizer *recog = [[UISwipeGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(handleSwipeOnTextField:)];
  recog.numberOfTouchesRequired = 1;
  recog.direction = aDirection;
  [aTextField addGestureRecognizer:recog];
}


- (void) handleSwipeOnTextField:(UISwipeGestureRecognizer *)aRecognizer {
  UIGestureRecognizerState state = [aRecognizer state];
  NSLog(@"handling swipe with state '%d'", state);
  if (UIGestureRecognizerStateEnded == state) {
    NSLog(@"handling swipe ended");
    UITextField *tf = (UITextField *)aRecognizer.view;
    tf.text =
    aRecognizer.direction == UISwipeGestureRecognizerDirectionRight ?
    @"swiped right" : @"swiped left";
  }
}


#pragma  mark Text Field Delegate

- (void) textFieldDidBeginEditing:(UITextField *) aTextField {
}

- (void) textFieldDidEndEditing:(UITextField *) aTextField {
}

- (BOOL) textFieldShouldClear:(UITextField *) aTextField {
  return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *) aTextField {
  return YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *) aTextField {
  return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *) aTextField {
  return YES;
}

- (BOOL) textField:(UITextField *) aTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  return YES;
}



#pragma mark - Orientation iOS 5


#pragma mark - Orientation iOS 6
  
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation) aFromInterfaceOrientation {
  
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval) aDuration {
  __weak typeof(self) wself = self;
  [UIView animateWithDuration:aDuration
                   animations:^{
                     [wself layoutSubviewsForCurrentOrientation:[wself viewsToRotate]];
                   }];
}


#pragma mark - View Layout

- (void) viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
}


- (void) viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
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
    
    
    if ([kIdTopTf isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(20, 64 + ipadYAdj, 210, 30); }
    if ([kIdBottomTf isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(20, 108 + ipadYAdj , 210, 30); }
    if ([kIdTopTf isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 84, 280, 30); }
    if ([kIdBottomTf isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 124, 280, 30); }

    if ([kIdTopTv isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(250, 64 + ipadYAdj, 210, 30); }
    if ([kIdBottomTv isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(250, 108 + ipadYAdj, 210, 30); }
    if ([kIdTopTv isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 160, 280, 30); }
    if ([kIdBottomTv isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 196, 280, 30); }
    
    if ([kIdButton isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 269, 230, 44); }
    if ([kIdButton isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(330, 158 + ipadYAdj, 230, 44); }

    if ([kIdUserTf isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(20, 188, 210, 44); }
    if ([kIdPassTf isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(250, 188, 210, 44); }
    if ([kIdUserTf isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(20, 312 + ipadYAdj, 120, 44); }
    if ([kIdPassTf isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(160, 312 + ipadYAdj, 120, 44); }

    if ([kIdKeychainButton isEqualToString:aid] && (l == o || r == o)) { frame = CGRectMake(200, 232, 140, 44); }
    if ([kIdKeychainButton isEqualToString:aid] && (t == o || b == o)) { frame = CGRectMake(140, 360 + ipadYAdj, 140, 44); }

    [_frames setObject:NSStringFromCGRect(frame) forKey:key];
  }
  return frame;
}

- (NSArray *) viewsToRotate {
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:4];
  if (_textFieldTop != nil) { [array addObject:_textFieldTop]; }
  if (_textFieldBottom != nil) { [array addObject:_textFieldBottom]; }
  if (_textViewTop != nil) { [array addObject:_textViewTop]; }
  if (_textViewBottom != nil) { [array addObject:_textViewBottom]; }
  if (_button != nil) { [array addObject:_button]; }
  if (_textFieldUsername != nil) { [array addObject:_textFieldUsername]; }
  if (_textFieldPassword != nil) { [array addObject:_textFieldPassword]; }
  if (_saveToKeychainButton != nil) { [array addObject:_saveToKeychainButton]; }
  return [NSArray arrayWithArray:array];
}

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self layoutSubviewsForCurrentOrientation:[self viewsToRotate]];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [@[self.textFieldTop,
     self.textFieldBottom,
     self.textViewTop,
     self.textViewBottom] enumerateObjectsUsingBlock:^(UITextField *tf, NSUInteger idx, BOOL *stop) {
    if ([tf isFirstResponder]) { [tf resignFirstResponder]; }
    tf.text = nil;
  }];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}


@end
