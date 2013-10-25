#import <MessageUI/MessageUI.h>
#import "BrController.h"

@interface BrButtonViewController : BrController

@property (weak, nonatomic) IBOutlet UIButton *buttonShowSheet;
- (IBAction) buttonTouchedShowSheet:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonShowEmail;
- (IBAction)buttonTouchedShowEmail:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonShowAlert;
- (IBAction)buttonTouchedShowAlert:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)segmentedControlChanged:(UISegmentedControl *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
