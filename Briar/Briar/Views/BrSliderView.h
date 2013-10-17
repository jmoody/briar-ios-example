#import <UIKit/UIKit.h>

typedef enum : unsigned short {
  BrSliderEmoticon = 0,
  BrSliderOffice,
  BrSliderScience,
  BrSliderWeather
} BrSliderViewType;


typedef void (^BrSliderDidChangeBlock)(UISlider *aSlider, BrSliderViewType);

@interface BrSliderView : UIView

- (id) initWithFrame:(CGRect) aFrame
                type:(BrSliderViewType) aType
                 tag:(NSInteger) aTag
      didChangeBlock:(BrSliderDidChangeBlock) aBlock;

- (void) setSliderValue:(CGFloat) aValue animated:(BOOL) aAnimate;

@end
