#import "BrController.h"

@interface BrTextRelatedController : BrController

<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldTop;
@property (weak, nonatomic) IBOutlet UITextField *textFieldBottom;
@property (weak, nonatomic) IBOutlet UITextView *textViewTop;
@property (weak, nonatomic) IBOutlet UITextView *textViewBottom;
@property (weak, nonatomic) IBOutlet UIButton *button;

- (IBAction)buttonTouched:(id)sender;

@end
