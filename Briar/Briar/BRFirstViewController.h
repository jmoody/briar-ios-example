#import <UIKit/UIKit.h>

@interface BRFirstViewController : UIViewController
<UIActionSheetDelegate>

@property (strong, nonatomic) UIActionSheet *sheet;
@property (weak, nonatomic) IBOutlet UIButton *buttonShowSheet;
- (IBAction)buttonTouchedShowSheet:(id)sender;

@end
