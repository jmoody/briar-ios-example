#import <Foundation/Foundation.h>

@class BrDatePickerView;

@protocol BrDatePickerViewDelegate <NSObject>

@required
- (void) datePickerViewDoneButtonTouchedWithDate:(NSDate *) aDate;
- (void) datePickerViewCancelButtonTouched;
- (BrDatePickerView *) pickerView;


@end

@interface BrDatePickerAnimationHelper : NSObject

+ (void) configureNavbarForDateEditingWithAnimation:(BOOL)animated
                                         controller:(UIViewController<BrDatePickerViewDelegate> *) aController;

+ (void) animateDatePickerOnWithController:(UIViewController<BrDatePickerViewDelegate> *) aController
                                animations:(void (^)(void)) aAnimations
                                completion:(void (^)(BOOL finished)) aCompletion;

+ (void) animateDatePickerOffWithController:(UIViewController<BrDatePickerViewDelegate> *) aController
                                     before:(void (^)(void)) aBefore
                                 animations:(void (^)(void)) aAnimations
                                 completion:(void (^)(BOOL finished)) aCompletion;


@end

/**
 Documentation
 */
@interface BrDatePickerView : UIView

/** @name Properties */

/** @name Initializing Objects */
- (id) initWithDate:(NSDate *) aDate
           delegate:(id<BrDatePickerViewDelegate>) aDelegate
               mode:(UIDatePickerMode) aDatePickerMode;


/** @name Handling Notifications, Requests, and Events */

/** @name Utility */


@end
