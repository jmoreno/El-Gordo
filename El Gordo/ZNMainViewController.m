//
//  ZNMainViewController.m
//  El Gordo
//
//  Created by Javi on 19/12/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import "ZNMainViewController.h"
#import "ZNSearchResultViewController.h"
#import "ZNFavoritesListViewController.h"
#import "AFHTTPRequestOperation.h"

@interface ZNMainViewController ()

@end

@implementation ZNMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self checkStatus];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showFavorites"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ZNFavoritesListViewController *favoritesListViewController = [[navigationController viewControllers] objectAtIndex:0];
        favoritesListViewController.managedObjectContext = _managedObjectContext;
    } else if ([[segue identifier] isEqualToString:@"searchNumber"]) {
        [[segue destinationViewController] setNumero:[_numberTextField.text integerValue]];
        [[segue destinationViewController] setManagedObjectContext:_managedObjectContext];
        _numberTextField.text = nil;
        
    }
}

#pragma mark - Lottery API Methods

- (void)checkStatus
{
    NSURL *url = [NSURL URLWithString:@"http://api.elpais.com/ws/LoteriaNavidadPremiados?s=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = operation.responseString;
        response = [response stringByReplacingOccurrencesOfString:@"info=" withString:@""];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        
        NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"StatusList" ofType:@"plist"];
        NSArray *statusArray = [NSArray arrayWithContentsOfFile:plistPath];
        
        _statusTextView.text = [statusArray objectAtIndex:[json[@"status"] intValue]];
        
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

- (IBAction)searchForResult:(id)sender {
    if (_numberTextField.text.length > 0 && _numberTextField.text.length < 6) {
        [_numberTextField resignFirstResponder];
        [self performSegueWithIdentifier:@"searchNumber" sender:sender];
    } else if (_numberTextField.text.length > 5) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"El número debe ser inferior a 99999" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else if (_numberTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Debe introducir un número" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

@end
