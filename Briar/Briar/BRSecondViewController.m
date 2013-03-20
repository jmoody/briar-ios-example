//
//  BRSecondViewController.m
//  Briar
//
//  Created by Joshua Moody on 3.3.13.
//  Copyright (c) 2013 Little Joy Software. All rights reserved.
//

#import "BRSecondViewController.h"

@interface BRSecondViewController ()

@end

@implementation BRSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    self.title = NSLocalizedString(@"Second", @"Second");
    self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.view.accessibilityIdentifier = @"second";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
