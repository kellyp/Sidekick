//
//  FlipsideViewController.m
//  Psydekick
//
//  Created by kelly on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize delegate=_delegate;
@synthesize firstName;
@synthesize middleName;
@synthesize lastName;
@synthesize version;


- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
    self.version.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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


#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Received Response with length- %lld", [response expectedContentLength]);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Recieve Data - %s", [data bytes]);
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    [self displayAlertWithMessage:@"Unable to submit. Make sure you are connected to the internet."];
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    [self displayAlertWithMessage:@"Name uploaded to server, though not all names will be used, Thanks!"];
    
    // release the connection, and the data object
    [connection release];
}

#pragma mark - Actions

- (IBAction)hideKeyboard:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)submit:(id)sender
{
    if (firstName.text.length > 0 || middleName.text.length > 0 || lastName.text.length > 0){
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                        [NSURL URLWithString:@"http://psydekick.heroku.com/names.json"]];
        NSString *json = [NSString stringWithFormat:@"name={\"first_name\":\"%@\",\"middle_name\":\"%@\",\"last_name\":\"%@\"}&key=\"45623245234523452345ab3c23\"",
                          firstName.text, middleName.text, lastName.text];
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody: data];
        [request setHTTPMethod:@"POST"];


        
        if([[NSURLConnection alloc] initWithRequest:request delegate:self] == nil){
            [self displayAlertWithMessage:@"Unable to submit. Make sure you are connected to the internet."];
        }        
    }else{
        [self displayAlertWithMessage:@"Please enter first, middle or last names."];
    }
}

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
