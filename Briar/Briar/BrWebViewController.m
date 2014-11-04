//
//  BrWebViewController.m
//
//
//  Created by Joshua Moody on 4.11.14.
//
//

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
  NSString* htmlStr = @"<html><head><meta charset='utf-8'></meta></head><body><h1>Hi!</h1></body></head>";
  [self.webView loadHTMLString:htmlStr baseURL:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

# pragma mark - UIWebViewDelegate methods

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  NSLog(@"%@", error);
}

@end
