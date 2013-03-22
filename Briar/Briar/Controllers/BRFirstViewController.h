#import <MessageUI/MessageUI.h>
#import "BRController.h"

@interface BRFirstViewController : BRController
<UIActionSheetDelegate,
MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) UIActionSheet *sheet;

@property (weak, nonatomic) IBOutlet UIButton *buttonShowSheet;
- (IBAction) buttonTouchedShowSheet:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonShowEmail;
- (IBAction)buttonTouchedShowEmail:(id)sender;

@end
