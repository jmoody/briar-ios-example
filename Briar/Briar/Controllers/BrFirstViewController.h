#import <MessageUI/MessageUI.h>
#import "BrController.h"

@interface BrFirstViewController : BrController
<UIActionSheetDelegate,
MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) UIActionSheet *sheet;

@property (weak, nonatomic) IBOutlet UIButton *buttonShowSheet;
- (IBAction) buttonTouchedShowSheet:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonShowEmail;
- (IBAction)buttonTouchedShowEmail:(id)sender;

@end
