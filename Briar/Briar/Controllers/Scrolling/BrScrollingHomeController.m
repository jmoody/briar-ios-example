#import "BrScrollingHomeController.h"
#import "BrGlobals.h"
#import "BrAlphabetTableController.h"
#import "BrRecipeCollectionController.h"

typedef enum : NSInteger {
  kRowTable = 0,
  kRowCollectionView,
  kNumberOfRows
} rows;

typedef enum : NSInteger {
  kTagTable = 3030
} view_tags;



@interface BrScrollingHomeController ()
<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

- (NSString *) titleForRowAtIndexPath:(NSIndexPath *) aIndexPath;
- (NSString *) subtitleForRowAtIndexPath:(NSIndexPath *) aIndexPath;
- (NSString *) accessIdForRowAtIndexPath:(NSIndexPath *) aIndexPath;

- (void) cellTouchedAlphabetTable;
- (void) cellTouchedCollectionView;

@property (nonatomic, strong, readonly) UITableView *tableView;

@end

@implementation BrScrollingHomeController

@synthesize tableView = _tableView;

- (id) init {
  self = [super initNibless];
  if (self) {
    self.tabBarItem.image = [UIImage imageNamed:@"259-list"];
    self.title = NSLocalizedString(@"Scrolling Views", nil);
  }
  return self;
}


#pragma mark - Row Content

- (NSString *) titleForRowAtIndexPath:(NSIndexPath *) aIndexPath {
  NSUInteger row = (NSUInteger)[aIndexPath row];
  switch (row) {
    case kRowTable: return @"Alphabet Table";
    case kRowCollectionView: return @"Recipes Collection View";
    default: {
      NSString *reason = [NSString stringWithFormat:@"could not find row '%d'", row];
      @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                     reason:reason
                                   userInfo:nil];

    }
  }
  return nil;
}


- (NSString *) subtitleForRowAtIndexPath:(NSIndexPath *) aIndexPath {
  NSUInteger row = (NSUInteger)[aIndexPath row];
  switch (row) {
    case kRowTable: return @"a plain table view";
    case kRowCollectionView: return @"a collection view";
    default: {
      NSString *reason = [NSString stringWithFormat:@"could not find row '%d'", row];
      @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                     reason:reason
                                   userInfo:nil];
      
    }
  }
  return nil;
}


- (NSString *) accessIdForRowAtIndexPath:(NSIndexPath *) aIndexPath {
  NSUInteger row = (NSUInteger)[aIndexPath row];
  switch (row) {
    case kRowTable: return @"alphabet";
    case kRowCollectionView: return @"recipes";
    default: {
      NSString *reason = [NSString stringWithFormat:@"could not find row '%d'", row];
      @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                     reason:reason
                                   userInfo:nil];
      
    }
  }
  return nil;
}


#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *) aTableView numberOfRowsInSection:(NSInteger) aSection {
  return kNumberOfRows;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *) aTableView {
  return 1;
}

- (UITableViewCell *) tableView:(UITableView *) aTableView cellForRowAtIndexPath:(NSIndexPath *) aIndexPath {
  static NSString *const reuseId = @"reuse";
  
  UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:reuseId];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:reuseId];
  }
  
  cell.selectionStyle = UITableViewCellSelectionStyleGray;
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  cell.textLabel.text = [self titleForRowAtIndexPath:aIndexPath];
  cell.detailTextLabel.text = [self subtitleForRowAtIndexPath:aIndexPath];
  cell.accessibilityIdentifier = [self accessIdForRowAtIndexPath:aIndexPath];
  
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


#pragma mark - UITableViewDelegate


#pragma mark UITableViewDelegate  Providing Table Cells for the Table View

- (CGFloat) tableView:(UITableView *) aTableView heightForRowAtIndexPath:(NSIndexPath *) aIndexPath {
  return 54;
}

- (void) tableView:(UITableView *) aTableView willDisplayCell:(UITableViewCell *) aCell
 forRowAtIndexPath:(NSIndexPath *) aIndexPath {
  
}

#pragma mark - UITableViewDelegate Managing Selections


- (void) tableView:(UITableView *) aTableView didSelectRowAtIndexPath:(NSIndexPath *) aIndexPath {
  NSUInteger row = (NSUInteger)[aIndexPath row];
  switch (row) {
    case kRowTable: { [self cellTouchedAlphabetTable]; break; }
    case kRowCollectionView: { [self cellTouchedCollectionView]; break; }
    default: {
      NSString *reason = [NSString stringWithFormat:@"could not find row '%d'", row];
      @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                     reason:reason
                                   userInfo:nil];
      
    }
  }
  [aTableView deselectRowAtIndexPath:aIndexPath animated:YES];
}


- (void) tableView:(UITableView *) aTableView didDeselectRowAtIndexPath:(NSIndexPath *) aIndexPath {
  
}


#pragma mark - UIAlertView Delegate

- (void) alertViewCancel:(UIAlertView *) aAlertView {
  // implemented for calabash reset
}

- (void) alertView:(UIAlertView *) aAlertView clickedButtonAtIndex:(NSInteger) aButtonIndex {
  // nop
}

#pragma mark - Cell Touching

- (void) cellTouchedAlphabetTable {
  BrAlphabetTableController *atc = [BrAlphabetTableController new];
  [self.navigationController pushViewController:atc animated:YES];
}

- (void) cellTouchedCollectionView {
  if (br_is_iOS_5() == YES) {
    
    NSString *lat = NSLocalizedString(@"iOS 5 Detected!", nil);
    NSString *lam = NSLocalizedString(@"UICollectionViews are available starting iOS 6", nil);
    NSString *lok = NSLocalizedString(@"OK", nil);
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:lat
                          message:lam
                          delegate:self
                          cancelButtonTitle:lok
                          otherButtonTitles:nil];
    alert.accessibilityIdentifier = @"alert";
    [alert show];
    return;
  }
  
  BrRecipeCollectionController *rcc = [BrRecipeCollectionController new];
  [self.navigationController pushViewController:rcc animated:YES];
}

#pragma mark - Subviews

- (UITableView *) tableView {
  if (_tableView != nil) { return _tableView; }
  CGRect frame = CGRectMake(0, 0, 320, br_iphone_y_max());
  UITableView *table = [[UITableView alloc]
                        initWithFrame:frame
                        style:UITableViewStylePlain];
  
  table.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
  
  table.bounds = frame;
  table.backgroundView = nil;
  
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
  if ([table respondsToSelector:@selector(separatorInset)]) {
    table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
  }
#endif
  
  [table setAutoresizesSubviews:YES];
  
  
  table.delegate = self;
  table.dataSource = self;
  
  table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  table.accessibilityIdentifier = @"table";
  table.accessibilityLabel = NSLocalizedString(@"Kinds of scrolling views", nil);
  table.scrollEnabled = YES;
  table.tag = kTagTable;
  _tableView = table;
  return _tableView;
}


#pragma mark - View Layout

- (void) viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  
  UIView *view = self.view;
  if ([view viewWithTag:kTagTable] == nil) {
    [view addSubview:[self tableView]];
  }
  
  //self.navigationItem.title = NSLocalizedString(@"Views That Scroll", nil);
}

- (void) viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
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
  self.view.accessibilityIdentifier = @"scrolling views home";
  self.view.accessibilityLabel = NSLocalizedString(@"Scrolling views home", nil);
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
