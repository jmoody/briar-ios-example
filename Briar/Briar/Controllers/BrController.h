#import <Foundation/Foundation.h>

/**
 Documentation
 */
@interface BrController : UIViewController 

// distinct from the self.title for times when you want a navbar title that is
// different from the tab bar title
@property (nonatomic, copy) NSString *navbarTitle;
@property (nonatomic, strong, readonly) NSMutableDictionary *frames;

/** @name Initializing Objects */

/** @name Utility */
- (NSString *) stringForOrientation:(UIInterfaceOrientation) aOrientation;
- (CGRect) frameForView:(UIView *) aView
            orientation:(UIInterfaceOrientation) aOrientation;
- (NSArray *) viewsToRotate;
- (void) layoutSubviewsForCurrentOrientation:(NSArray *) aViews;

@end
