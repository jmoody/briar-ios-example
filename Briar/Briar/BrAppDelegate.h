#import <UIKit/UIKit.h>
#import "BrTabBarController.h"

typedef void (^BrWindowEventHandlerBlock)(UIWindow *window, UIEvent *aEvent);

@interface BrWindow : UIWindow

@property (nonatomic, copy) BrWindowEventHandlerBlock eventHandler;

@end

@interface BrAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) BrWindow *window;
@property (strong, nonatomic) BrTabBarController *tabBarController;

@end
