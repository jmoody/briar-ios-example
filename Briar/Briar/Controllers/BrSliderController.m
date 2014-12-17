#import "BrSliderController.h"
#import "BrGlobals.h"
#import "BrSliderView.h"

typedef enum : NSInteger {
  kTagEmotions = 3030,
  kTagTable,
  kTagRowContent_Slider = 4040
} view_tags;

typedef enum : NSInteger {
  kSectionSliders = 0,
  kNumberOfSections
} BrSliderTableSections;

typedef enum : NSInteger {
  kSliderRowOffice = 0,
  kSliderRowScience,
  kSliderRowWeather,
  kNumberOfSliderRows
} BrSliderTableSliderRows;

static CGFloat const kHeightOfRow_default = 80;

static NSString *const k_aid_table = @"table";

@interface BrSliderController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readonly) BrSliderView *sliderEmotions;
@property (nonatomic, strong, readonly) BrSliderView *sliderOffice;
@property (nonatomic, strong, readonly) BrSliderView *sliderScience;
@property (nonatomic, strong, readonly) BrSliderView *sliderWeather;

@property (nonatomic, strong, readonly) UITableView *table;

- (BrSliderView *) sliderForRowAtIndexPath:(NSIndexPath *) aIndexPath;
- (UIColor *) colorForSliderBackgroundAtIndexPath:(NSIndexPath *) aIndexPath;
- (CGRect) frameForEmotionSliderWithOrientation:(UIInterfaceOrientation) aOrienation;
- (CGRect) frameForTableWithOrientation:(UIInterfaceOrientation) aOrienation;
- (CGFloat) heightOfRow;
- (NSString *) accessIdForCellAtIndexPath:(NSIndexPath *) aIndexPath;


@end

@implementation BrSliderController

#pragma mark - Memory Management

@synthesize frames = _frames;
@synthesize sliderEmotions = _sliderEmotions;
@synthesize table = _table;
@synthesize sliderOffice = _sliderOffice;
@synthesize sliderScience = _sliderScience;
@synthesize sliderWeather = _sliderWeather;

- (id) init {
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"Sliders", @"slider controller:  title of slider tab bar item");
    self.tabBarItem.image = [UIImage imageNamed:@"833-diamond"];
    self.navbarTitle = @"Slider Related";
  }
  return self;
}

- (NSMutableDictionary *) frames {
  if (_frames != nil) { return _frames; }
  _frames = [NSMutableDictionary dictionary];
  return _frames;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
  
  [super viewDidUnload];
}


#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *) aTableView numberOfRowsInSection:(NSInteger) aSection {
  return kNumberOfSliderRows;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *) aTableView {
  return kNumberOfSections;
}

- (NSString *) accessIdForCellAtIndexPath:(NSIndexPath *) aIndexPath {
  NSInteger row = aIndexPath.row;
  switch (row) {
    case kSliderRowOffice: return @"office";
    case kSliderRowScience: return @"science";
    case kSliderRowWeather: return  @"weather";
    default: return @"FIXME";
  }
}

- (UITableViewCell *) tableView:(UITableView *) aTableView cellForRowAtIndexPath:(NSIndexPath *) aIndexPath {
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:nil];
  
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  UIView *cv = [cell contentView];
  BrSliderView *sliderView = [self sliderForRowAtIndexPath:aIndexPath];
  [cv addSubview:sliderView];
  cell.accessibilityIdentifier = [self accessIdForCellAtIndexPath:aIndexPath];
  return cell;
}

#pragma mark - UITableViewDataSource Inserting or Deleting Table Rows

- (BOOL) tableView:(UITableView *) aTableView canEditRowAtIndexPath:(NSIndexPath *) aIndexPath {
  return NO;
}

#pragma mark - UITableViewDataSource Reordering Table Rows

- (BOOL) tableView:(UITableView *) aTableView canMoveRowAtIndexPath:(NSIndexPath *) aIndexPath {
  return NO;
}

#pragma mark - Configuring Rows for Table View

- (CGFloat) heightOfRow {
  CGFloat iOS7adj = br_is_iOS_7() ? 20 : 0;
  return kHeightOfRow_default + iOS7adj;
}

- (CGFloat) tableView:(UITableView *) aTableView estimatedHeightForRowAtIndexPath:(NSIndexPath *) aIndexPath {
  return [self heightOfRow];
}

- (CGFloat) tableView:(UITableView *) aTableView heightForRowAtIndexPath:(NSIndexPath *) aIndexPath {
  return [self heightOfRow];
}

- (UIColor *) colorForSliderBackgroundAtIndexPath:(NSIndexPath *) aIndexPath {
  NSInteger row = aIndexPath.row;
  switch (row) {
    case kSliderRowOffice: return [[UIColor greenColor] colorWithAlphaComponent:0.05f];
    case kSliderRowScience: return [[UIColor purpleColor] colorWithAlphaComponent:0.05f];
    case kSliderRowWeather: return  [[UIColor cyanColor] colorWithAlphaComponent:0.05f];
    default: return [[UIColor blackColor] colorWithAlphaComponent:0.05f];
  }
}

- (void) tableView:(UITableView *) aTableView willDisplayCell:(UITableViewCell *) aCell forRowAtIndexPath:(NSIndexPath *) aIndexPath {
  UIView *cv = [aCell contentView];
  BrSliderView *sliderView = (BrSliderView *)[cv viewWithTag:kTagRowContent_Slider];
  sliderView.backgroundColor = [self colorForSliderBackgroundAtIndexPath:aIndexPath];
}

#pragma mark - Editing Table Rows

- (UITableViewCellEditingStyle) tableView:(UITableView *) aTableView editingStyleForRowAtIndexPath:(NSIndexPath *) aIndexPath {
  return  UITableViewCellEditingStyleNone;
}

#pragma mark - Managing Table View Highlighting

- (BOOL) tableView:(UITableView *) aTableView shouldHighlightRowAtIndexPath:(NSIndexPath *) aIndexPath {
  return NO;
}

#pragma mark - Animations


#pragma mark - Gestures


#pragma mark - Orientation iOS 5


#pragma mark - Orientation iOS 6

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation) aFromInterfaceOrientation {
  if (_table != nil) {
    [_table reloadData];
  }
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval) aDuration {
  __weak typeof(self) wself = self;
  [UIView animateWithDuration:aDuration
                   animations:^{
                     [wself layoutSubviewsForCurrentOrientation:[wself viewsToRotate]];
                   }];
  
  if (_sliderEmotions != nil) {
    [_sliderEmotions respondToRotation];
  }
}


#pragma mark - View Layout

- (BrSliderView *) sliderEmotions {
  if (_sliderEmotions != nil) { return _sliderEmotions; }
  UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
  CGRect frame = [self frameForEmotionSliderWithOrientation:orientation];
  _sliderEmotions = [[BrSliderView alloc]
                     initWithFrame:frame
                     type:BrSliderEmotion
                     tag:kTagEmotions
                     didChangeBlock:^(UISlider *aSlider, BrSliderViewType aType) {
                       NSLog(@"emotion slider updated");
                     }];
  _sliderEmotions.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.05f];

  return _sliderEmotions;
}


- (BrSliderView *) sliderOffice {
  if (_sliderOffice != nil) { return _sliderOffice; }
  CGFloat h = br_is_iOS_7() ? 88 : 72;
  CGFloat y = ([self heightOfRow]/2) - (h/2);
  UITableView *table = [self table];
  CGFloat maxW = CGRectGetWidth(table.frame);
  CGFloat x = 10;
  CGRect frame = CGRectMake(10, y, maxW - (2.0f * x), h);
  _sliderOffice = [[BrSliderView alloc]
                   initWithFrame:frame
                   type:BrSliderOffice
                   tag:kTagRowContent_Slider
                   didChangeBlock:^(UISlider *aSlider, BrSliderViewType aType) {
                     NSLog(@"office slider updated");
                   }];
  return _sliderOffice;
}

- (BrSliderView *) sliderScience {
  if (_sliderScience != nil) { return _sliderScience; }
  CGFloat h = br_is_iOS_7() ? 88 : 72;
  CGFloat y = ([self heightOfRow]/2) - (h/2);
  UITableView *table = [self table];
  CGFloat maxW = CGRectGetWidth(table.frame);
  CGFloat x = 10;
  CGRect frame = CGRectMake(10, y, maxW - (2.0f * x), h);
  _sliderScience = [[BrSliderView alloc]
                    initWithFrame:frame
                    type:BrSliderScience
                    tag:kTagRowContent_Slider
                    didChangeBlock:^(UISlider *aSlider, BrSliderViewType aType) {
                     NSLog(@"office slider updated");
                   }];
  return _sliderScience;
}

- (BrSliderView *) sliderWeather {
  if (_sliderWeather != nil) { return _sliderWeather; }
  CGFloat h = br_is_iOS_7() ? 88 : 72;
  CGFloat y = ([self heightOfRow]/2) - (h/2);
  UITableView *table = [self table];
  CGFloat maxW = CGRectGetWidth(table.frame);
  CGFloat x = 10;
  CGRect frame = CGRectMake(10, y, maxW - (2.0f * x), h);
  _sliderWeather = [[BrSliderView alloc]
                    initWithFrame:frame
                    type:BrSliderWeather
                    tag:kTagRowContent_Slider
                    didChangeBlock:^(UISlider *aSlider, BrSliderViewType aType) {
                      NSLog(@"office slider updated");
                    }];
  return _sliderWeather;
}


- (BrSliderView *) sliderForRowAtIndexPath:(NSIndexPath *) aIndexPath {
  NSInteger row = aIndexPath.row;
  switch (row) {
    case kSliderRowOffice: return [self sliderOffice];
    case kSliderRowScience: return [self sliderScience];
    case kSliderRowWeather: return [self sliderWeather];
    default: return nil;
  }
}

- (UITableView *) table {
  if (_table != nil) { return _table; }
  
  UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
  CGRect frame = [self frameForTableWithOrientation:orientation];
  
  
  UITableView *t = [[UITableView alloc]
                    initWithFrame:frame
                    style:UITableViewStylePlain];
  
  t.sectionFooterHeight = 0;
  t.sectionHeaderHeight = 0;
  
  t.tableHeaderView = [[UIView alloc] init];
  t.tableFooterView = [[UIView alloc] init];
  
  t.tag = kTagTable;
  
  t.accessibilityLabel = @"list of sliders";
  t.accessibilityIdentifier = k_aid_table;

  
  t.backgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.05f];
  t.delegate = self;
  t.dataSource = self;
  _table = t;
  return _table;
}

- (void) viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
 
}

- (void) viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  UIView *view = self.view;
  if ([view viewWithTag:kTagEmotions] == nil) {
    [view addSubview:[self sliderEmotions]];
  }
  
  if ([view viewWithTag:kTagTable] == nil) {
    [view addSubview:[self table]];
  }
}

- (CGRect) frameForEmotionSliderWithOrientation:(UIInterfaceOrientation) aOrienation {
  CGFloat ipadYAdj = br_is_ipad() ? 20 : 0;
  CGFloat iOS7adj = br_is_iOS_7() ? 16 : 0;
  CGFloat w = CGRectGetWidth(self.view.frame);
  if (UIInterfaceOrientationIsLandscape(aOrienation)) {
    return CGRectMake(10, 60 + ipadYAdj, w - 20, 72 + iOS7adj);
  } else {
    return CGRectMake(10, 72, w - 20, 72 + iOS7adj);
  }
}

- (CGRect) frameForTableWithOrientation:(UIInterfaceOrientation) aOrienation {
  CGFloat ipadYAdj = br_is_ipad() ? 20 : 0;
  CGFloat iOS7adj = br_is_iOS_7() ? 10 : 0;
  CGFloat viewW = CGRectGetWidth(self.view.frame);
  CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
  if (UIInterfaceOrientationIsLandscape(aOrienation)) {
    CGFloat w = br_iphone_x_max();
    CGFloat x = (viewW/2) - (w/2);
    CGFloat y = 140 + iOS7adj + ipadYAdj;
    CGFloat h;
    if (br_is_ipad()) {
      h = 768 - y - tabBarHeight;
    } else {
      h = 128;
    }
    return CGRectMake(x, y, w, h);
  } else {
    CGFloat y = 152 + iOS7adj + ipadYAdj;
    CGFloat h;
    if (br_is_ipad()) {
      h = 1024 - y - tabBarHeight;
    } else {
      h = br_iphone_y_max() - y - tabBarHeight;
    }
    return CGRectMake(0, y, viewW, h);
  }

}

- (CGRect) frameForView:(UIView *) aView
            orientation:(UIInterfaceOrientation) aOrientation {
  NSString *aid = aView.accessibilityIdentifier;
  NSString *key = [NSString stringWithFormat:@"%@ - %@", aid, @(aOrientation)];
  NSString *str = [self frames][key];
  CGRect frame = CGRectZero;
  if (str != nil) {
    frame = CGRectFromString(str);
  } else {
    
    /*
    CGFloat w = CGRectGetWidth(self.view.frame);
    
    UIInterfaceOrientation l = UIInterfaceOrientationLandscapeLeft;
    UIInterfaceOrientation r = UIInterfaceOrientationLandscapeRight;
    UIInterfaceOrientation t = UIInterfaceOrientationPortraitUpsideDown;
    UIInterfaceOrientation b = UIInterfaceOrientationPortrait;
    UIInterfaceOrientation o = aOrientation;
    CGFloat ipadYAdj = br_is_ipad() ? 20 : 0;
    */

    if ([k_aid_slider_emotions isEqualToString:aid]) { frame = [self frameForEmotionSliderWithOrientation:aOrientation]; }
    if ([k_aid_table isEqualToString:aid]) { frame = [self frameForTableWithOrientation:aOrientation]; }

    
    _frames[key] = NSStringFromCGRect(frame);
  
  }
     
  return frame;
}

- (NSArray *) viewsToRotate {
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:2];
  if (_sliderEmotions != nil) { [array addObject:_sliderEmotions]; }
  if (_table != nil) { [array addObject:_table]; }
  return [NSArray arrayWithArray:array];
}

#pragma mark - Accessibility

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  //[self layoutSubviewsForCurrentOrientation:[self viewsToRotate]];
  self.view.accessibilityIdentifier = @"sliders";
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (void) resetSliders {
  [[self sliderEmotions] setSliderValue:0.0 animated:NO];
  [[self sliderOffice] setSliderValue:0.0 animated:NO];
  [[self sliderScience] setSliderValue:0.0 animated:NO];
  [[self sliderWeather] setSliderValue:0.0 animated:NO];
}
@end
