#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "BrGlobals.h"
#import "BrCategories.h"

static NSString *const k_24H_time_format = @"H:mm";
static NSString *const k_12H_time_format = @"h:mm a";
static NSString *const k_24H_date_format = @"EEE d MMM";
static NSString *const k_12H_date_format = @"EEE MMM d";

@interface BrGlobals ()

@end

@implementation BrGlobals

#pragma mark Memory Management
// static only
- (id) init {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

+ (BOOL) isDeviceIphone5 {
  CGRect screenBounds = [[UIScreen mainScreen] bounds];
  return (screenBounds.size.height == 568);
}

+ (NSString *) stringForDateFormat {
  NSLocale *locale = [NSLocale autoupdatingCurrentLocale];
  BOOL uses24h = [locale localeUses24HourClock];
  NSString *dateFormat = uses24h ? k_24H_date_format : k_12H_date_format;
  return [NSString stringWithFormat:@"%@", dateFormat];
}

+ (NSString *) stringForDateTimeFormat {
  NSLocale *locale = [NSLocale autoupdatingCurrentLocale];
  BOOL uses24h = [locale localeUses24HourClock];
  NSString *timeFormat = uses24h ? k_24H_time_format : k_12H_time_format;
  NSString *dateFormat = uses24h ? k_24H_date_format : k_12H_date_format;
  return [NSString stringWithFormat:@"%@ %@", dateFormat, timeFormat];
}

+ (NSString *) stringForTimeFormat {
  NSLocale *locale = [NSLocale autoupdatingCurrentLocale];
  // 24h use %HH for  00:01, 03:01, 11:01
  // 24h use %H  for   0:01,  3:01, 11:01
  // 24h use %k  for  24:01,  3:01, 11:01
  return [locale localeUses24HourClock] ? k_24H_time_format : k_12H_time_format;
}

+ (NSDateFormatter *) ruDateFormatterWithFormat:(NSString *) aString {
  NSDateFormatter *formatter = [NSDateFormatter new];
  [formatter setDateFormat:aString];
  formatter.locale = [NSLocale autoupdatingCurrentLocale];
  formatter.timeZone = [NSTimeZone localTimeZone];
  [formatter setCalendar:[NSCalendar autoupdatingCurrentCalendar]];
  return formatter;
}


@end
