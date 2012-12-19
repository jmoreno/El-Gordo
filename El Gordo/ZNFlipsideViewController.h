//
//  ZNFlipsideViewController.h
//  El Gordo
//
//  Created by Javi on 19/12/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZNFlipsideViewController;

@protocol ZNFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(ZNFlipsideViewController *)controller;
@end

@interface ZNFlipsideViewController : UIViewController

@property (weak, nonatomic) id <ZNFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
