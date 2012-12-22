//
//  Numeros.h
//  El Gordo
//
//  Created by Javi on 21/12/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Numeros : NSManagedObject

@property (nonatomic, retain) NSNumber * numero;
@property (nonatomic, retain) NSString * premio;
@property (nonatomic, retain) NSNumber * estado;
@property (nonatomic, retain) NSDate * timestamp;

@end
