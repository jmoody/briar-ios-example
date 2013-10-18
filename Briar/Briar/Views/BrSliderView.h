#import <UIKit/UIKit.h>

typedef enum : unsigned short {
  BrSliderEmotion = 0,
  BrSliderOffice,
  BrSliderScience,
  BrSliderWeather
} BrSliderViewType;


extern NSString *const k_aid_slider_emotions;
extern NSString *const k_aid_slider_office;
extern NSString *const k_aid_slider_science;
extern NSString *const k_aid_slider_weather;

typedef void (^BrSliderDidChangeBlock)(UISlider *aSlider, BrSliderViewType aType);

@interface BrSliderView : UIView

- (id) initWithFrame:(CGRect) aFrame
                type:(BrSliderViewType) aType
                 tag:(NSInteger) aTag
      didChangeBlock:(BrSliderDidChangeBlock) aBlock;

- (void) setSliderValue:(CGFloat) aValue animated:(BOOL) aAnimate;
- (void) respondToRotation;

@end
