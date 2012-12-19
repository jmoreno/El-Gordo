//
//  ZNAppDelegate.h
//  El Gordo
//
//  Created by Javi on 19/12/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
