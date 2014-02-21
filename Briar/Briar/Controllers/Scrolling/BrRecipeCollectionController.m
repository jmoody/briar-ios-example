#import "BrRecipeCollectionController.h"
#import "BrGlobals.h"

@interface BrRecipeCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *picture;

@end

@implementation BrRecipeCell

@synthesize picture = _picture;

- (id) initWithFrame:(CGRect) aRect {
  self = [super initWithFrame:aRect];
  if (self) {

    UIView *contentView = [self contentView];

    CGFloat padding = 10;
    CGFloat width = CGRectGetWidth(aRect) - (2 * padding);
    CGFloat height = CGRectGetHeight(aRect) - (2 * padding);
    CGRect frame = CGRectMake(padding, padding, width, height);
    _picture = [[UIImageView alloc] initWithFrame:frame];
    
    [contentView addSubview:_picture];
  }
  return self;
}



@end

typedef enum : NSInteger {
  kTagCollectionView = 3030
} view_tags;

typedef enum : NSInteger {
  kTagCellImageView = 1010
} collect_content_tags;

typedef enum : NSInteger {
  kSectionOne = 0,
  kSectionTwo,
  kSectionThree,
  kSectionFour,
  kSectionFive,
  kNumberOfSections
} sections;

static NSString *const kRecipeCellIdentifier = @"recipe cell";

@interface BrRecipeCollectionController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) NSArray *imageNames;
@property (nonatomic, strong, readonly) NSArray *itemAccessLabels;
@property (nonatomic, strong, readonly) NSArray *itemAccessIds;


@end

@implementation BrRecipeCollectionController

@synthesize collectionView = _collectionView;
@synthesize imageNames = _imageNames;
@synthesize itemAccessIds = _itemAccessIds;
@synthesize itemAccessLabels = _itemAccessLabels;

- (id) initNibless {
  self = [super initNibless];
  if (self) {

  }
  return self;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionView DataSource/Delegate

- (NSArray *) imageNames {
  if (_imageNames != nil && [_imageNames count] != 0) { return _imageNames; }
  _imageNames = @[@"angry_birds_cake.jpg",
                  @"creme_brelee.jpg",
                  @"egg_benedict.jpg",
                  @"full_breakfast.jpg",
                  @"green_tea.jpg",
                  @"ham_and_cheese_panini.jpg",
                  @"ham_and_egg_sandwich.jpg",
                  @"hamburger.jpg",
                  @"instant_noodle_with_egg.jpg",
                  @"japanese_noodle_with_pork.jpg",
                  @"mushroom_risotto.jpg",
                  @"noodle_with_bbq_pork.jpg",
                  @"starbucks_coffee.jpg",
                  @"thai_shrimp_cake.jpg",
                  @"vegetable_curry.jpg",
                  @"white_chocolate_donut.jpg"];
  return _imageNames;
}

- (NSArray *) itemAccessIds {
  if (_itemAccessIds != nil && [_itemAccessIds count] != 0) { return _itemAccessIds; }
  _itemAccessIds = @[@"angry birds",
                     @"creme brulee",
                     @"eggs benedict",
                     @"full breakfast",
                     @"green tea",
                     @"ham and cheese panini",
                     @"ham and egg sandwich",
                     @"hamburger",
                     @"noodles with egg",
                     @"noodles with pork",
                     @"mushroom risotto",
                     @"noodles with bbq pork",
                     @"starbucks coffee",
                     @"thai shrimp cake",
                     @"vegetable curry",
                     @"donut"];
  return _itemAccessIds;
}

- (NSArray *) itemAccessLabels {
  if (_itemAccessLabels != nil && [_itemAccessLabels count] != 0) { return _itemAccessLabels; }
  _itemAccessLabels = @[@"Angry birds cake",
                     @"Crème brûlée",
                     @"Eggs benedict",
                     @"Full breakfast",
                     @"Green tea",
                     @"Ham and cheese panini",
                     @"Ham and egg sandwich",
                     @"Hamburger",
                     @"Noodles with egg",
                     @"Noodles with pork",
                     @"Mushroom risotto",
                     @"Noodles with bbq pork",
                     @"Starbucks coffee",
                     @"Thai shrimp cake",
                     @"Vegetable curry",
                     @"Donut"];
  return _itemAccessLabels;
}



- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *) aCollectionView {
  return kNumberOfSections;
}

- (NSInteger) collectionView:(UICollectionView *) aCollectionView numberOfItemsInSection:(NSInteger) aSection {
  return 2;
  //return (aSection == kSectionFive) ? 1 : 2;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *) aCollectionView cellForItemAtIndexPath:(NSIndexPath *) aIndexPath {
  BrRecipeCell *cell = (BrRecipeCell *)[aCollectionView dequeueReusableCellWithReuseIdentifier:kRecipeCellIdentifier
                                                                                  forIndexPath:aIndexPath];

  NSUInteger imageIndex = (NSUInteger)(aIndexPath.item + (aIndexPath.section * 3));
  
  UIImage *image = [UIImage imageNamed:[[self imageNames] objectAtIndex:imageIndex]];
  cell.picture.image = image;
  cell.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];

  cell.accessibilityIdentifier = [[self itemAccessIds] objectAtIndex:imageIndex];
  cell.accessibilityLabel = [[self itemAccessLabels] objectAtIndex:imageIndex];
  cell.contentView.accessibilityIdentifier = [NSString stringWithFormat:@"content id '%d'", imageIndex];
  cell.contentView.accessibilityLabel = [NSString stringWithFormat:@"content label '%d'", imageIndex];
  return cell;
}

- (CGSize) collectionView:(UICollectionView *) aCollectionView
                   layout:(UICollectionViewLayout*) aCollectionViewLayout
   sizeForItemAtIndexPath:(NSIndexPath *) aIndexPath {
  return CGSizeMake(150, 200);
}

- (void) collectionView:(UICollectionView *)collectionView
   didEndDisplayingCell:(UICollectionViewCell *) aCell
     forItemAtIndexPath:(NSIndexPath *) aIndexPath {
 
}


#pragma mark - Subviews

- (UICollectionView *) collectionView {
  if (_collectionView != nil) { return _collectionView; }
  CGRect frame = CGRectMake(0, 64, 320, br_iphone_y_max());

  UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
  layout.headerReferenceSize = CGSizeMake(320, 10);
  layout.footerReferenceSize = CGSizeMake(320, 10);
  
  UICollectionView *cv = [[UICollectionView alloc]
                          initWithFrame:frame
                          collectionViewLayout:layout];
  cv.dataSource = self;
  cv.delegate = self;
  
  [cv registerClass:[BrRecipeCell class]
      forCellWithReuseIdentifier:kRecipeCellIdentifier];

  cv.tag = kTagCollectionView;
  cv.accessibilityIdentifier = @"recipe collection";
  cv.accessibilityLabel = @"Recipes";
  

  
  _collectionView = cv;
  return _collectionView;
}


#pragma mark - View Layout

- (void) viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
}

- (void) viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  UIView *view = self.view;
  
  if ([view viewWithTag:kTagCollectionView] == nil) {
    [view addSubview:[self collectionView]];
  }
}

#pragma mark - View Lifecycle

- (void) loadView {
  CGRect frame = [[UIScreen mainScreen] applicationFrame];
  UIView *view = [[UIView alloc] initWithFrame:frame];
  view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.view = view;
}

- (void) viewDidLoad {
  [super viewDidLoad];
  self.view.accessibilityIdentifier = @"recipes page";
  self.navigationItem.title = NSLocalizedString(@"Recipes", nil);
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
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

@end
