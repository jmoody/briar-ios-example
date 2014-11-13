#import "BrWebViewController.h"

@interface BrWebViewController () <UIWebViewDelegate>

@end

@implementation BrWebViewController

- (id) init {
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"Web", @"webview controller: tab bar button");
    self.tabBarItem.image = [UIImage imageNamed:@"first"];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.webView.delegate = self;
  self.webView.scalesPageToFit = YES;

  NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"webview-scaffold" ofType:@"html"];
  NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];

  [self.webView loadHTMLString:htmlString baseURL:nil];
  self.view.accessibilityIdentifier = @"webViewPage";
}

- (void)loadRequestFromString:(NSString*)urlString {
  NSURL *url = [NSURL URLWithString:urlString];
  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
  [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

# pragma mark - UIWebViewDelegate methods

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  NSLog(@"%@", error);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  NSLog(@"Finished loading.");
}

@end
