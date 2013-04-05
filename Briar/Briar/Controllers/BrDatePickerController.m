#import "BrDatePickerController.h"
#import "BrCategories.h"

@interface BrDatePickerController ()

@property (nonatomic, strong) BrDatePickerView *pickerView;

- (void) buttonTouchedDoneDatePicking:(id) sender;
@end

@implementation BrDatePickerController

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
  
  self.pickerView = [[BrDatePickerView alloc]
                     initWithDate:[NSDate date]
                     delegate:self];

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
  self.buttonShowPicker.hidden = YES;
  typeof(self) wself = self;
  [BrDatePickerAnimationHelper
   animateDatePickerOnWithController:wself
   animations:^{

   } completion:^(BOOL finished) {
     wself.buttonShowPicker.alpha = 0;
   }];
}

#pragma mark - Animations


#pragma mark - RuAddMealPickerView Delegate

- (void) datePickerViewCancelButtonTouched {
  NSLog(@"cancel date picking button touched");
  typeof(self) wself = self;
  [BrDatePickerAnimationHelper
   animateDatePickerOffWithController:wself
   before:^{
     wself.buttonShowPicker.hidden = NO;
   } animations:^{
     
     wself.buttonShowPicker.alpha = 1;
   } completion:^(BOOL finished) {
     
   }];
}

- (void) datePickerViewDoneButtonTouchedWithDate:(NSDate *)aDate {
  NSLog(@"picker view done button touched with date: %@",  [aDate debugDescription]);
  
  typeof(self) wself = self;
  [BrDatePickerAnimationHelper
   animateDatePickerOffWithController:wself
   before:^{
     wself.buttonShowPicker.hidden = NO;
   } animations:^{
     wself.buttonShowPicker.alpha = 1;
   } completion:^(BOOL finished) {
   
   }];
}


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
  [self datePickerViewCancelButtonTouched];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
} 
@end
