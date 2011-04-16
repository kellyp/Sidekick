//
//  MainViewController.h
//  Psydekick
//
//  Created by kelly on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"
#import "PKContainerView.h"




@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
    int animationState;
    NSArray * names;
}

@property(nonatomic, retain) IBOutlet UIPickerView *namePickerView; 
@property(nonatomic, retain) IBOutlet UITextField *firstNameField;
@property(nonatomic, retain) IBOutlet UITextField *middleNameField;
@property(nonatomic, retain) IBOutlet UITextField *lastNameField;
@property(nonatomic, retain) IBOutlet UIView *animationView;
@property(nonatomic, retain) IBOutlet UIImageView *bamView;
@property(nonatomic, retain) IBOutlet UIImageView *blamView;
@property(nonatomic, retain) IBOutlet UIImageView *boomView;
@property(nonatomic, retain) IBOutlet UIImageView *clangView;
@property(nonatomic, retain) IBOutlet UITableViewController *tableViewController;
@property(nonatomic, retain) IBOutlet PKContainerView *nameContainerView;
@property(nonatomic, retain) IBOutlet UIButton *createButton;


-(IBAction)showInfo:(id)sender;
-(IBAction)createName:(id)sender;
-(IBAction) resetView: (id) sender;
-(void) animateViews: (NSString*) animationID finished:(NSNumber*) finished context:(void*) context;

-(void)setFirstName:(NSString*)first middle:(NSString*)middle last:(NSString*)last;
-(void)setRandomNames;
@end
