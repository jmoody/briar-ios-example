#import "BrController.h"

@interface BrTextRelatedController : BrController

<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *secondTextField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
