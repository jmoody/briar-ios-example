#import <Foundation/Foundation.h>

@class BRDatePickerView;

@protocol BRDatePickerViewDelegate <NSObject>

@required
- (void) datePickerViewDoneButtonTouchedWithDate:(NSDate *) aDate;
- (void) datePickerViewCancelButtonTouched;
- (BRDatePickerView *) pickerView;


@end

@interface BRDatePickerAnimationHelper : NSObject

+ (void) configureNavbarForDateEditingWithAnimation:(BOOL)animated
                                         controller:(UIViewController<BRDatePickerViewDelegate> *) aController;

+ (void) animateDatePickerOnWithController:(UIViewController<BRDatePickerViewDelegate> *) aController
                                animations:(void (^)(void)) aAnimations
                                completion:(void (^)(BOOL finished)) aCompletion;

+ (void) animateDatePickerOffWithController:(UIViewController<BRDatePickerViewDelegate> *) aController
                                     before:(void (^)(void)) aBefore
                                 animations:(void (^)(void)) aAnimations
                                 completion:(void (^)(BOOL finished)) aCompletion;


@end

/**
 Documentation
 */
@interface BRDatePickerView : UIView 

/** @name Properties */

/** @name Initializing Objects */
- (id) initWithDate:(NSDate *) aDate
           delegate:(id<BRDatePickerViewDelegate>) aDelegate;


/** @name Handling Notifications, Requests, and Events */

/** @name Utility */


@end
