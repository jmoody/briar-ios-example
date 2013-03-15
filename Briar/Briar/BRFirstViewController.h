#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface BRFirstViewController : UIViewController
<UIActionSheetDelegate,
MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) UIActionSheet *sheet;

@property (weak, nonatomic) IBOutlet UIButton *buttonShowSheet;
- (IBAction) buttonTouchedShowSheet:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonShowEmail;
- (IBAction)buttonTouchedShowEmail:(id)sender;

@end
