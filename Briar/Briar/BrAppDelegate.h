#import <UIKit/UIKit.h>
#import "BrTabBarController.h"
@interface BrAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BrTabBarController *tabBarController;

@end
