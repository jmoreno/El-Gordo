//
//  ZNResultsViewController.m
//  El Gordo
//
//  Created by Javi on 20/12/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import "ZNResultsViewController.h"
#import "AFHTTPRequestOperation.h"

@interface ZNResultsViewController ()

@end

@implementation ZNResultsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(checkResults)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    [self checkResults];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}
//
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)doneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Lottery API Methods

- (void)checkResults
{
    NSURL *url = [NSURL URLWithString:@"http://api.elpais.com/ws/LoteriaNavidadPremiados?n=resumen"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = operation.responseString;
        response = [response stringByReplacingOccurrencesOfString:@"premios=" withString:@""];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        
        if ([json[@"numero1"] intValue] > 0) {
            _numero1Label.text = [NSString stringWithFormat:@"%i", [json[@"numero1"] intValue]];
        }
        if ([json[@"numero2"] intValue] > 0) {
            _numero2Label.text = [NSString stringWithFormat:@"%i", [json[@"numero2"] intValue]];
        }
        if ([json[@"numero3"] intValue] > 0) {
            _numero3Label.text = [NSString stringWithFormat:@"%i", [json[@"numero3"] intValue]];
        }
        if ([json[@"numero4"] intValue] > 0) {
            _numero4Label.text = [NSString stringWithFormat:@"%i", [json[@"numero4"] intValue]];
        }
        if ([json[@"numero5"] intValue] > 0) {
            _numero5Label.text = [NSString stringWithFormat:@"%i", [json[@"numero5"] intValue]];
        }
        if ([json[@"numero6"] intValue] > 0) {
            _numero6Label.text = [NSString stringWithFormat:@"%i", [json[@"numero6"] intValue]];
        }
        if ([json[@"numero7"] intValue] > 0) {
            _numero7Label.text = [NSString stringWithFormat:@"%i", [json[@"numero7"] intValue]];
        }
        if ([json[@"numero8"] intValue] > 0) {
            _numero8Label.text = [NSString stringWithFormat:@"%i", [json[@"numero8"] intValue]];
        }
        if ([json[@"numero9"] intValue] > 0) {
            _numero9Label.text = [NSString stringWithFormat:@"%i", [json[@"numero9"] intValue]];
        }
        if ([json[@"numero10"] intValue] > 0) {
            _numero10Label.text = [NSString stringWithFormat:@"%i", [json[@"numero10"] intValue]];
        }
        if ([json[@"numero11"] intValue] > 0) {
            _numero11Label.text = [NSString stringWithFormat:@"%i", [json[@"numero11"] intValue]];
        }
        if ([json[@"numero12"] intValue] > 0) {
            _numero12Label.text = [NSString stringWithFormat:@"%i", [json[@"numero12"] intValue]];
        }
        if ([json[@"numero13"] intValue] > 0) {
            _numero13Label.text = [NSString stringWithFormat:@"%i", [json[@"numero13"] intValue]];
        }
        
        [self.tableView reloadData];
        
        [self.refreshControl endRefreshing];
        
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


@end
