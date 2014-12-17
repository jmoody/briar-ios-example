#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "BrGlobals.h"
#import "BrCategories.h"
#import <sys/utsname.h>

NSString *const k_br_ios_700 = @"7.0";
NSString *const k_br_ios_600 = @"6.0";
CGFloat const k_br_iphone_4in_height = 568;
CGFloat const k_br_iphone_height = 480;
CGFloat const k_br_iphone_5_additonal_points = k_br_iphone_4in_height - k_br_iphone_height;



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

+ (NSDateFormatter *) dateFormatterWithFormat:(NSString *) aString {
  NSDateFormatter *formatter = [NSDateFormatter new];
  [formatter setDateFormat:aString];
  formatter.locale = [NSLocale autoupdatingCurrentLocale];
  formatter.timeZone = [NSTimeZone localTimeZone];
  [formatter setCalendar:[NSCalendar autoupdatingCurrentCalendar]];
  return formatter;
}

+ (NSDictionary *) screenDimensions {

  static dispatch_once_t onceToken;
  static NSDictionary *shared = nil;
  dispatch_once(&onceToken, ^{
    UIDevice *device = [UIDevice currentDevice];
    struct utsname systemInfo;
    uname(&systemInfo);

    NSDictionary *env = [[NSProcessInfo processInfo] environment];
    CGFloat scale = [UIScreen mainScreen].scale;

    const CGSize IPHONE6_TARGET_SPACE = CGSizeMake(375.0f, 667.0f);

    const CGSize IPHONE6PLUS_TARGET_SPACE = CGSizeMake(414.0f, 736.0f);

    const CGSize IPHONE6PLUS = CGSizeMake(IPHONE6PLUS_TARGET_SPACE.width*scale, IPHONE6PLUS_TARGET_SPACE.height*scale);


    CGSize IPHONE6 = CGSizeMake(IPHONE6_TARGET_SPACE.width*scale,
                                IPHONE6_TARGET_SPACE.height*scale);


    const CGFloat IPHONE6_SAMPLE = 1.0f;
    const CGFloat IPHONE6PLUS_SAMPLE = 1.0f;
    const CGFloat IPHONE6_DISPLAY_ZOOM_SAMPLE = 1.171875f;


    NSString *machine = @(systemInfo.machine);
    UIScreen *s = [UIScreen mainScreen];
    UIScreenMode *sm = [s currentMode];
    CGSize size = sm.size;

    CGFloat sample = 1.0f;
    if ([@"iPhone7,1" isEqualToString:machine]) {
      //iPhone6+ http://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
      if (size.width < IPHONE6PLUS.width && size.height < IPHONE6PLUS.height) {
        sample = (IPHONE6PLUS.width / size.width);
        sample = (IPHONE6PLUS.height / size.height);
      }
      else {
        sample = IPHONE6PLUS_SAMPLE;
      }

    } else if ([@"iPhone7,2" isEqualToString:machine]) {
      //iPhone6
      if (CGSizeEqualToSize(size, IPHONE6)) {
        sample = IPHONE6_SAMPLE;
      }
      else {
        sample = IPHONE6_DISPLAY_ZOOM_SAMPLE;
      }
    } else {
      if ([@"iPhone Simulator" isEqualToString:[device model]]) {

        NSPredicate *iphone6plus = [NSPredicate predicateWithFormat:@"SIMULATOR_VERSION_INFO LIKE '*iPhone 6*Plus*'"];
        NSPredicate *iphone6 = [NSPredicate predicateWithFormat:@"SIMULATOR_VERSION_INFO LIKE '*iPhone 6*'"];

        if ([iphone6plus evaluateWithObject:env]) {
          if (size.width < IPHONE6PLUS.width && size.height < IPHONE6PLUS.height) {
            sample = (IPHONE6PLUS.width / size.width);
          sample = (IPHONE6PLUS.height / size.height);
          }
          else {
            sample = IPHONE6PLUS_SAMPLE;
          }

        }
        else if ([iphone6 evaluateWithObject:env]) {
          if (CGSizeEqualToSize(size, IPHONE6)) {
            sample = IPHONE6_SAMPLE;
          }
          else {
            sample = IPHONE6_DISPLAY_ZOOM_SAMPLE;
          }
        }
      }
    }

    shared = @{@"height" : @(size.height),
               @"width" : @(size.width),
               @"scale" : @(scale),
               @"sample" : @(sample)};
  });
  return shared;
}

@end
