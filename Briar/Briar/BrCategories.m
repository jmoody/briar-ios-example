// Copyright 2013 Little Joy Software. All rights reserved.
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in
//       the documentation and/or other materials provided with the
//       distribution.
//     * Neither the name of the Little Joy Software nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY LITTLE JOY SOFTWARE ''AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL LITTLE JOY SOFTWARE BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
// OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
// IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "BrCategories.h"

@interface BrCategories ()

@end

@implementation BrCategories

#pragma mark - Memory Management
- (id) init {
  [self doesNotRecognizeSelector:_cmd];
  return self;
}

@end

#pragma mark - NSArray Additions

@implementation NSArray (BrAdditions)

- (NSArray *) mapc:(void (^)(id obj, NSUInteger idx, BOOL *stop)) aBlock  {
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    aBlock(obj, idx, stop);
  }];
  return self;
}


@end

@implementation UIView (BrAdditions)

- (void) setHeightWithHeight:(CGFloat) h {
  CGFloat w = self.frame.size.width;
  [self setSizeWithWidth:w andHeight:h];
}

- (void) setWidthWithWidth:(CGFloat) w {
  CGFloat h = self.frame.size.height;
  [self setSizeWithWidth:w andHeight:h];
}

- (void) setSizeWithWidth:(CGFloat) w
                andHeight:(CGFloat) h {
  CGRect frame = self.frame;
  self.frame = CGRectMake(frame.origin.x,
                          frame.origin.y,
                          w, h);
}

- (void) setOriginWithX:(CGFloat) x
                   andY:(CGFloat) y {
  CGRect frame = self.frame;
  self.frame = CGRectMake(x, y,
                          frame.size.width,
                          frame.size.height);
}

- (void) setXWithX:(CGFloat) x {
  CGFloat y = self.frame.origin.y;
  [self setOriginWithX:x andY:y];
}

- (void) setYWithY:(CGFloat) y {
  CGFloat x = self.frame.origin.x;
  [self setOriginWithX:x andY:y];
}

@end

@implementation NSLocale (BrAdditions)

- (BOOL) localeUses24HourClock {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setLocale:self];
  [formatter setDateStyle:NSDateFormatterNoStyle];
  [formatter setTimeStyle:NSDateFormatterShortStyle];
  NSString *dateString = [formatter stringFromDate:[NSDate date]];
  NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
  NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];
  BOOL is24Hour = (amRange.location == NSNotFound && pmRange.location == NSNotFound);
  return is24Hour;
}

@end

@implementation NSCalendar (BrAdditions)

+ (NSCalendar *) gregorianCalendarWithMondayAsFirstDayOfWeek {
  NSCalendar *calendar;
  calendar = [[NSCalendar alloc]
              initWithCalendarIdentifier:NSGregorianCalendar];
  // iso spec http://en.wikipedia.org/wiki/ISO_week_date#First_week
  // not respected in iOS 5.0 so we set it here
  [calendar setMinimumDaysInFirstWeek:4];
  // monday - days are 1 indexed
  [calendar setFirstWeekday:2];
  return calendar;
}



@end

