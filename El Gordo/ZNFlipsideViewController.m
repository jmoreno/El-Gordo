//
//  ZNFlipsideViewController.m
//  El Gordo
//
//  Created by Javi on 19/12/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import "ZNFlipsideViewController.h"

@interface ZNFlipsideViewController ()

@end

@implementation ZNFlipsideViewController

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
