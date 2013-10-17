#import "BrSliderView.h"

typedef enum : short {
  kSliderMin = -2,
  kSliderNextToMin = -1,
  kSliderMiddle = 0,
  kSliderNextToMax = 1,
  kSliderMax = 2
} BrSliderPosition;



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
    case BrSliderEmotion: return @"emotions";
    case BrSliderOffice: return @"office";
    case BrSliderScience: return @"science";
    case BrSliderWeather: return @"weather";
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
  kTagSlider = 4040,
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
  CGRect selfF = self.frame;
  CGRect frame = CGRectMake(kLeftRightMargin, kTopBottomMargin,
                            CGRectGetWidth(selfF) - (2 * kLeftRightMargin),
                            0);
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
  UISlider *slider = [self slider];
  CGRect sliderF = slider.frame;
  CGRect frame = CGRectMake(kLeftRightMargin, CGRectGetMaxY(sliderF) + kTopBottomMargin,
                            40, 40);
  _imageView = [[UIImageView alloc] initWithFrame:frame];
  BrSliderDataSource *ds = [self dataSource];
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
  
  CGRect selfF = self.frame;

  UIImageView *iv = [self imageView];
  CGRect ivF = iv.frame;
  
  CGFloat x = CGRectGetMaxX(ivF) + kLeftRightMargin;
  CGFloat h = 21;
  CGFloat y = CGRectGetMinY(ivF) + (CGRectGetHeight(ivF)/2 - (h/2));
  CGFloat w = CGRectGetWidth(selfF) - x - kLeftRightMargin - kWidthOfValueLabel;
  CGRect frame = CGRectMake(x, y, w, h);
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
  
  CGRect selfF = self.frame;
  UILabel *titleLabel = [self labelTitle];
  CGRect titleF = titleLabel.frame;

  CGFloat x = CGRectGetWidth(selfF) - (2 * kLeftRightMargin) - kWidthOfValueLabel;
  CGFloat h = 21;
  CGFloat y = CGRectGetMinY(titleF);
  CGFloat w = kWidthOfValueLabel;
  CGRect frame = CGRectMake(x, y, w, h);
  _labelValue = [[UILabel alloc] initWithFrame:frame];
  _labelValue.text = [NSString stringWithFormat:@"%.2f", [slider value]];
  _labelValue.textAlignment = NSTextAlignmentCenter;
  _labelValue.tag = kTagLabelValue;
  _labelValue.accessibilityIdentifier = @"value";
  return _labelValue;
}

- (void) layoutSubviews {
  [super layoutSubviews];
  
  if ([self viewWithTag:kTagSlider] == nil) {
    [self addSubview:[self slider]];
  }
  
  if ([self viewWithTag:kTagImageView] == nil) {
    [self addSubview:[self imageView]];
  }
  
  if ([self viewWithTag:kTagLabelTitle] == nil) {
    [self addSubview:[self labelTitle]];
  }
  
  if ([self viewWithTag:kTagLabelValue] == nil) {
    [self addSubview:[self labelValue]];
  }
}

#pragma mark - Public

- (void) setSliderValue:(CGFloat) aValue animated:(BOOL) aAnimate {
  UISlider *slider = [self slider];
  [slider setValue:aValue animated:aAnimate];
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
