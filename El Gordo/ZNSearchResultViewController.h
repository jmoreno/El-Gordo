//
//  ZNSearchResultViewController.h
//  El Gordo
//
//  Created by Javi on 20/12/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Numeros;

@interface ZNSearchResultViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UILabel *numeroLabel;
@property (strong, nonatomic) IBOutlet UILabel *premioLabel;
@property (strong, nonatomic) IBOutlet UITextView *statusLabel;
@property NSInteger numero;
@property (strong, nonatomic) Numeros *numeroStored;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;

- (IBAction)saveNumber:(id)sender;

@end
