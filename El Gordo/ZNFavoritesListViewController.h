//
//  ZNFavoritesListViewController.h
//  El Gordo
//
//  Created by Javi on 21/12/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNFavoritesListViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)doneAction:(id)sender;

@end
