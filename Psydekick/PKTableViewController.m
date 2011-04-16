//
//  PKTableViewController.m
//  Sidekick
//
//  Created by kelly on 4/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PKTableViewController.h"


@implementation PKTableViewController

@synthesize firstNameCell;
@synthesize middleNameCell;
@synthesize lastNameCell;
@synthesize submitButtonCell;
@synthesize topView;
@synthesize submitButton;

-(IBAction) showView:(id) sender
{    
    CGRect frame = [self.tableView frame];
    float height = 0;
    float y = 0;
    switch ([sender tag]) {
        case 2:
            y = -30;
            height = [[UIScreen mainScreen] bounds].size.height /2 + 45;
            break;
        case 3:
            y = - 60;
            height = [[UIScreen mainScreen] bounds].size.height / 2 + 65;
        default:
            break;
    }
    
    [UIView beginAnimations:@"resize table view" context:nil];
    [UIView setAnimationDelay:.25];
    [UIView setAnimationDuration:.5];
    self.tableView.frame = CGRectMake(frame.origin.x, y, frame.size.width, 
                                      height);
    [UIView commitAnimations];
}

-(IBAction) hideView:(id) sender
{
    [UIView beginAnimations:@"return table view" context:nil];
    [UIView setAnimationDuration:.25];
    self.tableView.frame = tableViewFrame;
    [UIView commitAnimations];
}

-(IBAction) nextButton:(id) sender
{
    
}

-(IBAction) goButton:(id) sender
{
    [sender setEnabled:NO];
    NSString *firstName = ((UITextField*)[firstNameCell viewWithTag:1]).text;
    NSString *middleName = ((UITextField*)[middleNameCell viewWithTag:2]).text;
    NSString *lastName = ((UITextField*)[lastNameCell viewWithTag:3]).text;
    
    if (firstName.length > 0 || middleName.length > 0 || lastName.length > 0){
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                        [NSURL URLWithString:@"http://psydekick.heroku.com/names.json"]];
        NSString *json = [NSString stringWithFormat:@"name={\"first_name\":\"%@\",\"middle_name\":\"%@\",\"last_name\":\"%@\"}&key=\"45623245234523452345ab3c23\"",
                          firstName, middleName, lastName];
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody: data];
        [request setHTTPMethod:@"POST"];
        
        
        
        if([[NSURLConnection alloc] initWithRequest:request delegate:self] == nil){
            [self displayAlertWithMessage:@"Unable to submit. Make sure you are connected to the internet."];
            [submitButton setEnabled:YES];
        }else{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
    }else{
        [self displayAlertWithMessage:@"Please enter first, middle or last names."];
        [submitButton setEnabled:YES];
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    submitButtonCell.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    submitButtonCell.backgroundView.backgroundColor = [UIColor clearColor];
    tableViewFrame = self.tableView.frame;
    
}

- (void) displayAlertWithMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert autorelease];
    [alert show];
    
}

#pragma mark - TableViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
    if(section == 0)
        return @"Submit a New Name";
    if(section == 1)
        return @"";
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if([indexPath section] == 0)
        switch([indexPath row]){
            case 0:
                return firstNameCell;
                
            case 1:
                return middleNameCell;
                
            case 2:
                return lastNameCell;
        }
    if([indexPath section] == 1)
        return submitButtonCell;
    
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 3;
    else
        return 1;
}



#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{

}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    [self displayAlertWithMessage:@"Unable to submit. Make sure you are connected to the internet."];
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [submitButton setEnabled:YES];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    [self displayAlertWithMessage:@"Name uploaded to server, though not all names will be used, Thanks!"];
    
    // release the connection, and the data object
    [connection release];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [submitButton setEnabled:YES];
}



@end

@implementation PKTableView


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView beginAnimations:@"return table view" context:nil];
    [UIView setAnimationDuration:0.5];
    ((PKTableViewController*)self.delegate).topView.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
    ((PKTableViewController*)self.delegate).topView.moving = NO;
}

@end
