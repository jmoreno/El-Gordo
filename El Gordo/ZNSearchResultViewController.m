//
//  ZNSearchResultViewController.m
//  El Gordo
//
//  Created by Javi on 20/12/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import "ZNSearchResultViewController.h"
#import "AFHTTPRequestOperation.h"
#import "Numeros.h"

@interface ZNSearchResultViewController ()

@end

@implementation ZNSearchResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (_numeroStored) {
        _numero = [_numeroStored.numero integerValue];
        _premioLabel.text = _numeroStored.premio;
    }
    _numeroLabel.text = [NSString stringWithFormat:@"%i", _numero];
    [self checkNumber];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lottery API Methods

- (void)checkNumber
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.elpais.com/ws/LoteriaNavidadPremiados?n=%i", _numero]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = operation.responseString;
        response = [response stringByReplacingOccurrencesOfString:@"busqueda=" withString:@""];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        
        NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"StatusList" ofType:@"plist"];
        NSArray *statusArray = [NSArray arrayWithContentsOfFile:plistPath];
        
        _premioLabel.text = [NSString stringWithFormat:@"%@ €.", [json[@"premio"] description]];
        _statusLabel.text = [statusArray objectAtIndex:[json[@"status"] doubleValue]];
        
        if (_numeroStored) {
            [self saveNumber:nil];
        }
        
        if ([json[@"error"] intValue] == 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Se ha producido un Error. Disculpe las molestias." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
        app.networkActivityIndicatorVisible = NO;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Se ha producido el siguiente error: %@", [error localizedDescription]);
        app.networkActivityIndicatorVisible = NO;
    }];
    
    [operation start];
}

- (IBAction)saveNumber:(id)sender {
    [self checkNumberIfNumberIsSaved];
    if (!_numeroStored) {
        _numeroStored = [NSEntityDescription insertNewObjectForEntityForName:@"Numeros" inManagedObjectContext:_managedObjectContext];
    }
    _numeroStored.numero = [NSNumber numberWithInteger:_numero];
    _numeroStored.premio = _premioLabel.text;
    NSError *error;
    [_managedObjectContext save:&error];
}

- (void)checkNumberIfNumberIsSaved
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Numeros" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"numero == %@", [NSNumber numberWithInteger:_numero]];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *arrayFetchRequest = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if ([arrayFetchRequest count] > 0) {
        _numeroStored = [arrayFetchRequest objectAtIndex:0];
    }
    
}



@end
