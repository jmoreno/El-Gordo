//
//  ZNMainViewController.h
//  El Gordo
//
//  Created by Javi on 19/12/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

@interface ZNMainViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UITextField *numberTextField;
@property (strong, nonatomic) IBOutlet UITextView *statusTextView;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

- (IBAction)searchForResult:(id)sender;

@end
