//
//  FlipsideViewController.h
//  Psydekick
//
//  Created by kelly on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlipsideViewControllerDelegate;

@interface FlipsideViewController : UIViewController {

}


@property (nonatomic, assign) IBOutlet UITextField *firstName;
@property (nonatomic, assign) IBOutlet UITextField *middleName;
@property (nonatomic, assign) IBOutlet UITextField *lastName;

@property (nonatomic, assign) IBOutlet UILabel *version;

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)submit:(id)sender;

- (IBAction)done:(id)sender;

- (IBAction)hideKeyboard:(id)sender;

- (void) displayAlertWithMessage:(NSString*)message;

@end




@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end
