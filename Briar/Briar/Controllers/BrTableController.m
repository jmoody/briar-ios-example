#import "BrTableController.h"
#import "BrCategories.h"
#import "BrGlobals.h"

typedef enum : NSUInteger {
  kTagTableRowTitle = 3030,
  kTagTable
} ViewTags;


@interface BrTableController ()

@property (nonatomic, copy) NSArray *titles;
- (NSString *) titleForRowWithPath:(NSIndexPath *) aPath;

@end

@implementation BrTableController

- (id) init {
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"Tables", @"table controller: appears as title and as tab button title");
    self.tabBarItem.image = [UIImage imageNamed:@"259-list"];
    self.titles = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n"];
  }
  return self;
}
							
- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.view.accessibilityIdentifier = @"tables";
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
  return [NSString stringWithFormat:fmtStr, [self.titles objectAtIndex:aPath.row]];
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *) aTableView numberOfRowsInSection:(NSInteger) aSection {
  return [self.titles count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *) aTableView {
  return 1;
}


- (UITableViewCell *) tableView:(UITableView *) aTableView cellForRowAtIndexPath:(NSIndexPath *) aIndexPath {
  static NSString *identifier = @"row id";
  UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:identifier];

  

  if (cell == nil) {
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }

  cell.textLabel.tag = kTagTableRowTitle;
  cell.textLabel.text = [self titleForRowWithPath:aIndexPath];
  cell.textLabel.accessibilityIdentifier = @"title";
  cell.accessibilityIdentifier = [self.titles objectAtIndex:aIndexPath.row];

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
  return [BrGlobals isDeviceIphone5] ? 47 : 43;
}



#pragma mark - UITableViewDelegate Managing Selections


- (void) tableView:(UITableView *) aTableView didSelectRowAtIndexPath:(NSIndexPath *) aIndexPath {
  NSString *ltitle = NSLocalizedString(@"Alphabet Alert", @"tables:  title of an alert that appears when row is touched");
  NSString *lmsgFmt = NSLocalizedStringWithDefaultValue(@"KEY (FMT STR): alphabet alert message",
                                                        nil,
                                                        [NSBundle mainBundle],
                                                        @"'%1$@' is a great letter!",
                                                        @"ex.  'p' is a greate letter!");
  NSString *letter = [self.titles objectAtIndex:aIndexPath.row];
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

#pragma mark - UIAlertView Delegate

- (void) alertView:(UIAlertView *) aAlertView clickedButtonAtIndex:(NSInteger) aIndex {
  NSLog(@"alert view button touched: %d", aIndex);
  // nothing to do really
}


#pragma mark - Actions

#pragma mark - Animations

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  UITableView *table = (UITableView *)[self.view viewWithTag:kTagTable];
  if (table == nil) {
    CGFloat height = [BrGlobals isDeviceIphone5] ? 367 + 88 : 367;
    
    CGRect rect = CGRectMake(0, 0, 320, height);
    
    UITableViewStyle style = UITableViewStylePlain;
    table  = [[UITableView alloc] initWithFrame:rect
                                          style:style];
    table.bounds = rect;
    table.backgroundColor = [UIColor whiteColor];
    [table setAutoresizesSubviews:YES];
    [table setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    table.accessibilityIdentifier = @"alphabet";
    table.tag = kTagTable;
    [self.view addSubview:table];
  } else {
    [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                 atScrollPosition:UITableViewScrollPositionTop
                         animated:NO];
  }
  
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
} 

@end
