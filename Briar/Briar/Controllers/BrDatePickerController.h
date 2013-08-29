#import "BrController.h"
#import "BrDatePickerView.h"


@interface BrDatePickerController : BrController
<BrDatePickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *buttonTime;
- (IBAction)buttonTouchedTime:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonDateAndTime;
- (IBAction)buttonTouchedDateAndTime:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonDate;
- (IBAction)buttonTouchedDate:(id)sender;

@end
