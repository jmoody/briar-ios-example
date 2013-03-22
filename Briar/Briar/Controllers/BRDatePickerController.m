#import "BRDatePickerController.h"

@interface BRDatePickerController ()

- (void) buttonTouchedDoneDatePicking:(id) sender;

@end

@implementation BRDatePickerController

- (void) dealloc {
  
}

- (id) init {
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"Date", @"date picking controller: tab bar button");
    self.tabBarItem.image = [UIImage imageNamed:@"11-clock"];
  }
  return self;
}
							
- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.view.accessibilityIdentifier = @"date related";

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
  [self setButtonShowPicker:nil];
  [super viewDidUnload];
}


#pragma mark - Actions

- (void) buttonTouchedDoneDatePicking:(id)sender {
  NSLog(@"done date editing button touched");
  
}


- (IBAction)buttonTouchedShowPicker:(id)sender {
  NSLog(@"show picker button touched");
  
}

#pragma mark - Animations


#pragma mark - View Lifecycle


- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.buttonShowPicker.accessibilityIdentifier = @"show picker";
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
