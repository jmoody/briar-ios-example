#import "BrController.h"
#import "BrDatePickerView.h"


@interface BrDatePickerController : BrController
<BrDatePickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *buttonShowPicker;
- (IBAction)buttonTouchedShowPicker:(id)sender;

@end
