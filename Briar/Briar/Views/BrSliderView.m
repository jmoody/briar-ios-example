#import "BrSliderView.h"

typedef enum : short {
  kSliderMin = -2,
  kSliderNextToMin = -1,
  kSliderMiddle = 0,
  kSliderNextToMax = 1,
  kSliderMax = 2
} BrSliderPosition;


NSString *const k_aid_slider_emotions = @"emotions";
NSString *const k_aid_slider_office = @"office";
NSString *const k_aid_slider_science = @"science";
NSString *const k_aid_slider_weather = @"weather";

@interface BrSliderDataSource : NSObject

- (UIImage *) imageForValue:(CGFloat) aValue
                       type:(BrSliderViewType) aType;
- (NSString *) titleForValue:(CGFloat) aValue
                        type:(BrSliderViewType) aType;
- (NSString *) accessLabelForImageView:(CGFloat) aValue
                               type:(BrSliderViewType) aType;

- (NSString *) accessLabelForViewWithType:(BrSliderViewType) aType;
- (NSString *) accessIdForViewWithType:(BrSliderViewType) aType;
- (NSString *) accessIdForSliderWithType:(BrSliderViewType) aType;

@end

@interface BrSliderDataSource ()

- (BrSliderPosition) positionForValue:(CGFloat) aValue;
- (NSString *) nameForValue:(CGFloat) aValue
                       type:(BrSliderViewType) aType;


@end

@implementation BrSliderDataSource

#pragma mark - Memory Management

- (BrSliderPosition) positionForValue:(CGFloat) aValue {
  if (aValue < -1.5) { return kSliderMin; }
  if (aValue >= -1.5 && aValue < -0.5) { return kSliderNextToMin; }
  if (aValue >= -0.5 && aValue < 0.5) { return kSliderMiddle; }
  if (aValue >= 0.5 && aValue < 1.5) { return kSliderNextToMax; }
  return kSliderMax;
}

- (NSString *) accessLabelForViewWithType:(BrSliderViewType) aType {
  switch (aType) {
    case BrSliderEmotion: return @"set your emotion";
    case BrSliderOffice: return @"office you need";
    case BrSliderScience: return @"equipment that is broken";
    case BrSliderWeather: return @"what is the weather";
  }
}

- (NSString *) accessIdForViewWithType:(BrSliderViewType) aType {
  switch (aType) {
    case BrSliderEmotion: return k_aid_slider_emotions;
    case BrSliderOffice: return k_aid_slider_office;
    case BrSliderScience: return k_aid_slider_science;
    case BrSliderWeather: return k_aid_slider_weather;
  }
}

- (NSString *) accessIdForSliderWithType:(BrSliderViewType) aType {
  switch (aType) {
    case BrSliderEmotion: return @"emotion slider";
    case BrSliderOffice: return @"office slider";
    case BrSliderScience: return @"science slider";
    case BrSliderWeather: return @"weather slider";
  }
}

- (UIImage *) imageForValue:(CGFloat) aValue
                       type:(BrSliderViewType) aType {
  NSString *name = [self nameForValue:aValue
                                 type:aType];
  return [UIImage imageNamed:name];
}

- (NSString *) nameForValue:(CGFloat) aValue
                       type:(BrSliderViewType) aType {
  BrSliderPosition position = [self positionForValue:aValue];
  switch (aType) {
    case BrSliderEmotion: {
       switch (position) {
         case kSliderMin: return @"sad";
         case kSliderNextToMin: return @"anxious";
         case kSliderMiddle: return @"bored";
         case kSliderNextToMax: return @"calm";
         case kSliderMax: return @"happy";
       }
    }
    case BrSliderOffice: {
      switch (position) {
        case kSliderMin: return @"cabinet";
        case kSliderNextToMin: return @"airplane";
        case kSliderMiddle: return @"clip";
        case kSliderNextToMax: return @"clipboard";
        case kSliderMax: return @"calendar";
      }
    }
    case BrSliderScience: {
      switch (position) {
        case kSliderMin: return @"scale";
        case kSliderNextToMin: return @"compass";
        case kSliderMiddle: return @"atom";
        case kSliderNextToMax: return @"beaker";
        case kSliderMax: return @"telescope";
      }
    }
    case BrSliderWeather: {
      switch (position) {
        case kSliderMin: return @"couldy";
        case kSliderNextToMin: return @"sunny";
        case kSliderMiddle: return @"overcast";
        case kSliderNextToMax: return @"rainy";
        case kSliderMax: return @"snowy";
      }
    }
  }
}


- (NSString *) titleForValue:(CGFloat) aValue
                        type:(BrSliderViewType)aType {
  BrSliderPosition position = [self positionForValue:aValue];
  NSString *name = [self nameForValue:aValue type:aType];
  return [name stringByAppendingFormat:@": '%d'", position];
}

- (NSString *) accessLabelForImageView:(CGFloat) aValue
                               type:(BrSliderViewType) aType {
  return [self nameForValue:aValue type:aType];
}

@end


typedef enum : NSInteger {
  kTagSlider = 9040,
  kTagImageView,
  kTagLabelTitle,
  kTagLabelValue
} view_tags;

static CGFloat const kLeftRightMargin = 8;
static CGFloat const kTopBottomMargin = 8;

static CGFloat const kWidthOfValueLabel = 52;

@interface BrSliderView ()

@property (strong, nonatomic, readonly) UISlider *slider;
@property (strong, nonatomic, readonly) UIImageView *imageView;
@property (strong, nonatomic, readonly) UILabel *labelTitle;
@property (strong, nonatomic, readonly) UILabel *labelValue;
@property (nonatomic, copy, readonly) BrSliderDidChangeBlock didChangeBlock;
@property (nonatomic, assign, readonly) BrSliderViewType type;
@property (nonatomic, strong, readonly) BrSliderDataSource *dataSource;

- (void) sliderValueDidChange:(id) sender;


- (CGRect) frameForSlider;
- (CGRect) frameForImageView;
- (CGRect) frameForLabelTitle;
- (CGRect) frameForLabelValue;

@end

@implementation BrSliderView

#pragma mark - Accessibility Element

- (BOOL) isAccessibilityElement { return YES; }

- (NSString *) accessibilityLabel { return nil; }

- (UIAccessibilityTraits) accessibilityTraits {
  return UIAccessibilityTraitAdjustable | UIAccessibilityTraitUpdatesFrequently;
}


#pragma mark - Memory Management

@synthesize slider = _slider;
@synthesize imageView = _imageView;
@synthesize labelTitle = _labelTitle;
@synthesize labelValue = _labelValue;
@synthesize type = _type;
@synthesize dataSource = _dataSource;
@synthesize didChangeBlock = _didChangeBlock;

- (id)initWithFrame:(CGRect) aFrame {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (id) initWithFrame:(CGRect) aFrame
                type:(BrSliderViewType) aType
                 tag:(NSInteger) aTag
      didChangeBlock:(BrSliderDidChangeBlock) aBlock {
  self = [super initWithFrame:aFrame];
  if (self) {
    _type = aType;
    self.tag = aTag;
    _didChangeBlock = aBlock;
    
    BrSliderDataSource *ds = [self dataSource];
    self.accessibilityIdentifier = [ds accessIdForViewWithType:_type];
  }
  return self;
}

- (BrSliderDataSource *) dataSource {
  if (_dataSource != nil) { return _dataSource; }
  _dataSource = [BrSliderDataSource new];
  return _dataSource;
}


- (UISlider *) slider {
  if (_slider != nil) { return _slider; }
  CGRect frame = [self frameForSlider];
  _slider = [[UISlider alloc] initWithFrame:frame];
  _slider.tag = kTagSlider;
  _slider.value = 0.0;
  _slider.minimumValue = -2.5;
  _slider.maximumValue = 2.0;
  
  BrSliderDataSource *ds = [self dataSource];
  _slider.accessibilityIdentifier = [ds accessIdForSliderWithType:_type];
  
  [_slider addTarget:self
              action:@selector(sliderValueDidChange:)
    forControlEvents:UIControlEventValueChanged];
  return _slider;
}

- (UIImageView *) imageView {
  if (_imageView != nil) { return _imageView; }
  CGRect frame = [self frameForImageView];
  _imageView = [[UIImageView alloc] initWithFrame:frame];
  BrSliderDataSource *ds = [self dataSource];
  UISlider *slider = [self slider];
  CGFloat sliderVal = [slider value];
  _imageView.image = [ds imageForValue:sliderVal type:_type];
  _imageView.tag = kTagImageView;
  _imageView.accessibilityLabel = [ds accessLabelForImageView:sliderVal type:_type];
  _imageView.accessibilityIdentifier = @"icon";
  return _imageView;
}

- (UILabel *) labelTitle {
  if (_labelTitle != nil) { return _labelTitle; }
  UISlider *slider = [self slider];
  CGRect frame = [self frameForLabelTitle];
  _labelTitle = [[UILabel alloc] initWithFrame:frame];
   BrSliderDataSource *ds = [self dataSource];
  _labelTitle.text = [ds titleForValue:[slider value] type:_type];
  _labelTitle.textAlignment = NSTextAlignmentCenter;
  _labelTitle.tag = kTagLabelTitle;
  _labelTitle.accessibilityIdentifier = @"title";
  return _labelTitle;
}

- (UILabel *) labelValue {
  if (_labelValue != nil) { return _labelValue; }
  UISlider *slider = [self slider];
  CGRect frame = [self frameForLabelValue];
  _labelValue = [[UILabel alloc] initWithFrame:frame];
  _labelValue.text = [NSString stringWithFormat:@"%.2f", [slider value]];
  _labelValue.textAlignment = NSTextAlignmentCenter;
  _labelValue.tag = kTagLabelValue;
  _labelValue.accessibilityIdentifier = @"value";
  return _labelValue;
}

- (void) layoutSubviews {
  [super layoutSubviews];

  UISlider *slider = [self slider];
  UIImageView *iv = [self imageView];
  UILabel *labelTitle = [self labelTitle];
  UILabel *labelValue = [self labelValue];
  

  if ([self viewWithTag:kTagSlider] == nil) {
    [self addSubview:slider];
  }
  
  if ([self viewWithTag:kTagImageView] == nil) {
    [self addSubview:iv];
  }
  
  if ([self viewWithTag:kTagLabelTitle] == nil) {
    [self addSubview:labelTitle];
  }
  
  if ([self viewWithTag:kTagLabelValue] == nil) {
    [self addSubview:labelValue];
  }
  
  NSLog(@"subviews = %@", [self subviews]);
}

- (void) respondToRotation {
  [[self slider] removeFromSuperview];
  _slider = nil;
  [[self imageView] removeFromSuperview];
  _imageView = nil;
  [[self labelTitle] removeFromSuperview];
  _labelTitle = nil;
  [[self labelValue] removeFromSuperview];
  _labelValue = nil;
}

- (CGRect) frameForSlider {
  CGRect selfF = self.frame;
  /*** UNEXPECTED ***
   super weird.  the slider is always visually ending up at y = 0 but 
   actually at y = 8 when the frame is set outside the init
   *****************/
  //CGFloat y = _slider == nil ? kTopBottomMargin : kTopBottomMargin + 8;
  CGFloat y = kTopBottomMargin;
  CGRect sliderF = CGRectMake(kLeftRightMargin, y,
                              CGRectGetWidth(selfF) - (2 * kLeftRightMargin),
                              0);
  return sliderF;
}

- (CGRect) frameForImageView {
  UISlider *slider = [self slider];
  CGRect sliderF = slider.frame;
  //CGFloat yoff = _imageView == nil ? 0 : kTopBottomMargin;
  CGFloat yoff = 0;
  CGRect ivF = CGRectMake(kLeftRightMargin, CGRectGetMaxY(sliderF) + yoff,
                          40, 40);
  return ivF;
}

- (CGRect) frameForLabelTitle {
  UIImageView *iv = [self imageView];
  CGRect ivF = iv.frame;
  CGRect selfF = self.frame;
  
  CGFloat xT = CGRectGetMaxX(ivF) + kLeftRightMargin;
  CGFloat hT = 21;
  CGFloat yT = CGRectGetMinY(ivF) + (CGRectGetHeight(ivF)/2 - (hT/2));
  CGFloat wT = CGRectGetWidth(selfF) - xT - kLeftRightMargin - kWidthOfValueLabel;
  CGRect titleF = CGRectMake(xT, yT, wT, hT);
  
  return titleF;
}

- (CGRect) frameForLabelValue {
  CGRect selfF = self.frame;
  UILabel *labelTitle = [self labelTitle];
  CGRect titleF = labelTitle.frame;
  
  CGFloat xV = CGRectGetWidth(selfF) - (2 * kLeftRightMargin) - kWidthOfValueLabel;
  CGFloat wV = kWidthOfValueLabel;
  CGRect valueF = CGRectMake(xV, CGRectGetMinY(titleF), wV, CGRectGetHeight(titleF));
  return valueF;
}


#pragma mark - Public

- (void) setSliderValue:(CGFloat) aValue animated:(BOOL) aAnimate {
  UISlider *slider = [self slider];
  [slider setValue:(float)aValue animated:aAnimate];
  [self sliderValueDidChange:slider];
}


#pragma mark - Actions

- (void) sliderValueDidChange:(UISlider *) aSlider {
  CGFloat value = [aSlider value];
  BrSliderDataSource *ds = [self dataSource];
  UIImageView *iv = [self imageView];
  [iv setImage:[ds imageForValue:value type:_type]];
  iv.accessibilityLabel = [ds accessLabelForImageView:value
                                                 type:_type];
  [[self labelTitle] setText:[ds titleForValue:value type:_type]];
  [[self labelValue] setText:[NSString stringWithFormat:@"%.2f", value]];
  BrSliderDidChangeBlock block = [self didChangeBlock];
  if (block != nil) { block(aSlider, _type); }
}


@end
