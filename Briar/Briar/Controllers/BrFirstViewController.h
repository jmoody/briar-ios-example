#import <MessageUI/MessageUI.h>
#import "BrController.h"

@interface BrFirstViewController : BrController

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property (weak, nonatomic) IBOutlet UIButton *buttonShowSheet;
- (IBAction) buttonTouchedShowSheet:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonShowEmail;
- (IBAction)buttonTouchedShowEmail:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonShowAlert;
- (IBAction)buttonTouchedShowAlert:(id)sender;


@end
