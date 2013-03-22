#import <Foundation/Foundation.h>

@interface BrCategories : NSObject

@end

@interface NSArray (BrAdditions)

- (NSArray *) mapc:(void (^)(id obj, NSUInteger idx, BOOL *stop)) aBlock;

@end


@interface UIView (BrAdditions)

- (void) setHeightWithHeight:(CGFloat) h;
- (void) setWidthWithWidth:(CGFloat) w;
- (void) setSizeWithWidth:(CGFloat) w
                andHeight:(CGFloat) h;

- (void) setXWithX:(CGFloat) x;
- (void) setYWithY:(CGFloat) y;
- (void) setOriginWithX:(CGFloat) x
                   andY:(CGFloat) y;

@end

@interface NSLocale (BrAdditions)

- (BOOL) localeUses24HourClock;
 
@end

@interface NSCalendar (BrAdditions)

+ (NSCalendar *) gregorianCalendarWithMondayAsFirstDayOfWeek;

@end