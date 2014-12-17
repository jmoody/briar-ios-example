#import "BrAlphabetTableController.h"
#import "BrCategories.h"
#import "BrGlobals.h"



typedef enum : NSUInteger {
  kTagTableRowTitle = 3030,
  kTagTable
} ViewTags;


@interface BrAlphabetTableController ()


@property (nonatomic, strong, readonly) UITableView *tableView;

@property (nonatomic, copy) NSArray *titles;
- (NSString *) titleForRowWithPath:(NSIndexPath *) aPath;
- (UILabel *) labelForRowAtIndexPath:(NSIndexPath *) aPath;


@end

@implementation BrAlphabetTableController

@synthesize tableView = _tableView;

- (id) init {
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"The Alphabet", @"table controller: appears as title and as tab button title");
    self.titles = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n"];
  }
  return self;
}
							
- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.view.accessibilityIdentifier = @"alphabet";
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (NSString *) titleForRowWithPath:(NSIndexPath *) aPath {
  //%1$@
  NSString *fmtStr =  NSLocalizedStringWithDefaultValue(@"KEY (FMT STR): title of row in alphabet table",
                                                        nil,
                                                        [NSBundle mainBundle],
                                                        @"the letter '%1$@' row",
                                                        @"ex.  the letter 'p' row");
  return [NSString stringWithFormat:fmtStr, (self.titles)[(NSUInteger)aPath.row]];
}

- (UILabel *) labelForRowAtIndexPath:(NSIndexPath *) aPath {
  NSString *title = [self titleForRowWithPath:aPath];
  
  UIFont *font = [UIFont systemFontOfSize:18];
  CGFloat w = 300;
  CGSize labelSize = [title sizeWithFont:font
                       constrainedToSize:CGSizeMake(w, CGFLOAT_MAX)
                           lineBreakMode:NSLineBreakByWordWrapping];
  CGFloat cellH = [self tableView:nil heightForRowAtIndexPath:aPath];
  CGFloat h = labelSize.height;
  CGFloat y = (cellH/2) - (h/2);
  CGRect frame = CGRectMake(10, y, w, h);
  UILabel *label = [[UILabel alloc] initWithFrame:frame];
  label.text = title;
  label.tag = kTagTableRowTitle;
  label.accessibilityIdentifier = @"title";
  return label;
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *) aTableView numberOfRowsInSection:(NSInteger) aSection {
  return (NSInteger)[self.titles count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *) aTableView {
  return 1;
}


- (UITableViewCell *) tableView:(UITableView *) aTableView cellForRowAtIndexPath:(NSIndexPath *) aIndexPath {
  static NSString *identifier = @"row id";
  UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:identifier];

  if (cell == nil) {
    NSLog(@"did not reuse");
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    UIView *cv = cell.contentView;
    [cv addSubview:[self labelForRowAtIndexPath:aIndexPath]];
    cell.accessibilityIdentifier = (self.titles)[(NSUInteger)aIndexPath.row];
    return cell;
  }

  NSLog(@"did reuse");
  UIView *cv = cell.contentView;
  UILabel *label = (UILabel *)[cv viewWithTag:kTagTableRowTitle];
  label.text = [self titleForRowWithPath:aIndexPath];
  cell.accessibilityIdentifier = (self.titles)[(NSUInteger)aIndexPath.row];

  return cell;
}

#pragma mark - UITableViewDelegate


#pragma mark UITableViewDelegate  Providing Table Cells for the Table View

- (CGFloat) tableView:(UITableView *) aTableView heightForRowAtIndexPath:(NSIndexPath *) aIndexPath {
  /*******  UNEXPECTED ******
   this size is required to reproduce:
   https://github.com/calabash/calabash-ios/issues/128
   https://groups.google.com/d/msg/calabash-ios/L6OmNnbhPW0/0fzLX-DJl-UJ
   
   **************************/
  return br_is_4in_iphone() ? 47 : 43;
}



#pragma mark - UITableViewDelegate Managing Selections


- (void) tableView:(UITableView *) aTableView didSelectRowAtIndexPath:(NSIndexPath *) aIndexPath {
  NSString *ltitle = NSLocalizedString(@"Alphabet Alert", @"tables:  title of an alert that appears when row is touched");
  NSString *lmsgFmt = NSLocalizedStringWithDefaultValue(@"KEY (FMT STR): alphabet alert message",
                                                        nil,
                                                        [NSBundle mainBundle],
                                                        @"'%1$@' is a great letter!",
                                                        @"ex.  'p' is a greate letter!");
  NSString *letter = (self.titles)[(NSUInteger)aIndexPath.row];
  NSString *lmsg = [NSString stringWithFormat:lmsgFmt, letter];
  NSString *lcancel = NSLocalizedString(@"Cancel", @"tables:  title cancel-alert button on alphabet alert");
  NSString *lok = NSLocalizedString(@"OK", @"tables: title alert-action button on alphabet alert");
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ltitle
                                                  message:lmsg
                                                 delegate:self
                                        cancelButtonTitle:lcancel
                                        otherButtonTitles:lok, nil];
  alert.accessibilityIdentifier = [NSString stringWithFormat:@"%@ alert", letter];
  [alert show];
  
  
  double delayInSeconds = 0.2;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [aTableView deselectRowAtIndexPath:aIndexPath animated:YES];
  });
  
}

- (void) tableView:(UITableView *) aTableView didDeselectRowAtIndexPath:(NSIndexPath *) aIndexPath {
  
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewCellEditingStyleDelete;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}


- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    NSLog(@"committing...and crashing");
  }
}

#pragma mark - UIAlertView Delegate

- (void) alertView:(UIAlertView *) aAlertView clickedButtonAtIndex:(NSInteger) aIndex {
  NSLog(@"alert view button touched: %@", @(aIndex));
  // nothing to do really
}


#pragma mark - Animations

#pragma mark - View Layout

- (UITableView *) tableView {
  if (_tableView != nil) { return _tableView; }
  

  CGFloat height = br_iphone_y_max() - 49;
  CGFloat width = br_iphone_x_max();

  CGRect rect = CGRectMake(0, 0, width, height);
  UITableViewStyle style = UITableViewStylePlain;
  UITableView *table  = [[UITableView alloc] initWithFrame:rect
                                                     style:style];
  table.bounds = rect;
  table.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
  table.backgroundColor = [UIColor whiteColor];
  [table setAutoresizesSubviews:YES];
  [table setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
  table.delegate = self;
  table.dataSource = self;
  table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  
  table.tableFooterView = [UIView new];
  table.sectionFooterHeight = 0.0;

  table.accessibilityIdentifier = @"table";
  table.accessibilityLabel = NSLocalizedString(@"List of letters", nil);
  table.tag = kTagTable;
  _tableView = table;
  return table;
}

- (void) viewWillLayoutSubviews {
  NSLog(@"will layout subviews");
}

- (void) viewDidLayoutSubviews {
  NSLog(@"did layout subviews");
  
  UIView *view = self.view;
  
  if ([view viewWithTag:kTagTable] == nil) {
    UITableView *table = [self tableView];
    [view addSubview:table];
  }
}


#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  
  [[self tableView] scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                      atScrollPosition:UITableViewScrollPositionTop
                              animated:NO];

}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
} 

@end
