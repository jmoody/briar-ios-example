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


#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
  kTabbarIndexButtons = 0,
  kTabbarIndexText,
  kTabbarIndexDate,
  kTabbarIndexTable,
  kTabbarIndexSliders,
  kTabbarIndexWebView
} BrTabbarIndex;


NS_INLINE BOOL br_is_ipad() {
  static BOOL shared = NO;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    shared = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
  });
  return shared;
}

extern NSString *const k_br_ios_700;
extern NSString *const k_br_ios_600;

extern CGFloat const k_br_iphone_5_height;
extern CGFloat const k_br_iphone_height;
extern CGFloat const k_br_iphone_5_additonal_points;


NS_INLINE NSString* br_sys_version() {
  static dispatch_once_t onceToken;
  static NSString *shared  = nil;
  dispatch_once(&onceToken, ^{
    shared = [[UIDevice currentDevice] systemVersion];
  });
  return shared;
}

NS_INLINE BOOL br_ios_version_eql(NSString* v) {
  static dispatch_once_t onceToken;
  static BOOL shared = NO;
  dispatch_once(&onceToken, ^{
    shared = [br_sys_version() compare:v options:NSNumericSearch] == NSOrderedSame;
  });
  return shared;
}

NS_INLINE BOOL br_ios_version_gt(NSString* v) {
  static dispatch_once_t onceToken;
  static BOOL shared = NO;
  dispatch_once(&onceToken, ^{
    shared = [br_sys_version() compare:v options:NSNumericSearch] == NSOrderedDescending;
  });
  return shared;
}

NS_INLINE BOOL br_ios_version_gte(NSString* v) {
  static dispatch_once_t onceToken;
  static BOOL shared = NO;
  dispatch_once(&onceToken, ^{
    shared = [br_sys_version() compare:v options:NSNumericSearch] != NSOrderedAscending;
  });
  return shared;
}

NS_INLINE BOOL br_ios_version_lt(NSString* v) {
  static dispatch_once_t onceToken;
  static BOOL shared = NO;
  dispatch_once(&onceToken, ^{
    shared = [br_sys_version() compare:v options:NSNumericSearch] == NSOrderedAscending;
  });
  return shared;
}

NS_INLINE BOOL br_ios_version_lte(NSString* v) {
  static dispatch_once_t onceToken;
  static BOOL shared = NO;
  dispatch_once(&onceToken, ^{
    shared = [br_sys_version() compare:v options:NSNumericSearch] != NSOrderedDescending;
  });
  return shared;
}

NS_INLINE BOOL br_is_iphone_5() {
  static dispatch_once_t onceToken;
  static BOOL shared = NO;
  dispatch_once(&onceToken, ^{
    shared = CGRectGetHeight([[UIScreen mainScreen] bounds]) == k_br_iphone_5_height;
  });
  return shared;
}

NS_INLINE CGFloat br_iphone_y_max() {
  return br_is_iphone_5() ? k_br_iphone_5_height : k_br_iphone_height;
}


NS_INLINE BOOL br_is_iOS_7() {
  return br_ios_version_gte(k_br_ios_700);
}

NS_INLINE BOOL br_is_not_iOS_7() {
  return br_ios_version_lt(k_br_ios_700);
}

NS_INLINE BOOL br_is_iOS_5() {
  return br_ios_version_lt(@"6.0");
}




/**
 Documentation
 */
@interface BrGlobals : NSObject 

/** @name Properties */

/** @name Initializing Objects */

/** @name Handling Notifications, Requests, and Events */

/** @name Utility */
+ (NSString *) stringForDateFormat;
+ (NSString *) stringForDateTimeFormat; 
+ (NSString *) stringForTimeFormat;
+ (NSDateFormatter *) dateFormatterWithFormat:(NSString *) aString;

@end
