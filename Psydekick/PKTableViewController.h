//
//  PKTableViewController.h
//  Sidekick
//
//  Created by kelly on 4/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKContainerView.h"

@interface PKTableViewController : UITableViewController {
    CGRect tableViewFrame;
}
@property(nonatomic, retain) IBOutlet UITableViewCell *firstNameCell;
@property(nonatomic, retain) IBOutlet UITableViewCell *middleNameCell;
@property(nonatomic, retain) IBOutlet UITableViewCell *lastNameCell;
@property(nonatomic, retain) IBOutlet UITableViewCell *submitButtonCell;

@property(nonatomic, retain) IBOutlet UIButton *submitButton;
@property(nonatomic, retain) IBOutlet PKContainerView *topView;


-(IBAction) nextButton:(id) sender;
-(IBAction) goButton:(id) sender;
-(IBAction) showView:(id) sender;
-(IBAction) hideView:(id) sender;

- (void) displayAlertWithMessage:(NSString*)message;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;



@end


#pragma mark - PKTableView

@interface PKTableView : UITableView {
@private
    CGPoint touchPoint;
}


@end