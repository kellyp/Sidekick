//
//  MainViewController.m
//  Psydekick
//
//  Created by kelly on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "PKNameDataSource.h"
#import "PKNameDelegate.h"



@implementation MainViewController

@synthesize namePickerView;

@synthesize firstNameField;
@synthesize middleNameField;
@synthesize lastNameField;
@synthesize bamView;
@synthesize blamView;
@synthesize boomView;
@synthesize clangView;
@synthesize tableViewController;
@synthesize animationView;
@synthesize nameContainerView;
@synthesize createButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    names = [[NSArray arrayWithObjects:@"BAM", @"BLAM", @"CLANG", @"BOOM", nil] retain];;
    
    namePickerView.dataSource = [[PKNameDataSource alloc] init];
    namePickerView.delegate = [[PKNameDelegate alloc] initWithViewController: self];

    UIFont *font = [UIFont fontWithName:@"Comic Book" size: 36];
    lastNameField.font = middleNameField.font = firstNameField.font = font;
    
    [self.view insertSubview:[tableViewController view] atIndex:0];
    
    [self createName:self];
}


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction) resetView: (id) sender
{
    nameContainerView.moving = NO;
    [UIView beginAnimations:@"moving" context:nil];
    [UIView setAnimationDuration:.75];
    nameContainerView.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}

-(void) animateViews: (NSString*) animationID finished:(NSNumber*) finished context:(void*) context
{
    UIView *view = nil;
    NSString *newAnimationId  = nil;
    [self resetView:self];
    
    
    if (animationID == @"BAM") {
        view = bamView;
    }else if (animationID == @"BLAM"){
        view = blamView;
    }else if (animationID == @"BOOM"){
        view = boomView;
    }else if (animationID == @"CLANG"){
        view = clangView;
    }   
    
    view.transform = CGAffineTransformIdentity;
    view.transform = CGAffineTransformMakeRotation(360 - random()%90);
    animationView.hidden = NO;

    animationView.alpha = 1.0;
    
    [UIView beginAnimations:newAnimationId context:NULL];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelay:.1];
    [UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationComplete)];
    view.hidden = NO;
    view.transform = CGAffineTransformMakeScale(3.0, 3.0);
//    animationView.alpha = 0.0;

    [UIView commitAnimations];
    [newAnimationId release];
    
}

-(void) animationComplete
{
    animationView.hidden = YES;
    blamView.hidden = YES;
    bamView.hidden = YES;
    boomView.hidden = YES;
    clangView.hidden = YES;
    [createButton setEnabled:YES];
}

- (IBAction)createName:(id)sender
{
    [createButton setEnabled:NO];
    [self animateViews:[names objectAtIndex:random()%3]  finished:nil context:NULL];
    [self setRandomNames];
}

-(void)setFirstName:(NSString*)first middle:(NSString*)middle last:(NSString*)last
{
    firstNameField.text = first;
    middleNameField.text = middle;
    lastNameField.text = last;
}

-(void) setRandomNames
{
    int first =(arc4random()%((id<PKNameDataSource>)namePickerView.dataSource).firstNames.count);
    int middle = (arc4random()%((id<PKNameDataSource>)namePickerView.dataSource).middleNames.count);
    int last = (arc4random()%((id<PKNameDataSource>)namePickerView.dataSource).lastNames.count);
    [namePickerView selectRow:first+(16384/2) inComponent:0 animated:YES];
    [namePickerView selectRow:middle+(16384/2) inComponent:1 animated:YES];
    [namePickerView selectRow:last+(16384/2) inComponent:2 animated:YES];
    
    
    [self setFirstName:[((id<PKNameDataSource>)namePickerView.dataSource).firstNames objectAtIndex:(first+(16384/2))%                   ((id<PKNameDataSource>)namePickerView.dataSource).firstNames.count] 
                middle:[((id<PKNameDataSource>)namePickerView.dataSource).middleNames objectAtIndex:(middle+(16384/2))%((id<PKNameDataSource>)namePickerView.dataSource).middleNames.count]
                last:[((id<PKNameDataSource>)namePickerView.dataSource).lastNames objectAtIndex:(last+(16384/2))%((id<PKNameDataSource>)namePickerView.dataSource).lastNames.count ]];
}


- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
    controller.delegate = self;
    
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
    
    [controller release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [names release];
    [super dealloc];
}

@end
